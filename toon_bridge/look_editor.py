"""Look Editor: edit a look's EEVEE node graph from inside Maya, with a live preview.

    Toon Bridge > Look Editor...      or the "Edit looks" button in the panel
    from toon_bridge import look_editor; look_editor.show("pop_comic")

  left    the look library (new / duplicate / rename / delete)
  middle  the look's node graph, drawn like Blender's node editor. Click a node
          to edit it; click the dot in an optional node's header to switch it on/off.
  right   the selected node's settings and a preview Blender renders in the
          background as you edit (a test swatch, or this frame of your shot).
Save writes blender/looks.json; the next render uses it (no rebuild step).
"""
import copy
import json
import os
import tempfile

import maya.cmds as cmds
from maya.app.general.mayaMixin import MayaQWidgetDockableMixin

try:
    from PySide6 import QtCore, QtGui, QtWidgets
except ImportError:
    from PySide2 import QtCore, QtGui, QtWidgets

from . import exporter, launcher, lookdefs
from . import graph_model as gm
from .ui import QSS, ACCENT, Combo, DoubleSpinBox, SpinBox, segmented

WINDOW = "toonBridgeLookEditor"
REPO = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
LOOKS_JSON = os.path.join(REPO, "blender", "looks.json")
WORK = os.path.join(tempfile.gettempdir(), "toon_bridge_look_editor")

# node id -> (title, category, column, row). Two rows, read left to right like Blender.
LAYOUT = {
    "light": ("Light", "shader", 0, 1),
    "base": ("Base Colour", "input", 3, 0),
    "bands": ("Bands", "color", 2, 1),
    "saturation": ("Saturation", "color", 4, 1),
    "specular": ("Specular", "shader", 0, 2),
    "halftone": ("Halftone Dots", "texture", 1, 2),
    "hatching": ("Hatching", "texture", 2, 2),
    "rim": ("Rim Light", "converter", 3, 2),
    "output": ("Emission Output", "output", 4, 2),
    "outline": ("Outline (on the object)", "outline", 0, 0),
}
STR = ("s2rgb", "Shader to RGB", "converter", 1, 1)       # fixed node, nothing to edit
MULT = ("mult", "Base × Bands", "color", 3, 1)
HEADER = {"input": "#8a3a55", "shader": "#2f7a52", "color": "#8a7a2a", "converter": "#2d6390",
          "texture": "#9a5c2a", "output": "#8a3434", "outline": "#555560"}
NODE_W, NODE_H, COL_W, ROW_H = 150, 92, 190, 128
HELP = {
    "light": "A white diffuse surface lit by the scene's lights. This is what the toon look reads.",
    "s2rgb": "Shader to RGB turns the lit result into a plain value (EEVEE only): how lit each pixel is, 0 to 1.",
    "base": "The colour the bands multiply.",
    "bands": "The toon bands: a Color Ramp with Constant steps, read by how lit each pixel is. "
             "Each stop's colour multiplies the base colour from that light level up.",
    "mult": "Base colour times the band colour.",
    "saturation": "Pushes colours away from grey (1 = unchanged). Pop art likes 1.3 to 1.5.",
    "specular": "A hard highlight: a glossy reflection, cut at a threshold.",
    "halftone": "Printed dots in screen space. Dots start where the light drops below 'Starts below' "
                "and grow to 'Biggest dot' in full shadow.",
    "hatching": "Diagonal ink lines in the darkest shadow (below 'Darker than').",
    "rim": "A light edge where the surface turns away from the camera.",
    "output": "Emission: the colours above reach the image exactly (Standard view transform).",
    "outline": "A 3D outline shell around the object (used when the line style includes 3D outlines).",
}


# ---------------------------------------------------------------- small widgets
def _qcolor(rgb):
    return QtGui.QColor.fromRgbF(*[max(0.0, min(1.0, c)) for c in rgb])


class ColorButton(QtWidgets.QPushButton):
    changed = QtCore.Signal(list)

    def __init__(self, rgb=(1, 1, 1), parent=None):
        super().__init__(parent)
        self.setFixedSize(64, 24)
        self.set_color(rgb)
        self.clicked.connect(self._pick)

    def set_color(self, rgb):
        self.rgb = [float(c) for c in rgb]
        self.setStyleSheet("background:%s; border:1px solid #555; border-radius:5px;" % _qcolor(self.rgb).name())

    def _pick(self):
        c = QtWidgets.QColorDialog.getColor(_qcolor(self.rgb), self, "Colour")
        if c.isValid():
            self.set_color([c.redF(), c.greenF(), c.blueF()])
            self.changed.emit(self.rgb)


class Slider(QtWidgets.QWidget):
    """Slider + number box, kept in step. Emits valueChanged(float)."""
    valueChanged = QtCore.Signal(float)

    def __init__(self, lo, hi, decimals=2, parent=None):
        super().__init__(parent)
        self.lo, self.hi, self.k = lo, hi, 10 ** decimals
        lay = QtWidgets.QHBoxLayout(self)
        lay.setContentsMargins(0, 0, 0, 0)
        self.s = QtWidgets.QSlider(QtCore.Qt.Horizontal)
        self.s.setRange(int(lo * self.k), int(hi * self.k))
        self.s.setFocusPolicy(QtCore.Qt.StrongFocus)
        self.b = DoubleSpinBox()
        self.b.setRange(lo, hi)
        self.b.setDecimals(decimals)
        self.b.setSingleStep(1.0 / self.k * (10 if decimals else 1))
        self.b.setFixedWidth(70)
        lay.addWidget(self.s, 1)
        lay.addWidget(self.b)
        self.s.valueChanged.connect(lambda v: self._set(v / float(self.k), from_slider=True))
        self.b.valueChanged.connect(lambda v: self._set(v, from_slider=False))

    def _set(self, v, from_slider):
        self.blockSignals(True)
        if from_slider:
            self.b.blockSignals(True)
            self.b.setValue(v)
            self.b.blockSignals(False)
        else:
            self.s.blockSignals(True)
            self.s.setValue(int(round(v * self.k)))
            self.s.blockSignals(False)
        self.blockSignals(False)
        self.valueChanged.emit(float(v))

    def setValue(self, v):
        for w in (self.s, self.b):
            w.blockSignals(True)
        self.s.setValue(int(round(v * self.k)))
        self.b.setValue(v)
        for w in (self.s, self.b):
            w.blockSignals(False)

    def value(self):
        return self.b.value()


class RampEditor(QtWidgets.QWidget):
    """A Constant colour ramp like Blender's: drag stops, double-click to add."""
    changed = QtCore.Signal()
    selected = QtCore.Signal(int)

    def __init__(self, parent=None):
        super().__init__(parent)
        self.bands = [[0.0, [0.5, 0.5, 0.5]], [0.5, [1, 1, 1]]]
        self.current = 0
        self._drag = None
        self.setMinimumHeight(54)
        self.setMouseTracking(True)

    def set_bands(self, bands):
        self.bands = [[float(p), list(c)] for p, c in bands]
        self.current = min(self.current, len(self.bands) - 1)
        self.update()

    def _x(self, pos):
        return 8 + pos * (self.width() - 16)

    def _pos(self, x):
        return max(0.0, min(1.0, (x - 8) / float(max(1, self.width() - 16))))

    def paintEvent(self, _ev):
        p = QtGui.QPainter(self)
        p.setRenderHint(QtGui.QPainter.Antialiasing)
        bar = QtCore.QRectF(8, 4, self.width() - 16, 26)
        order = sorted(range(len(self.bands)), key=lambda i: self.bands[i][0])
        for n, i in enumerate(order):
            x0 = self._x(self.bands[i][0]) if n else bar.left()
            x1 = self._x(self.bands[order[n + 1]][0]) if n + 1 < len(order) else bar.right()
            p.fillRect(QtCore.QRectF(x0, bar.top(), x1 - x0, bar.height()), _qcolor(self.bands[i][1]))
        p.setPen(QtGui.QPen(QtGui.QColor("#555"), 1))
        p.drawRect(bar)
        for i, (pos, col) in enumerate(self.bands):
            x = self._x(pos)
            tri = QtGui.QPolygonF([QtCore.QPointF(x, 32), QtCore.QPointF(x - 7, 46), QtCore.QPointF(x + 7, 46)])
            p.setBrush(_qcolor(col))
            p.setPen(QtGui.QPen(QtGui.QColor(ACCENT if i == self.current else "#ddd"), 2 if i == self.current else 1))
            p.drawPolygon(tri)
        p.end()

    def _hit(self, x):
        best = min(range(len(self.bands)), key=lambda i: abs(self._x(self.bands[i][0]) - x))
        return best if abs(self._x(self.bands[best][0]) - x) < 10 else None

    def mousePressEvent(self, ev):
        i = self._hit(ev.position().x() if hasattr(ev, "position") else ev.x())
        if i is not None:
            self.current, self._drag = i, i
            self.selected.emit(i)
            self.update()

    def mouseMoveEvent(self, ev):
        if self._drag is not None and self._drag != 0:      # the first stop stays at 0
            x = ev.position().x() if hasattr(ev, "position") else ev.x()
            self.bands[self._drag][0] = round(self._pos(x), 3)
            self.update()
            self.changed.emit()

    def mouseReleaseEvent(self, _ev):
        self._drag = None

    def mouseDoubleClickEvent(self, ev):
        pos = round(self._pos(ev.position().x() if hasattr(ev, "position") else ev.x()), 3)
        below = [b for b in self.bands if b[0] <= pos]
        col = list(max(below, key=lambda b: b[0])[1]) if below else [1, 1, 1]
        self.bands.append([pos, col])
        self.current = len(self.bands) - 1
        self.selected.emit(self.current)
        self.update()
        self.changed.emit()


# ---------------------------------------------------------------- node graph
class NodeItem(QtWidgets.QGraphicsObject):
    clicked = QtCore.Signal(str)
    toggled = QtCore.Signal(str)

    def __init__(self, key, title, category, optional):
        super().__init__()
        self.key, self.title, self.category, self.optional = key, title, category, optional
        self.enabled = True
        self.summary = ""
        self.swatch = None        # list of (pos, rgb) for the bands strip, or a single rgb
        self.selected_node = False
        self.setCursor(QtCore.Qt.PointingHandCursor)
        self.setAcceptHoverEvents(True)

    def boundingRect(self):
        return QtCore.QRectF(-2, -2, NODE_W + 4, NODE_H + 4)

    def in_socket(self):
        return self.mapToScene(QtCore.QPointF(0, 44))

    def out_socket(self):
        return self.mapToScene(QtCore.QPointF(NODE_W, 44))

    def paint(self, p, _opt, _w=None):
        p.setRenderHint(QtGui.QPainter.Antialiasing)
        dim = not self.enabled
        body = QtCore.QRectF(0, 0, NODE_W, NODE_H)
        path = QtGui.QPainterPath()
        path.addRoundedRect(body, 7, 7)
        p.fillPath(path, QtGui.QColor("#303034" if not dim else "#29292c"))
        head = QtGui.QPainterPath()
        head.addRoundedRect(QtCore.QRectF(0, 0, NODE_W, 24), 7, 7)
        head.addRect(QtCore.QRectF(0, 12, NODE_W, 12))
        hc = QtGui.QColor(HEADER[self.category])
        if dim:
            hc = hc.darker(220)
        p.fillPath(head.simplified(), hc)
        pen = QtGui.QPen(QtGui.QColor(ACCENT) if self.selected_node else QtGui.QColor("#18181a"),
                         2.2 if self.selected_node else 1)
        if dim:
            pen.setStyle(QtCore.Qt.DashLine)
        p.setPen(pen)
        p.drawPath(path)
        p.setPen(QtGui.QColor("#f2f0ec" if not dim else "#8a8890"))
        f = QtGui.QFont()
        f.setPointSizeF(9.5)
        f.setBold(True)
        p.setFont(f)
        p.drawText(QtCore.QRectF(10, 0, NODE_W - 34, 24), QtCore.Qt.AlignVCenter, self.title)
        if self.optional:      # on/off dot in the header
            r = QtCore.QRectF(NODE_W - 22, 6, 12, 12)
            p.setBrush(QtGui.QColor("#3ecf8e") if self.enabled else QtGui.QColor("#555"))
            p.setPen(QtGui.QPen(QtGui.QColor("#111"), 1))
            p.drawEllipse(r)
        f.setBold(False)
        f.setPointSizeF(8.5)
        p.setFont(f)
        p.setPen(QtGui.QColor("#c9c6cc" if not dim else "#6f6d74"))
        p.drawText(QtCore.QRectF(10, 30, NODE_W - 20, 26), QtCore.Qt.AlignLeft | QtCore.Qt.TextWordWrap,
                   "off" if dim else self.summary)
        if isinstance(self.swatch, list) and self.swatch and isinstance(self.swatch[0], list) and not dim:
            strip = QtCore.QRectF(10, 62, NODE_W - 20, 16)
            order = sorted(self.swatch, key=lambda b: b[0])
            for n, (pos, col) in enumerate(order):
                x0 = strip.left() + (pos if n else 0) * strip.width()
                x1 = strip.left() + (order[n + 1][0] if n + 1 < len(order) else 1) * strip.width()
                p.fillRect(QtCore.QRectF(x0, strip.top(), x1 - x0, strip.height()), _qcolor(col))
            p.setPen(QtGui.QPen(QtGui.QColor("#111"), 1))
            p.setBrush(QtCore.Qt.NoBrush)
            p.drawRect(strip)
        elif self.swatch is not None and not dim:
            p.setBrush(_qcolor(self.swatch))
            p.setPen(QtGui.QPen(QtGui.QColor("#111"), 1))
            p.drawRoundedRect(QtCore.QRectF(10, 62, 30, 16), 3, 3)
        for x in (0, NODE_W):    # sockets
            p.setBrush(QtGui.QColor("#c7b54a" if not dim else "#555"))
            p.setPen(QtGui.QPen(QtGui.QColor("#111"), 1))
            p.drawEllipse(QtCore.QPointF(x, 44), 4.5, 4.5)

    def mousePressEvent(self, ev):
        if self.optional and QtCore.QRectF(NODE_W - 26, 2, 22, 22).contains(ev.pos()):
            self.toggled.emit(self.key)
        else:
            self.clicked.emit(self.key)


class NodeGraph(QtWidgets.QGraphicsView):
    """The look's node tree, drawn from the template. Links follow the chain."""
    nodeClicked = QtCore.Signal(str)
    nodeToggled = QtCore.Signal(str)

    CHAIN = ["light", "s2rgb", "bands", "mult", "saturation", "specular", "halftone", "hatching", "rim", "output"]

    def __init__(self, parent=None):
        super().__init__(parent)
        self.setScene(QtWidgets.QGraphicsScene(self))
        self.setRenderHint(QtGui.QPainter.Antialiasing)
        self.setFrameShape(QtWidgets.QFrame.NoFrame)
        self.setHorizontalScrollBarPolicy(QtCore.Qt.ScrollBarAlwaysOff)
        self.setVerticalScrollBarPolicy(QtCore.Qt.ScrollBarAlwaysOff)
        self.items = {}
        self.links = []
        defs = dict((k, v) for k, v in LAYOUT.items())
        defs["s2rgb"] = STR[1:]
        defs["mult"] = MULT[1:]
        for key, (title, cat, col, row) in defs.items():
            it = NodeItem(key, title, cat, key in lookdefs.OPTIONAL)
            it.setPos(20 + col * COL_W, 20 + row * ROW_H)
            it.clicked.connect(self.nodeClicked)
            it.toggled.connect(self.nodeToggled)
            self.scene().addItem(it)
            self.items[key] = it
        self.setSceneRect(0, 0, 20 + 4 * COL_W + NODE_W + 40, 20 + 2 * ROW_H + NODE_H + 20)

    def resizeEvent(self, ev):
        super().resizeEvent(ev)
        self.fitInView(self.sceneRect(), QtCore.Qt.KeepAspectRatio)

    def _link(self, a, b, dashed=False, color="#c7b54a"):
        p1, p2 = a.out_socket(), b.in_socket()
        path = QtGui.QPainterPath(p1)
        if p2.x() < p1.x() + 20:
            # the wire goes back left (row wrap, or Base Colour down into the multiply):
            # an elbow through the gap between the rows, never across the nodes
            gap_y = (a.sceneBoundingRect().bottom() + b.sceneBoundingRect().top()) / 2.0
            if b.sceneBoundingRect().top() < a.sceneBoundingRect().bottom():
                gap_y = b.sceneBoundingRect().top() - 18
            x1, x2 = p1.x() + 16, p2.x() - 16
            for pt in [(x1, p1.y()), (x1, gap_y), (x2, gap_y), (x2, p2.y()), (p2.x(), p2.y())]:
                path.lineTo(QtCore.QPointF(*pt))
        else:
            dx = max(40.0, abs(p2.x() - p1.x()) * 0.5)
            path.cubicTo(p1 + QtCore.QPointF(dx, 0), p2 - QtCore.QPointF(dx, 0), p2)
        self.links.append((path, dashed, color))

    def drawBackground(self, painter, rect):
        """Wires are painted here, not kept as scene items: once Maya re-parents the window,
        Qt can delete item objects behind Python's back (seen live: 'already deleted')."""
        painter.fillRect(rect, QtGui.QColor("#1d1d20"))
        painter.setRenderHint(QtGui.QPainter.Antialiasing)
        for path, dashed, color in self.links:
            pen = QtGui.QPen(QtGui.QColor(color), 2)
            if dashed:
                pen.setStyle(QtCore.Qt.DashLine)
            painter.setPen(pen)
            painter.setBrush(QtCore.Qt.NoBrush)
            painter.drawPath(path)

    def update_from(self, look, selected):
        lk = lookdefs.normalize(look)
        self.links = []
        for key, it in self.items.items():
            it.enabled = lk[key].get("enabled", True) if key in lookdefs.OPTIONAL else True
            it.selected_node = key == selected
            it.summary, it.swatch = summary(key, lk)
            it.update()
        # main chain: a disabled node is bypassed (dashed link past it)
        chain = [k for k in self.CHAIN]
        prev = None
        for key in chain:
            it = self.items[key]
            if prev is not None:
                self._link(self.items[prev], it, dashed=not it.enabled)
            if it.enabled or key not in lookdefs.OPTIONAL:
                prev = key
            else:
                prev = prev     # bypass: the next node links from the last enabled one
        self._link(self.items["base"], self.items["mult"])
        self.resetCachedContent()
        self.viewport().update()
        self.fit()

    def fit(self):
        self.fitInView(self.sceneRect(), QtCore.Qt.KeepAspectRatio)

    def showEvent(self, ev):
        super().showEvent(ev)
        self.fit()


def summary(key, lk):
    """Short text (and swatch) shown inside each node."""
    if key == "light":
        return "Diffuse BSDF, white", None
    if key == "s2rgb":
        return "how lit: 0 to 1", None
    if key == "base":
        return ("the object's Maya colour", None) if lk["base_color"] == "maya" else ("fixed colour", lk["base_color"])
    if key == "bands":
        return "%d bands, constant" % len(lk["bands"]), [list(b) for b in lk["bands"]]
    if key == "mult":
        return "multiply", None
    if key == "saturation":
        return "× %.2f" % lk["saturation"], None
    if key == "specular":
        sp = lk["specular"]
        return "rough %.2f, cut %.2f" % (sp["roughness"], sp["threshold"]), sp["color"]
    if key == "halftone":
        ht = lk["halftone"]
        return "%d dots / screen, below %.2f" % (ht["per_screen"], ht["below"]), ht.get("color")
    if key == "hatching":
        hc = lk["hatching"]
        return "%d lines, below %.2f" % (hc["per_screen"], hc["below"]), hc["color"]
    if key == "rim":
        r = lk["rim"]
        return "%s at %.2f" % (r.get("mode", "add"), r["threshold"]), r["color"]
    if key == "outline":
        o = lk["outline"]
        return "%.2f cm shell, 3D line style" % o["width_cm"], o["color"]
    if key == "output":
        return "colours reach the image as is", None
    return "", None


# ---------------------------------------------------------------- the window
class LookEditor(MayaQWidgetDockableMixin, QtWidgets.QWidget):
    saved = QtCore.Signal()
    FULL_HINT = ("The real EEVEE node tree. Drag a number on a node to scrub it, click it to type. Drag from an "
                 "output to an input to connect. Right-click or Shift+A adds nodes; Ctrl+G groups, Tab enters a "
                 "group, Ctrl+J frames; right-click a wire for a reroute. X deletes, F frames all, Ctrl+Z undoes.")

    def __init__(self, looks_path=LOOKS_JSON, parent=None):
        super().__init__(parent)
        self.setObjectName(WINDOW)
        self.setWindowTitle("Toon Bridge — Look Editor")
        self.setStyleSheet(QSS)
        self.looks_path = looks_path
        self.selected = "bands"
        self.preview_job = None
        self._preview_again = False
        self._preview_n = 0
        self.last_preview = None
        os.makedirs(WORK, exist_ok=True)
        self._load()

        root = QtWidgets.QHBoxLayout(self)
        root.setContentsMargins(10, 10, 10, 10)
        root.setSpacing(10)
        root.addWidget(self._build_library(), 0)
        from .graph_editor import GraphView, NodeInspector
        mid = QtWidgets.QVBoxLayout()
        top = QtWidgets.QHBoxLayout()
        self.title_lbl = QtWidgets.QLabel("")
        self.title_lbl.setStyleSheet("font-size:16px; font-weight:800;")
        top.addWidget(self.title_lbl, 1)
        mode_w, self.view_group = segmented(["Simple controls", "Full node graph"])
        for b in self.view_group.buttons():
            b.setMinimumWidth(b.fontMetrics().horizontalAdvance(b.text()) + 30)
        self.view_group.idToggled.connect(lambda i, on: on and self.set_full_mode(i == 1))
        top.addWidget(mode_w)
        mid.addLayout(top)
        self.hint_lbl = QtWidgets.QLabel("")
        self.hint_lbl.setProperty("muted", True)
        self.hint_lbl.setWordWrap(True)
        mid.addWidget(self.hint_lbl)
        self.banner = QtWidgets.QFrame()
        self.banner.setStyleSheet("QFrame{background:#3a2f22;border-radius:6px;}")
        bl = QtWidgets.QHBoxLayout(self.banner)
        bl.setContentsMargins(10, 6, 10, 6)
        self.banner_lbl = QtWidgets.QLabel("")
        self.banner_lbl.setWordWrap(True)
        self.reset_btn = QtWidgets.QPushButton("Reset to simple controls")
        self.reset_btn.clicked.connect(self.reset_to_simple)
        bl.addWidget(self.banner_lbl, 1)
        bl.addWidget(self.reset_btn)
        mid.addWidget(self.banner)
        self.stack = QtWidgets.QStackedWidget()
        self.graph = NodeGraph()
        self.graph.setMinimumSize(560, 340)
        self.graph.nodeClicked.connect(self.select_node)
        self.graph.nodeToggled.connect(self.toggle_node)
        self.full = GraphView()
        self.full.changed.connect(self._full_changed)
        self.full.nodeSelected.connect(lambda n: self.node_inspector.show_node(n))
        self.full.nodeEdited.connect(lambda n: n == self.node_inspector.name and self.node_inspector.show_node(n))
        self.full.pathChanged.connect(self._path_changed)
        self.stack.addWidget(self.graph)
        self.stack.addWidget(self.full)
        mid.addWidget(self.stack, 1)
        self.node_inspector = NodeInspector(self.full)
        self.node_inspector.edited.connect(self._full_changed)
        self.full_mode = False
        self._graph_version = 0
        self.sync_job = None
        bottom = QtWidgets.QHBoxLayout()
        self.dirty_lbl = QtWidgets.QLabel("")
        self.dirty_lbl.setProperty("muted", True)
        self.revert_btn = QtWidgets.QPushButton("Revert")
        self.revert_btn.clicked.connect(self.revert)
        self.save_btn = QtWidgets.QPushButton("Save looks")
        self.save_btn.setObjectName("primary")
        self.save_btn.clicked.connect(self.save)
        bottom.addWidget(self.dirty_lbl, 1)
        bottom.addWidget(self.revert_btn)
        bottom.addWidget(self.save_btn)
        mid.addLayout(bottom)
        root.addLayout(mid, 1)
        root.addWidget(self._build_right(), 0)
        self.right_stack.addWidget(self.node_inspector)

        self.preview_timer = QtCore.QTimer(self)
        self.preview_timer.setSingleShot(True)
        self.preview_timer.timeout.connect(self.render_preview)
        self.select_look(self.look_list.currentItem().data(QtCore.Qt.UserRole))

    # ------------------------------------------------------------ data
    def _load(self):
        with open(self.looks_path) as f:
            raw = json.load(f)
        self.doc = raw.get("_doc")
        self.looks = {k: lookdefs.normalize(v) for k, v in raw.items() if not k.startswith("_")}
        self.saved_looks = copy.deepcopy(self.looks)
        self.name = next(iter(self.looks))

    def look(self):
        return self.looks[self.name]

    def is_dirty(self):
        return self.looks != self.saved_looks

    def _changed(self, preview=True):
        self.graph.update_from(self.look(), self.selected)
        d = self.is_dirty()
        self.dirty_lbl.setText("● Unsaved changes" if d else "Saved")
        self.dirty_lbl.setStyleSheet("color:%s;" % ("#f5b83d" if d else "#9a979f"))
        self.save_btn.setEnabled(d)
        self.revert_btn.setEnabled(d)
        if preview:
            self.preview_timer.start(350)        # wait for the user to stop dragging

    def save(self, path=None):
        out = {"_doc": self.doc} if self.doc else {}
        for k, v in self.looks.items():
            out[k] = lookdefs.compact(v)
        with open(path or self.looks_path, "w") as f:
            json.dump(out, f, indent=2)
        self.saved_looks = copy.deepcopy(self.looks)
        self._changed(preview=False)
        self.status("Saved %d looks to %s. The next render uses them." % (len(self.looks), os.path.basename(path or self.looks_path)))
        self.saved.emit()

    def revert(self):
        self.looks = copy.deepcopy(self.saved_looks)
        if self.name not in self.looks:
            self.name = next(iter(self.looks))
        self._fill_library()
        self.select_look(self.name)

    # ------------------------------------------------------------ library (left)
    def _build_library(self):
        w = QtWidgets.QWidget()
        w.setFixedWidth(230)
        lay = QtWidgets.QVBoxLayout(w)
        lay.setContentsMargins(0, 0, 0, 0)
        t = QtWidgets.QLabel("Looks")
        t.setObjectName("stepTitle")
        lay.addWidget(t)
        self.look_list = QtWidgets.QListWidget()
        self.look_list.setStyleSheet("QListWidget{background:#232326;color:#e8e6e3;border:1px solid #3a3a40;"
                                     "border-radius:6px;} QListWidget::item:selected{background:#4a3540;}")
        self.look_list.setTextElideMode(QtCore.Qt.ElideRight)
        self.look_list.setHorizontalScrollBarPolicy(QtCore.Qt.ScrollBarAlwaysOff)
        self.look_list.currentItemChanged.connect(
            lambda cur, _prev: cur and self.select_look(cur.data(QtCore.Qt.UserRole)))
        lay.addWidget(self.look_list, 1)
        row = QtWidgets.QGridLayout()
        for i, (text, fn) in enumerate([("Duplicate", self.duplicate), ("New", self.new_look),
                                        ("Rename", self.rename), ("Delete", self.delete)]):
            b = QtWidgets.QPushButton(text)
            b.clicked.connect(fn)
            row.addWidget(b, i // 2, i % 2)
        lay.addLayout(row)
        self._fill_library()
        return w

    def _fill_library(self):
        self.look_list.blockSignals(True)
        self.look_list.clear()
        for k, v in self.looks.items():
            it = QtWidgets.QListWidgetItem("%s\n%s" % (v["label"], k))
            it.setData(QtCore.Qt.UserRole, k)
            self.look_list.addItem(it)
            if k == self.name:
                self.look_list.setCurrentItem(it)
        if not self.look_list.currentItem():
            self.look_list.setCurrentRow(0)
        self.look_list.blockSignals(False)

    def _unique(self, base):
        name, i = base, 2
        while name in self.looks:
            name, i = "%s_%d" % (base, i), i + 1
        return name

    def duplicate(self):
        new = self._unique(self.name + "_copy")
        self.looks[new] = copy.deepcopy(self.look())
        self.looks[new]["label"] = self.look()["label"] + " (copy)"
        self.name = new
        self._fill_library()
        self.select_look(new)
        return new

    def new_look(self):
        new = self._unique("my_look")
        self.looks[new] = lookdefs.normalize({"label": "My look"})
        self.name = new
        self._fill_library()
        self.select_look(new)
        return new

    def rename(self):
        label, ok = QtWidgets.QInputDialog.getText(self, "Rename look", "Name shown in Maya:", text=self.look()["label"])
        if ok and label:
            self.look()["label"] = label
            self._fill_library()
            self._changed(preview=False)

    def delete(self):
        if len(self.looks) <= 1:
            return
        if QtWidgets.QMessageBox.question(self, "Delete look", "Delete '%s'? Objects using it will fall back to "
                                          "toon_auto when rendered." % self.look()["label"]) != QtWidgets.QMessageBox.Yes:
            return
        del self.looks[self.name]
        self.name = next(iter(self.looks))
        self._fill_library()
        self.select_look(self.name)

    def select_look(self, name):
        if not name or name not in self.looks:
            return
        self.name = name
        self.title_lbl.setText("%s  ·  %s" % (self.look()["label"], name))
        self.src_chk.blockSignals(True)
        self.src_chk.setChecked(self.look().get("source") == "blend")
        self.src_chk.blockSignals(False)
        self.select_node(self.selected)
        self._update_banner()
        if self.full_mode:
            self._load_full_graph()
        self._changed()

    # ------------------------------------------------------------ full node graph
    def set_full_mode(self, full):
        self.full_mode = bool(full)
        self.stack.setCurrentIndex(1 if full else 0)
        self.right_stack.setCurrentIndex(1 if full else 0)
        self.hint_lbl.setText(
            self.FULL_HINT if full else "Click a node to edit it. The dot in a node's header switches it on or off.")
        if full:
            self._load_full_graph()
        self._update_banner()

    def _update_banner(self):
        has = bool(self.look().get("graph"))
        if self.full_mode:
            self.banner_lbl.setText("This look renders from this node graph." if has else
                                    "Blender's graph for this look. Your first edit makes it this look's own graph.")
        else:
            self.banner_lbl.setText("This look renders from its own full node graph, so the simple controls "
                                    "don't apply to it.")
        self.banner.setVisible(has or self.full_mode)
        self.reset_btn.setVisible(has)
        self.graph.setEnabled(not (has and not self.full_mode))
        self.inspector_host.setEnabled(not has)

    def _load_full_graph(self):
        g = self.look().get("graph")
        if g:
            self.full.undo_stack, self.full.redo_stack = [], []
            self.full.set_graph(g, keep_selection=False)
            self.node_inspector.show_node("")
        else:
            self.full.set_graph({"nodes": [], "links": []}, keep_selection=False)
            self.sync(preview=False, adopt=True)       # ask Blender for the template's graph

    def _full_changed(self, structural=True):
        if not structural and not self.look().get("graph"):
            return      # only moved nodes of Blender's template graph: the look itself is unchanged
        self.look()["graph"] = self.full.root
        self._graph_version += 1
        self._update_banner()
        self._changed(preview=False)
        if structural:
            self.preview_timer.start(400)

    def reset_to_simple(self):
        if QtWidgets.QMessageBox.question(self, "Reset look", "Drop this look's own node graph and go back to "
                                          "the simple controls?") != QtWidgets.QMessageBox.Yes:
            return
        self.look().pop("graph", None)
        self._update_banner()
        if self.full_mode:
            self._load_full_graph()
        self._changed()

    def sync(self, preview=True, adopt=False):
        """Blender rebuilds the graph and returns its exact version (+ a preview swatch)."""
        if self.sync_job and self.sync_job.running():
            self._preview_again = True
            return None
        self._preview_n += 1
        tag = "%s_%d" % (self.name, self._preview_n)
        req, resp = os.path.join(WORK, "sync_%s.json" % tag), os.path.join(WORK, "sync_%s_out.json" % tag)
        out = os.path.join(WORK, "preview_%s.png" % tag) if preview else None
        with open(req, "w") as f:
            json.dump({"name": self.name, "look": self.look()}, f)
        version, name = self._graph_version, self.name
        self.sync_job = launcher.BlenderJob(launcher.sync_command(req, resp, out, 360, 236), self)
        self.sync_job.finished.connect(lambda ok, s, r=resp, o=out, v=version, n=name, a=adopt:
                                       self._sync_done(ok, s, r, o, v, n, a))
        if preview:
            self.preview_status.setText("Rendering…")
        self.sync_job.start()
        return self.sync_job

    def _sync_done(self, ok, summary_text, resp, out, version, name, adopt):
        if ok and os.path.isfile(resp) and name == self.name:
            data = json.load(open(resp))
            for p in data.get("problems", []):
                self.status("Blender: %s" % p)
            canonical = data["graph"]
            if self.full_mode and version == self._graph_version and (adopt or self.look().get("graph")):
                before = self._structure(self.full.root)
                if self.look().get("graph"):
                    self.look()["graph"] = canonical
                elif adopt:
                    # Blender's template positions overlap: lay it out readably the first time it's shown
                    for lvl in [canonical] + [g for g in (canonical.get("groups") or {}).values() if g]:
                        gm.auto_layout(lvl)
                self.full.set_graph(canonical, keep_view=not adopt)
                if self._structure(canonical) != before:
                    self.node_inspector.show_node(self.node_inspector.name or "")
        if out:
            self._preview_done(ok, summary_text, out)
        elif self._preview_again:
            self._preview_again = False
            self.render_preview()

    @staticmethod
    def _structure(graph):
        levels = [graph] + [g for g in (graph.get("groups") or {}).values() if g]
        return [(n["name"], [(s["id"], s.get("enabled")) for s in n.get("inputs", []) + n.get("outputs", [])],
                 sorted(n.get("props", {}))) for lvl in levels for n in lvl.get("nodes", [])]

    def _path_changed(self, path):
        self.node_inspector.show_node("")
        if path:
            self.hint_lbl.setText("Inside node group  %s  ›  %s.   Tab or right-click → Leave group to go back."
                                  % (self.name, "  ›  ".join(path)))
        else:
            self.hint_lbl.setText(self.FULL_HINT)

    # ------------------------------------------------------------ right side
    def _build_right(self):
        w = QtWidgets.QWidget()
        w.setFixedWidth(380)
        lay = QtWidgets.QVBoxLayout(w)
        lay.setContentsMargins(0, 0, 0, 0)
        head = QtWidgets.QHBoxLayout()
        t = QtWidgets.QLabel("Preview")
        t.setObjectName("stepTitle")
        head.addWidget(t)
        head.addStretch(1)
        mode_w, self.mode_group = segmented(["Swatch", "This frame"])
        self.mode_group.idToggled.connect(lambda _i, on: on and self.preview_timer.start(50))
        head.addWidget(mode_w)
        lay.addLayout(head)
        self.preview = QtWidgets.QLabel("Rendering…")
        self.preview.setAlignment(QtCore.Qt.AlignCenter)
        self.preview.setFixedHeight(236)
        self.preview.setStyleSheet("background:#1b1b1d; color:#6f6d74; border-radius:8px;")
        lay.addWidget(self.preview)
        self.preview_status = QtWidgets.QLabel("")
        self.preview_status.setProperty("muted", True)
        lay.addWidget(self.preview_status)

        self.right_stack = QtWidgets.QStackedWidget()
        simple = QtWidgets.QWidget()
        sl = QtWidgets.QVBoxLayout(simple)
        sl.setContentsMargins(0, 0, 0, 0)
        self.node_title = QtWidgets.QLabel("")
        self.node_title.setObjectName("stepTitle")
        sl.addWidget(self.node_title)
        self.node_help = QtWidgets.QLabel("")
        self.node_help.setWordWrap(True)
        self.node_help.setProperty("muted", True)
        sl.addWidget(self.node_help)
        self.inspector_host = QtWidgets.QWidget()
        self.inspector = QtWidgets.QFormLayout(self.inspector_host)
        self.inspector.setLabelAlignment(QtCore.Qt.AlignRight)
        sl.addWidget(self.inspector_host)
        sl.addStretch(1)
        self.right_stack.addWidget(simple)
        lay.addWidget(self.right_stack, 1)
        self.src_chk = QtWidgets.QCheckBox("Use the version hand-edited in look_library.blend")
        self.src_chk.setToolTip("For node trees changed in Blender's own node editor. Then this editor's\n"
                                "settings are kept but not used for rendering this look.")
        self.src_chk.toggled.connect(self._toggle_source)
        lay.addWidget(self.src_chk)
        self.status_lbl = QtWidgets.QLabel("")
        self.status_lbl.setWordWrap(True)
        self.status_lbl.setProperty("muted", True)
        lay.addWidget(self.status_lbl)
        return w

    def _toggle_source(self, on):
        self.look()["source"] = "blend" if on else "json"
        self._changed(preview=False)

    def status(self, text):
        self.status_lbl.setText(text)
        print("[Toon Bridge] " + text)

    # ------------------------------------------------------------ inspector
    def _clear_inspector(self):
        while self.inspector.rowCount():
            self.inspector.removeRow(0)

    def select_node(self, key):
        self.selected = key
        titles = dict((k, v[0]) for k, v in LAYOUT.items())
        titles.update({"s2rgb": "Shader to RGB", "mult": "Base × Bands"})
        self.node_title.setText(titles.get(key, key))
        self.node_help.setText(HELP.get(key, ""))
        self._clear_inspector()
        build = getattr(self, "_inspect_" + key, None)
        if build:
            build(self.look())
        self.graph.update_from(self.look(), self.selected)

    def toggle_node(self, key):
        node = self.look()[key]
        node["enabled"] = not node.get("enabled")
        self.select_node(key)
        self._changed()

    def _set(self, path, value):
        """Set look[path...] = value and refresh."""
        d = self.look()
        for k in path[:-1]:
            d = d[k]
        d[path[-1]] = value
        self._changed()

    def _slider(self, label, path, lo, hi, dec=2):
        s = Slider(lo, hi, dec)
        d = self.look()
        for k in path:
            d = d[k]
        s.setValue(float(d))
        s.valueChanged.connect(lambda v, p=path: self._set(p, v))
        self.inspector.addRow(label, s)
        return s

    def _color(self, label, path):
        d = self.look()
        for k in path:
            d = d[k]
        b = ColorButton(d or [0, 0, 0])
        b.changed.connect(lambda rgb, p=path: self._set(p, rgb))
        self.inspector.addRow(label, b)
        return b

    def _enable_row(self, key):
        c = QtWidgets.QCheckBox("On")
        c.setChecked(bool(self.look()[key].get("enabled")))
        c.toggled.connect(lambda on, k=key: (self._set([k, "enabled"], on), self.select_node(k)))
        self.inspector.addRow("", c)
        return c

    def _inspect_base(self, lk):
        combo = Combo()
        combo.addItem("The object's Maya colour", "maya")
        combo.addItem("A fixed colour", "fixed")
        combo.setCurrentIndex(0 if lk["base_color"] == "maya" else 1)
        self.inspector.addRow("Colour from", combo)
        btn = ColorButton(lk["base_color"] if lk["base_color"] != "maya" else [0.85, 0.55, 0.45])
        btn.setEnabled(lk["base_color"] != "maya")
        btn.changed.connect(lambda rgb: self._set(["base_color"], rgb))
        self.inspector.addRow("Colour", btn)

        def mode(_i):
            maya = combo.currentData() == "maya"
            btn.setEnabled(not maya)
            self._set(["base_color"], "maya" if maya else list(btn.rgb))
        combo.currentIndexChanged.connect(mode)

    def _inspect_bands(self, lk):
        self.ramp = RampEditor()
        self.ramp.set_bands(lk["bands"])
        self.inspector.addRow(self.ramp)
        hint = QtWidgets.QLabel("Drag a stop to move it, double-click the bar to add one.")
        hint.setProperty("muted", True)
        self.inspector.addRow(hint)
        self.stop_pos = Slider(0, 1, 3)
        self.stop_col = ColorButton()
        rm = QtWidgets.QPushButton("Remove stop")
        self.inspector.addRow("Position", self.stop_pos)
        self.inspector.addRow("Colour", self.stop_col)
        self.inspector.addRow("", rm)

        def show_stop(i):
            pos, col = self.ramp.bands[i]
            self.stop_pos.setValue(pos)
            self.stop_pos.setEnabled(i != 0)
            self.stop_col.set_color(col)
            rm.setEnabled(len(self.ramp.bands) > 1 and i != 0)

        def push():
            self.look()["bands"] = sorted([[p, list(c)] for p, c in self.ramp.bands], key=lambda b: b[0])
            self._changed()

        def move(v):
            self.ramp.bands[self.ramp.current][0] = round(v, 3)
            self.ramp.update()
            push()

        def recolor(rgb):
            self.ramp.bands[self.ramp.current][1] = rgb
            self.ramp.update()
            push()

        def remove():
            if self.ramp.current != 0 and len(self.ramp.bands) > 1:
                del self.ramp.bands[self.ramp.current]
                self.ramp.current = 0
                self.ramp.update()
                show_stop(0)
                push()

        self.ramp.selected.connect(show_stop)
        self.ramp.changed.connect(lambda: (show_stop(self.ramp.current), push()))
        self.stop_pos.valueChanged.connect(move)
        self.stop_col.changed.connect(recolor)
        rm.clicked.connect(remove)
        show_stop(self.ramp.current)

    def _inspect_saturation(self, lk):
        self._slider("Saturation", ["saturation"], 0.0, 2.5)

    def _inspect_specular(self, lk):
        self._enable_row("specular")
        self._slider("Roughness", ["specular", "roughness"], 0.0, 1.0)
        self._slider("Cut at", ["specular", "threshold"], 0.0, 1.0)
        self._color("Colour", ["specular", "color"])

    def _inspect_halftone(self, lk):
        self._enable_row("halftone")
        self._slider("Dots per screen", ["halftone", "per_screen"], 10, 250, 0)
        self._slider("Starts below", ["halftone", "below"], 0.0, 1.0)
        self._slider("Biggest dot", ["halftone", "max_dot"], 0.0, 0.75)
        self._slider("Angle", ["halftone", "angle"], 0, 90, 0)
        combo = Combo()
        combo.addItem("Darker base colour", "dark")
        combo.addItem("A fixed colour", "fixed")
        fixed = bool(lk["halftone"].get("color"))
        combo.setCurrentIndex(1 if fixed else 0)
        self.inspector.addRow("Dot colour", combo)
        dark = self._slider("Darkness", ["halftone", "darken"], 0.0, 1.0)
        btn = ColorButton(lk["halftone"].get("color") or [0.2, 0.1, 0.3])
        self.inspector.addRow("Colour", btn)
        dark.setEnabled(not fixed)
        btn.setEnabled(fixed)
        btn.changed.connect(lambda rgb: self._set(["halftone", "color"], rgb))

        def mode(_i):
            fx = combo.currentData() == "fixed"
            dark.setEnabled(not fx)
            btn.setEnabled(fx)
            self._set(["halftone", "color"], list(btn.rgb) if fx else None)
        combo.currentIndexChanged.connect(mode)

    def _inspect_hatching(self, lk):
        self._enable_row("hatching")
        self._slider("Darker than", ["hatching", "below"], 0.0, 1.0)
        self._slider("Lines per screen", ["hatching", "per_screen"], 10, 300, 0)
        self._slider("Line width", ["hatching", "width"], 0.02, 0.9)
        self._slider("Angle", ["hatching", "angle"], -90, 90, 0)
        self._color("Ink colour", ["hatching", "color"])

    def _inspect_rim(self, lk):
        self._enable_row("rim")
        self._slider("Edge at", ["rim", "threshold"], 0.0, 1.0)
        self._color("Colour", ["rim", "color"])
        combo = Combo()
        combo.addItem("Add light", "add")
        combo.addItem("Replace colour", "replace")
        combo.setCurrentIndex(0 if lk["rim"].get("mode", "add") == "add" else 1)
        combo.currentIndexChanged.connect(lambda _i: self._set(["rim", "mode"], combo.currentData()))
        self.inspector.addRow("Mode", combo)

    def _inspect_outline(self, lk):
        self._enable_row("outline")
        self._slider("Width (cm)", ["outline", "width_cm"], 0.0, 3.0)
        self._color("Colour", ["outline", "color"])

    # ------------------------------------------------------------ preview
    def render_preview(self):
        """Render the look being edited in the background; a newer edit re-queues it."""
        if (self.preview_job and self.preview_job.running()) or (self.sync_job and self.sync_job.running()):
            self._preview_again = True
            return None
        self._preview_again = False
        self._preview_n += 1
        tag = "%s_%d" % (self.name, self._preview_n)
        out = os.path.join(WORK, "preview_%s.png" % tag)
        try:
            if self.mode_group.checkedId() == 1:
                cmd = self._shot_frame_command(out)
            else:
                return self.sync(preview=True)
        except Exception as exc:
            self.preview_status.setText("Preview failed: %s" % exc)
            return None
        self.preview_status.setText("Rendering…")
        self.preview_job = launcher.BlenderJob(cmd, self)
        self.preview_job.finished.connect(lambda ok, s, o=out: self._preview_done(ok, s, o))
        self.preview_job.frame_done.connect(lambda _f, p: setattr(self, "_shot_png", p))
        self._shot_png = None
        self.preview_job.start()
        return self.preview_job

    def _shot_frame_command(self, out):
        """This frame of the open shot, with the edited (unsaved) looks."""
        from . import preflight, ui
        p = ui.panel()
        cam = p.cam_combo.currentData() if p else (exporter.render_cameras() or [None])[0]
        problems = preflight.blocking(preflight.run_all(camera=cam))
        if problems:      # e.g. duplicate names: Alembic cannot export them
            raise RuntimeError("the scene check found a problem (%s). Fix it in the panel's step 2, "
                               "or use Swatch." % problems[0].title.lower())
        looks_file = os.path.join(WORK, "looks_unsaved.json")
        with open(looks_file, "w") as f:
            json.dump(self.looks, f)
        f = int(cmds.currentTime(query=True))
        shot = exporter.export_shot(cam, f, f, os.path.join(WORK, "shot"), p.settings() if p else None,
                                    looks_file=looks_file)
        self._shot_out = out
        return launcher.build_command(shot, preview=True)

    def _preview_done(self, ok, summary_text, out):
        if self.mode_group.checkedId() == 1 and getattr(self, "_shot_png", None):
            out = self._shot_png
        if ok and os.path.isfile(out):
            pm = QtGui.QPixmap(out)
            self.preview.setPixmap(pm.scaled(self.preview.size(), QtCore.Qt.KeepAspectRatio,
                                             QtCore.Qt.SmoothTransformation))
            self.last_preview = out
            self.preview_status.setText("Preview of '%s'%s" % (
                self.look()["label"], " in this frame" if self.mode_group.checkedId() == 1 else ""))
        else:
            self.preview_status.setText("Preview failed: %s" % summary_text)
        if self._preview_again:
            self.render_preview()


_editor = None


def editor():
    return _editor


def show(look=None):
    global _editor
    ctrl = WINDOW + "WorkspaceControl"
    if cmds.workspaceControl(ctrl, exists=True):
        cmds.deleteUI(ctrl)
    _editor = LookEditor()
    if look:
        _editor.name = look
        _editor._fill_library()
        _editor.select_look(look)
    from . import ui
    p = ui.panel()
    if p is not None:
        _editor.saved.connect(p.reload_looks)
    _editor.show(dockable=True, floating=True, width=1260, height=640)
    return _editor
