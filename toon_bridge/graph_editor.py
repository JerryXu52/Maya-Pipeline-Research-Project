"""A Blender-style shader node editor inside Maya, for the real EEVEE node graph of a look.

Mouse and keys (Blender habits):
  drag a node ................. move it             drag on empty ........... box select
  drag from an output socket .. connect             drag a linked input ..... reconnect / pull off
  drag a number on a node ..... scrub it            click a number .......... type a value
  click a colour / menu / box . pick / choose / toggle, right on the node
  wheel ....................... zoom                middle-drag / Alt+drag .. pan
  right-click ................. menu (add, group, frame, reroute on a wire, delete, mute)
  Shift+A add   X delete   F frame all   Ctrl+Z / Ctrl+Shift+Z undo / redo
  Ctrl+G group   Ctrl+Alt+G ungroup   Tab enter / leave a group   Ctrl+J frame   Alt+P unframe
The inspector beside the graph shows every value and setting of the selected node.
"""
import ast
import copy
import operator
import os

try:
    from PySide6 import QtCore, QtGui, QtWidgets
except ImportError:
    from PySide2 import QtCore, QtGui, QtWidgets

from . import graph_model as gm
from .ui import Combo, DoubleSpinBox, SpinBox

ROW = 20
HEAD = 24
PROTECTED = {"ShaderNodeOutputMaterial", "NodeGroupInput", "NodeGroupOutput"}
IMAGE_FILTER = "Images (*.png *.jpg *.jpeg *.tif *.tiff *.exr *.tga *.bmp *.hdr *.webp)"


def _qc(rgb):
    return QtGui.QColor.fromRgbF(*[max(0.0, min(1.0, float(c))) for c in list(rgb)[:3]])


def _fmt(v):
    if isinstance(v, bool):
        return "on" if v else "off"
    if isinstance(v, float):
        return ("%.3f" % v).rstrip("0").rstrip(".") if abs(v) < 1e4 else "%.0f" % v
    if isinstance(v, list):
        return ", ".join(_fmt(x) for x in v[:3])
    return str(v)


def _enum_label(prop):
    for ident, label in prop.get("items", []):
        if ident == prop["value"]:
            return label
    return str(prop["value"])


_OPS = {ast.Add: operator.add, ast.Sub: operator.sub, ast.Mult: operator.mul, ast.Div: operator.truediv,
        ast.Pow: operator.pow, ast.USub: operator.neg, ast.UAdd: operator.pos}


def calc(text):
    """A typed number, or simple arithmetic like '1/3' or '0.5*2' (numbers and + - * / ** only)."""
    def ev(n):
        if isinstance(n, ast.Expression):
            return ev(n.body)
        if isinstance(n, ast.Constant) and isinstance(n.value, (int, float)):
            return float(n.value)
        if isinstance(n, ast.BinOp) and type(n.op) in _OPS:
            return _OPS[type(n.op)](ev(n.left), ev(n.right))
        if isinstance(n, ast.UnaryOp) and type(n.op) in _OPS:
            return _OPS[type(n.op)](ev(n.operand))
        raise ValueError("not a number: %r" % text)
    return ev(ast.parse(text.strip(), mode="eval"))


def browse_image(parent, start=""):
    path, _ = QtWidgets.QFileDialog.getOpenFileName(parent, "Choose an image", os.path.dirname(start or ""),
                                                    IMAGE_FILTER)
    return path or None


# ---------------------------------------------------------------- one node
class GraphNode(QtWidgets.QGraphicsObject):
    def __init__(self, view, data):
        super().__init__()
        self.view, self.data = view, data
        self.name = data["name"]
        self.w = max(140.0, float(data.get("width", 140)))
        self.rows = self._layout()
        self.h = HEAD + ROW * len(self.rows) + 8
        self.setFlags(QtWidgets.QGraphicsItem.ItemIsMovable | QtWidgets.QGraphicsItem.ItemIsSelectable |
                      QtWidgets.QGraphicsItem.ItemSendsGeometryChanges)
        self.setPos(data["location"][0], -data["location"][1])
        self.setZValue(1)

    def _layout(self):
        """Rows like Blender: outputs, then settings, then inputs (only enabled sockets)."""
        d, rows = self.data, []
        for s in d.get("outputs", []):
            if s.get("enabled", True):
                rows.append(("out", s))
        props = d.get("props", {})
        for pid in props:
            if props[pid]["type"] == "ENUM":
                rows.append(("prop", (pid, props[pid])))
        if "ramp" in d:
            rows.append(("ramp", d["ramp"]))
        if d.get("type") == "ShaderNodeTexImage":
            rows.append(("image", d.get("image") or ""))
        if d.get("type") == "ShaderNodeAttribute":
            rows.append(("text", "“%s”" % props.get("attribute_name", {}).get("value", "")))
        if d.get("type") == "ShaderNodeGroup":
            rows.append(("text", "↳ %s   (Tab to edit)" % d.get("group", "")))
        for s in d.get("inputs", []):
            if s.get("enabled", True):
                rows.append(("in", s))
        return rows

    def boundingRect(self):
        return QtCore.QRectF(-6, -2, self.w + 12, self.h + 4)

    def socket_pos(self, side, sid):
        """Scene position of a socket, or None if it is hidden."""
        for i, (kind, item) in enumerate(self.rows):
            if kind == side and item["id"] == sid:
                y = HEAD + i * ROW + ROW / 2.0
                return self.mapToScene(QtCore.QPointF(self.w if side == "out" else 0, y))
        return None

    def socket_at(self, scene_pos):
        p = self.mapFromScene(scene_pos)
        for i, (kind, item) in enumerate(self.rows):
            if kind not in ("in", "out"):
                continue
            y = HEAD + i * ROW + ROW / 2.0
            x = self.w if kind == "out" else 0
            if abs(p.x() - x) <= 9 and abs(p.y() - y) <= 9:
                return ("outputs" if kind == "out" else "inputs", item["id"])
        return None

    def _linked(self):
        return {l[3] for l in self.view.graph["links"] if l[2] == self.name}

    def field_at(self, scene_pos):
        """An editable field on the node under the point: (kind, key, scene rect) or None."""
        p = self.mapFromScene(scene_pos)
        linked = self._linked()
        for i, (kind, item) in enumerate(self.rows):
            r = QtCore.QRectF(8, HEAD + i * ROW + 1, self.w - 16, ROW - 2)
            if not r.contains(p):
                continue
            rect = self.mapRectToScene(r)
            if kind == "in" and item["id"] not in linked and "value" in item:
                return ("input", item, rect)
            if kind == "out" and "value" in item and self.data["type"] in ("ShaderNodeValue", "ShaderNodeRGB"):
                return ("output", item, rect)
            if kind == "prop":
                return ("prop", item, rect)
            if kind == "image":
                return ("image", None, rect)
        return None

    def paint(self, p, _opt, _w=None):
        d = self.data
        p.setRenderHint(QtGui.QPainter.Antialiasing)
        muted = d.get("mute")
        body = QtGui.QPainterPath()
        body.addRoundedRect(QtCore.QRectF(0, 0, self.w, self.h), 6, 6)
        p.fillPath(body, QtGui.QColor("#303033"))
        head = QtGui.QPainterPath()
        head.addRoundedRect(QtCore.QRectF(0, 0, self.w, HEAD), 6, 6)
        head.addRect(QtCore.QRectF(0, HEAD / 2.0, self.w, HEAD / 2.0))
        hc = QtGui.QColor(gm.HEADER_COLORS.get(gm.category(d["type"]), gm.HEADER_COLORS["Other"]))
        p.fillPath(head.simplified(), hc.darker(170) if muted else hc)
        sel = self.isSelected()
        p.setPen(QtGui.QPen(QtGui.QColor("#ff8a3d" if sel else "#141416"), 2 if sel else 1))
        p.drawPath(body)
        f = QtGui.QFont()
        f.setPointSizeF(9)
        f.setBold(True)
        p.setFont(f)
        p.setPen(QtGui.QColor("#f0eee9"))
        title = d.get("label") or (d.get("group") if d["type"] == "ShaderNodeGroup" else None) or \
            d.get("title") or d["type"]
        if muted:
            title += "  (muted)"
        p.drawText(QtCore.QRectF(8, 0, self.w - 16, HEAD), QtCore.Qt.AlignVCenter, title)
        f.setBold(False)
        f.setPointSizeF(8.5)
        p.setFont(f)
        linked = self._linked()
        field_bg, field_pen = QtGui.QColor("#545458"), QtGui.QColor("#3a3a3e")
        for i, (kind, item) in enumerate(self.rows):
            y = HEAD + i * ROW
            r = QtCore.QRectF(10, y, self.w - 20, ROW)
            box = QtCore.QRectF(8, y + 2, self.w - 16, ROW - 4)
            p.setPen(QtGui.QColor("#d8d5d0"))
            if kind == "out":
                editable = "value" in item and d["type"] in ("ShaderNodeValue", "ShaderNodeRGB")
                if editable:
                    self._field(p, box, item, field_bg, field_pen)
                else:
                    p.drawText(r, QtCore.Qt.AlignVCenter | QtCore.Qt.AlignRight, item["name"])
                self._dot(p, self.w, y + ROW / 2.0, item["type"])
            elif kind == "in":
                self._dot(p, 0, y + ROW / 2.0, item["type"])
                if item["id"] not in linked and "value" in item:
                    self._field(p, box, item, field_bg, field_pen)
                else:
                    p.drawText(r, QtCore.Qt.AlignVCenter | QtCore.Qt.AlignLeft, item["name"])
            elif kind == "prop":
                pid, prop = item
                p.setBrush(QtGui.QColor("#252528"))
                p.setPen(QtGui.QColor("#4a4a50"))
                p.drawRoundedRect(box, 3, 3)
                p.setPen(QtGui.QColor("#e6e3de"))
                p.drawText(box.adjusted(6, 0, -6, 0), QtCore.Qt.AlignVCenter, _enum_label(prop) + "  ▾")
            elif kind == "ramp":
                strip = QtCore.QRectF(8, y + 3, self.w - 16, ROW - 6)
                els = sorted(item["elements"], key=lambda e: e[0])
                if item.get("interpolation") == "CONSTANT":
                    for n, (pos, col) in enumerate(els):
                        x0 = strip.left() + (pos if n else 0) * strip.width()
                        x1 = strip.left() + (els[n + 1][0] if n + 1 < len(els) else 1) * strip.width()
                        p.fillRect(QtCore.QRectF(x0, strip.top(), x1 - x0, strip.height()), _qc(col))
                else:
                    g = QtGui.QLinearGradient(strip.left(), 0, strip.right(), 0)
                    for pos, col in els:
                        g.setColorAt(max(0.0, min(1.0, pos)), _qc(col))
                    p.fillRect(strip, g)
                p.setPen(QtGui.QColor("#111"))
                p.setBrush(QtCore.Qt.NoBrush)
                p.drawRect(strip)
            elif kind == "image":
                p.setBrush(QtGui.QColor("#252528"))
                p.setPen(QtGui.QColor("#4a4a50"))
                p.drawRoundedRect(box, 3, 3)
                p.setPen(QtGui.QColor("#e6e3de"))
                name = os.path.basename(item) if item else "Open image…"
                p.drawText(box.adjusted(6, 0, -6, 0), QtCore.Qt.AlignVCenter, "\U0001F5BC  " + name)
            elif kind == "text":
                p.drawText(r, QtCore.Qt.AlignVCenter | QtCore.Qt.AlignLeft, item)

    @staticmethod
    def _field(p, box, item, bg, pen):
        """A Blender-style value field: name on the left, value (or colour) on the right."""
        p.setBrush(bg)
        p.setPen(pen)
        p.drawRoundedRect(box, 3, 3)
        p.setPen(QtGui.QColor("#f2f0ec"))
        p.drawText(box.adjusted(6, 0, -6, 0), QtCore.Qt.AlignVCenter | QtCore.Qt.AlignLeft, item["name"])
        if item["type"] == "RGBA":
            sw = QtCore.QRectF(box.right() - 40, box.top() + 2, 36, box.height() - 4)
            p.fillRect(sw, _qc(item["value"]))
        else:
            p.drawText(box.adjusted(6, 0, -6, 0), QtCore.Qt.AlignVCenter | QtCore.Qt.AlignRight, _fmt(item["value"]))

    @staticmethod
    def _dot(p, x, y, kind):
        p.setBrush(QtGui.QColor(gm.SOCKET_COLORS.get(kind, "#cccccc")))
        p.setPen(QtGui.QPen(QtGui.QColor("#111"), 1))
        p.drawEllipse(QtCore.QPointF(x, y), 5, 5)

    def itemChange(self, change, value):
        if change == QtWidgets.QGraphicsItem.ItemPositionHasChanged:
            self.view.node_moved(self)
        return super().itemChange(change, value)


class RerouteItem(GraphNode):
    """Blender's reroute: one dot that a wire passes through."""

    def _layout(self):
        return []

    def boundingRect(self):
        return QtCore.QRectF(-9, -9, 18, 18)

    def socket_pos(self, side, sid):
        return self.mapToScene(QtCore.QPointF(0, 0))

    def socket_at(self, scene_pos):
        p = self.mapFromScene(scene_pos)
        return ("reroute", None) if (p.x() ** 2 + p.y() ** 2) <= 81 else None

    def field_at(self, scene_pos):
        return None

    def paint(self, p, _opt, _w=None):
        p.setRenderHint(QtGui.QPainter.Antialiasing)
        kind = (self.data.get("outputs") or [{}])[0].get("type", "RGBA")
        p.setBrush(QtGui.QColor(gm.SOCKET_COLORS.get(kind, "#cccccc")))
        p.setPen(QtGui.QPen(QtGui.QColor("#ff8a3d" if self.isSelected() else "#111"), 2 if self.isSelected() else 1))
        p.drawEllipse(QtCore.QPointF(0, 0), 6, 6)


class FrameItem(QtWidgets.QGraphicsObject):
    """Blender's frame: a box behind its nodes. Dragging it moves everything inside."""

    def __init__(self, view, data):
        super().__init__()
        self.view, self.data, self.name = view, data, data["name"]
        self.setFlags(QtWidgets.QGraphicsItem.ItemIsSelectable)
        self.setZValue(-1)
        self._last = None

    def kids(self):
        return [self.view.nodes[n["name"]] for n in gm.children(self.view.graph, self.name)
                if n["name"] in self.view.nodes]

    def frame_rect(self):
        kids = self.kids()
        if kids:
            r = QtCore.QRectF()
            for k in kids:
                r = r.united(k.sceneBoundingRect())
            return r.adjusted(-18, -36, 18, 18)
        x, y = self.data["location"]
        return QtCore.QRectF(x, -y, self.data.get("width", 160), self.data.get("height", 100))

    def boundingRect(self):
        return self.frame_rect().adjusted(-2, -2, 2, 2)

    def paint(self, p, _opt, _w=None):
        r = self.frame_rect()
        p.setRenderHint(QtGui.QPainter.Antialiasing)
        c = QtGui.QColor("#5a5a66")
        c.setAlpha(110)
        p.setBrush(c)
        p.setPen(QtGui.QPen(QtGui.QColor("#ff8a3d" if self.isSelected() else "#6a6a74"), 1.5))
        p.drawRoundedRect(r, 6, 6)
        f = QtGui.QFont()
        f.setPointSizeF(max(8.0, self.data.get("props", {}).get("label_size", {}).get("value", 20) * 0.55))
        f.setBold(True)
        p.setFont(f)
        p.setPen(QtGui.QColor("#e6e3de"))
        p.drawText(QtCore.QRectF(r.left() + 10, r.top() + 4, r.width() - 20, 26), QtCore.Qt.AlignVCenter,
                   self.data.get("label") or self.name)

    def refresh(self):
        self.prepareGeometryChange()
        self.update()

    def mousePressEvent(self, ev):
        if ev.button() == QtCore.Qt.LeftButton:
            if not (ev.modifiers() & QtCore.Qt.ShiftModifier):
                self.scene().clearSelection()
            self.setSelected(True)
            self._last = ev.scenePos()
            self.view.begin_move()
            ev.accept()
        else:
            ev.ignore()

    def mouseMoveEvent(self, ev):
        if self._last is None:
            return
        d = ev.scenePos() - self._last
        self._last = ev.scenePos()
        for k in self.kids():
            k.moveBy(d.x(), d.y())
        if not self.kids():
            self.data["location"] = [self.data["location"][0] + d.x(), self.data["location"][1] - d.y()]
        self.refresh()

    def mouseReleaseEvent(self, ev):
        self._last = None
        self.view.end_move()


class InlineEdit(QtWidgets.QLineEdit):
    """Typing a value right on the node (Enter keeps it, Esc cancels)."""
    done = QtCore.Signal(str)
    cancelled = QtCore.Signal()

    def keyPressEvent(self, ev):
        if ev.key() == QtCore.Qt.Key_Escape:
            self.cancelled.emit()
            return
        super().keyPressEvent(ev)

    def focusOutEvent(self, ev):
        super().focusOutEvent(ev)
        self.done.emit(self.text())


# ---------------------------------------------------------------- the canvas
class GraphView(QtWidgets.QGraphicsView):
    changed = QtCore.Signal(bool)          # structural: True when Blender should rebuild
    nodeSelected = QtCore.Signal(str)
    nodeEdited = QtCore.Signal(str)        # a value was changed right on the node
    pathChanged = QtCore.Signal(list)      # entered / left a node group

    def __init__(self, parent=None):
        super().__init__(parent)
        self.setScene(QtWidgets.QGraphicsScene(self))
        self.scene().setSceneRect(-20000, -20000, 40000, 40000)
        self.setRenderHint(QtGui.QPainter.Antialiasing)
        self.setViewportUpdateMode(QtWidgets.QGraphicsView.FullViewportUpdate)
        self.setTransformationAnchor(QtWidgets.QGraphicsView.AnchorUnderMouse)
        self.setDragMode(QtWidgets.QGraphicsView.RubberBandDrag)
        self.setHorizontalScrollBarPolicy(QtCore.Qt.ScrollBarAlwaysOff)
        self.setVerticalScrollBarPolicy(QtCore.Qt.ScrollBarAlwaysOff)
        self.setFrameShape(QtWidgets.QFrame.NoFrame)
        self.setFocusPolicy(QtCore.Qt.StrongFocus)
        self.root = {"nodes": [], "links": []}
        self.path = []
        self.nodes, self.frames = {}, {}
        self._drag = None
        self._drag_pos = None
        self._detached = False
        self._pan = None
        self._moved = False
        self._scrub = None
        self._editor = None
        self._wire_paths = []
        self._move_snapshot = None
        self.undo_stack, self.redo_stack = [], []
        self.scene().selectionChanged.connect(self._selection)

    # ------------------------------------------------ graph in / out
    @property
    def graph(self):
        """The level being shown: the material, or the node group we're inside."""
        if self.path:
            g = (self.root.get("groups") or {}).get(self.path[-1])
            if g:
                return g
        return self.root

    def set_graph(self, root, keep_view=False, keep_selection=True):
        sel = self.selected_names() if keep_selection else []
        self.root = root
        self.path = [p for p in self.path if p in (root.get("groups") or {})]
        g = self.graph
        self.nodes, self.frames = {}, {}
        self.scene().blockSignals(True)
        self.scene().clear()
        for nd in g["nodes"]:
            if nd["type"] == "NodeFrame":
                it = FrameItem(self, nd)
                self.frames[nd["name"]] = it
            elif nd["type"] == "NodeReroute":
                it = RerouteItem(self, nd)
                self.nodes[nd["name"]] = it
            else:
                it = GraphNode(self, nd)
                self.nodes[nd["name"]] = it
            self.scene().addItem(it)
            if nd["name"] in sel:
                it.setSelected(True)
        self.scene().blockSignals(False)
        if not keep_view:
            self.frame_all(readable=True)
        self.viewport().update()

    def snapshot(self):
        self.undo_stack.append((copy.deepcopy(self.root), list(self.path)))
        del self.undo_stack[:-50]
        self.redo_stack = []

    def _restore(self, state):
        root, path = state
        self.path = path
        self.set_graph(root, keep_view=True)
        self.pathChanged.emit(list(self.path))
        self.changed.emit(True)

    def undo(self):
        if self.undo_stack:
            self.redo_stack.append((copy.deepcopy(self.root), list(self.path)))
            self._restore(self.undo_stack.pop())

    def redo(self):
        if self.redo_stack:
            self.undo_stack.append((copy.deepcopy(self.root), list(self.path)))
            self._restore(self.redo_stack.pop())

    def selected_names(self):
        return [it.name for it in self.scene().selectedItems() if isinstance(it, (GraphNode, FrameItem))]

    def _selection(self):
        names = self.selected_names()
        self.nodeSelected.emit(names[0] if len(names) == 1 else "")
        self.viewport().update()

    def frame_all(self, readable=False):
        """Fit every node in view. readable=True never zooms out past where text is legible."""
        items = list(self.nodes.values()) + list(self.frames.values())
        if not items:
            return
        r = QtCore.QRectF()
        for it in items:
            r = r.united(it.sceneBoundingRect())
        self.fitInView(r.adjusted(-40, -40, 40, 40), QtCore.Qt.KeepAspectRatio)
        if readable and self.transform().m11() < 0.6:
            self.resetTransform()
            self.scale(0.6, 0.6)
            self.centerOn(r.center())

    def begin_move(self):
        self._move_snapshot = (copy.deepcopy(self.root), list(self.path))

    def end_move(self):
        if self._moved and self._move_snapshot:
            self.undo_stack.append(self._move_snapshot)
            self.redo_stack = []
            self._moved = False
            self.changed.emit(False)      # positions only: no rebuild needed
        self._move_snapshot = None

    def node_moved(self, item):
        item.data["location"] = [round(item.pos().x(), 1), round(-item.pos().y(), 1)]
        self._moved = True
        for f in self.frames.values():
            f.refresh()
        self.viewport().update()

    # ------------------------------------------------ groups
    def enter_group(self, gname):
        if gname in (self.root.get("groups") or {}):
            self.path.append(gname)
            self.set_graph(self.root, keep_selection=False)
            self.pathChanged.emit(list(self.path))

    def exit_group(self):
        if self.path:
            left = self.path.pop()
            self.set_graph(self.root, keep_selection=False)
            for n, it in self.nodes.items():
                if it.data.get("group") == left:
                    it.setSelected(True)
            self.pathChanged.emit(list(self.path))

    def group_selected(self):
        names = [n for n in self.selected_names() if n in self.nodes]
        if not names:
            return None
        self.snapshot()
        gnode = gm.make_group(self.root, self.graph, names)
        if gnode is None:
            self.undo_stack.pop()
            return None
        self.set_graph(self.root, keep_view=True, keep_selection=False)
        self.nodes[gnode].setSelected(True)
        self.changed.emit(True)
        return gnode

    def ungroup_selected(self):
        groups = [n for n in self.selected_names() if self.nodes.get(n) and
                  self.nodes[n].data["type"] == "ShaderNodeGroup"]
        if not groups:
            return []
        self.snapshot()
        made = []
        for g in groups:
            made += gm.ungroup(self.root, self.graph, g)
        self.set_graph(self.root, keep_view=True, keep_selection=False)
        for n in made:
            if n in self.nodes:
                self.nodes[n].setSelected(True)
        self.changed.emit(True)
        return made

    def frame_selected(self):
        names = [n for n in self.selected_names() if n in self.nodes]
        if not names:
            return None
        self.snapshot()
        f = gm.join_in_frame(self.graph, names)
        self.set_graph(self.root, keep_view=True, keep_selection=False)
        self.frames[f].setSelected(True)
        self.changed.emit(True)
        return f

    def unframe_selected(self):
        names = [n for n in self.selected_names() if n in self.nodes]
        if names:
            self.snapshot()
            gm.remove_from_frame(self.graph, names)
            self.set_graph(self.root, keep_view=True)
            self.changed.emit(True)

    # ------------------------------------------------ drawing
    def drawBackground(self, p, rect):
        p.fillRect(rect, QtGui.QColor("#1d1d1f"))
        step = 40
        p.setPen(QtGui.QPen(QtGui.QColor("#262629"), 1))
        x = int(rect.left()) - int(rect.left()) % step
        while x < rect.right():
            p.drawLine(QtCore.QPointF(x, rect.top()), QtCore.QPointF(x, rect.bottom()))
            x += step
        y = int(rect.top()) - int(rect.top()) % step
        while y < rect.bottom():
            p.drawLine(QtCore.QPointF(rect.left(), y), QtCore.QPointF(rect.right(), y))
            y += step
        # frames sit behind wires; wires are painted here (not scene items), because Qt deleted
        # separate wire items once Maya re-parented the window
        p.setRenderHint(QtGui.QPainter.Antialiasing)
        self._wire_paths = []
        for link in self.graph["links"]:
            a, ao, b, bi = link
            na, nb = self.nodes.get(a), self.nodes.get(b)
            if not na or not nb:
                continue
            p1, p2 = na.socket_pos("out", ao), nb.socket_pos("in", bi)
            if p1 is None or p2 is None:
                continue
            out_sock = gm.socket(na.data, "outputs", ao) or {}
            path = self._wire(p, p1, p2, gm.SOCKET_COLORS.get(out_sock.get("type", "VALUE"), "#aaa"),
                              na.isSelected() or nb.isSelected())
            self._wire_paths.append((path, link))

    def drawForeground(self, p, rect):
        if self._drag and self._drag_pos is not None:
            n = self.nodes.get(self._drag[0])
            start = n.socket_pos("out", self._drag[1]) if n else None
            if start is not None:
                self._wire(p, start, self._drag_pos, "#ffffff", True)

    @staticmethod
    def _wire(p, p1, p2, color, bright):
        path = QtGui.QPainterPath(p1)
        dx = max(30.0, abs(p2.x() - p1.x()) * 0.5)
        path.cubicTo(p1 + QtCore.QPointF(dx, 0), p2 - QtCore.QPointF(dx, 0), p2)
        c = QtGui.QColor(color)
        if not bright:
            c.setAlpha(190)
        p.setPen(QtGui.QPen(c, 2.6 if bright else 1.8))
        p.setBrush(QtCore.Qt.NoBrush)
        p.drawPath(path)
        return path

    def wire_at(self, scene_pos):
        stroker = QtGui.QPainterPathStroker()
        stroker.setWidth(10)
        for path, link in self._wire_paths:
            if stroker.createStroke(path).contains(scene_pos):
                return link
        return None

    # ------------------------------------------------ mouse
    def _node_and_socket(self, scene_pos):
        for it in self.scene().items(scene_pos):
            if isinstance(it, GraphNode):
                return it, it.socket_at(scene_pos)
        for it in self.nodes.values():      # sockets sit on the node edge: look slightly outside too
            s = it.socket_at(scene_pos)
            if s:
                return it, s
        return None, None

    def focusNextPrevChild(self, _next):
        return False                       # Tab enters / leaves node groups instead

    def mousePressEvent(self, ev):
        self._close_editor(commit=True)
        sp = self.mapToScene(ev.pos())
        if ev.button() == QtCore.Qt.MiddleButton or (ev.button() == QtCore.Qt.LeftButton and
                                                      ev.modifiers() & QtCore.Qt.AltModifier):
            self._pan = ev.pos()
            self.setCursor(QtCore.Qt.ClosedHandCursor)
            return
        if ev.button() == QtCore.Qt.LeftButton:
            item, sock = self._node_and_socket(sp)
            if sock:
                side, sid = sock
                if side == "reroute":
                    self._drag = (item.name, "Output")
                elif side == "outputs":
                    self._drag = (item.name, sid)
                else:      # pulling a linked input re-picks its wire from the source
                    old = gm.links_into(self.graph, item.name, sid)
                    if not old:
                        return
                    self.snapshot()
                    gm.disconnect(self.graph, item.name, sid)
                    self._drag = (old[0][0], old[0][1])
                    self._detached = True
                self._drag_pos = sp
                self.setDragMode(QtWidgets.QGraphicsView.NoDrag)
                return
            field = item.field_at(sp) if item is not None else None
            if field and self._field_press(item, field, ev):
                return
            if item is not None:
                self.begin_move()
        super().mousePressEvent(ev)

    def mouseDoubleClickEvent(self, ev):
        item, _s = self._node_and_socket(self.mapToScene(ev.pos()))
        if item is not None and item.data["type"] == "ShaderNodeGroup":
            self.enter_group(item.data.get("group"))
            return
        super().mouseDoubleClickEvent(ev)

    def mouseMoveEvent(self, ev):
        if self._pan is not None:
            d = ev.pos() - self._pan
            self._pan = ev.pos()
            self.horizontalScrollBar().setValue(self.horizontalScrollBar().value() - d.x())
            self.verticalScrollBar().setValue(self.verticalScrollBar().value() - d.y())
            return
        if self._scrub:
            self._scrub_move(ev)
            return
        if self._drag:
            self._drag_pos = self.mapToScene(ev.pos())
            self.viewport().update()
            return
        super().mouseMoveEvent(ev)

    def mouseReleaseEvent(self, ev):
        if self._pan is not None:
            self._pan = None
            self.unsetCursor()
            return
        if self._scrub:
            s, self._scrub = self._scrub, None
            if s["moved"]:
                self.changed.emit(True)
                self.nodeEdited.emit(s["item"].name)
            else:
                self.open_inline_editor(s["item"], s["side"], s["sock"], s["rect"])
            return
        if self._drag:
            item, sock = self._node_and_socket(self.mapToScene(ev.pos()))
            target = None
            if item is not None and sock:
                if sock[0] == "inputs":
                    target = sock[1]
                elif sock[0] == "reroute":
                    target = "Input"
            if target is not None and item.name != self._drag[0]:
                if not self._detached:
                    self.snapshot()
                gm.connect(self.graph, self._drag[0], self._drag[1], item.name, target)
                self.changed.emit(True)
            elif self._detached:
                self.changed.emit(True)
            self._drag, self._drag_pos, self._detached = None, None, False
            self.setDragMode(QtWidgets.QGraphicsView.RubberBandDrag)
            self.viewport().update()
            return
        super().mouseReleaseEvent(ev)
        self.end_move()

    def wheelEvent(self, ev):
        f = 1.15 if ev.angleDelta().y() > 0 else 1 / 1.15
        s = self.transform().m11() * f
        if 0.08 < s < 4:
            self.scale(f, f)

    # ------------------------------------------------ editing values right on the node
    def _field_press(self, item, field, ev):
        kind, data, rect = field
        if kind in ("input", "output"):
            v, side = data["value"], "inputs" if kind == "input" else "outputs"
            if data["type"] == "RGBA":
                c = QtWidgets.QColorDialog.getColor(_qc(v), self, data["name"])
                if c.isValid():
                    self.edit_value(item, side, data["id"], [c.redF(), c.greenF(), c.blueF(), 1.0])
                return True
            if isinstance(v, bool):
                self.edit_value(item, side, data["id"], not v)
                return True
            if isinstance(v, (int, float)):
                self._scrub = {"item": item, "side": side, "sock": data, "rect": rect, "x": ev.pos().x(),
                               "start": float(v), "moved": False}
                return True
            self.open_inline_editor(item, side, data, rect)
            return True
        if kind == "prop":
            pid, prop = data
            menu = QtWidgets.QMenu(self)
            for ident, label in prop.get("items", []):
                a = menu.addAction(label)
                a.setCheckable(True)
                a.setChecked(ident == prop["value"])
                a.triggered.connect(lambda _c=False, i=ident: self.edit_prop(item, pid, i))
            menu.exec(self.mapToGlobal(self.mapFromScene(rect.bottomLeft())))
            return True
        if kind == "image":
            path = browse_image(self, item.data.get("image"))
            if path:
                self.snapshot()
                item.data["image"] = path
                self.set_graph(self.root, keep_view=True)
                self.changed.emit(True)
                self.nodeEdited.emit(item.name)
            return True
        return False

    def _scrub_move(self, ev):
        s = self._scrub
        dx = ev.pos().x() - s["x"]
        if not s["moved"] and abs(dx) < 3:
            return
        if not s["moved"]:
            self.snapshot()
            s["moved"] = True
        step = 0.01 if abs(s["start"]) < 10 else 0.1
        if ev.modifiers() & QtCore.Qt.ShiftModifier:
            step /= 10.0
        v = round(s["start"] + dx * step, 4)
        if isinstance(s["sock"]["value"], int) and not isinstance(s["sock"]["value"], bool):
            v = int(round(v))
        s["sock"]["value"] = v
        s["item"].update()

    def open_inline_editor(self, item, side, sock, rect):
        """Type a value on the node; vectors take 'x, y, z'."""
        self._close_editor(commit=False)
        ed = InlineEdit(self.viewport())
        ed.setText(_fmt(sock["value"]))
        ed.selectAll()
        r = self.mapFromScene(rect).boundingRect()
        ed.setGeometry(r.adjusted(0, 0, 0, 2))
        ed.setStyleSheet("background:#1b1b1d; color:#fff; border:1px solid #ff8a3d; border-radius:3px;")
        ed._target = (item, side, sock)
        ed.done.connect(lambda _t: self._close_editor(commit=True))
        ed.returnPressed.connect(lambda: self._close_editor(commit=True))
        ed.cancelled.connect(lambda: self._close_editor(commit=False))
        self._editor = ed
        ed.show()
        ed.setFocus()
        return ed

    def _close_editor(self, commit):
        ed, self._editor = self._editor, None
        if ed is None:
            return
        item, side, sock = ed._target
        text = ed.text()
        ed.hide()
        ed.deleteLater()
        if not commit:
            return
        old = sock["value"]
        try:
            if isinstance(old, list):
                parts = [float(x) for x in text.replace(";", ",").split(",") if x.strip()]
                new = (parts + list(old)[len(parts):])[:len(old)]
            elif isinstance(old, bool):
                new = text.strip().lower() in ("1", "true", "on", "yes")
            elif isinstance(old, int):
                new = int(float(text))
            elif isinstance(old, float):
                new = calc(text) if text.strip() else old      # "1/3" works too
            else:
                new = text
        except Exception:
            return
        if new != old:
            self.edit_value(item, side, sock["id"], new)

    def edit_value(self, item, side, sid, value):
        self.snapshot()
        gm.set_input(self.graph, item.name, sid, value, side)
        item.update()
        self.changed.emit(True)
        self.nodeEdited.emit(item.name)

    def edit_prop(self, item, pid, value):
        self.snapshot()
        gm.set_prop(self.graph, item.name, pid, value)
        item.update()
        self.changed.emit(True)
        self.nodeEdited.emit(item.name)

    # ------------------------------------------------ menus and keys
    def contextMenuEvent(self, ev):
        sp = self.mapToScene(ev.pos())
        item, sock = self._node_and_socket(sp)
        frame = next((f for f in self.frames.values() if f.frame_rect().contains(sp)), None) if item is None else None
        menu = QtWidgets.QMenu(self)
        if sock and sock[0] == "inputs" and gm.links_into(self.graph, item.name, sock[1]):
            menu.addAction("Disconnect", lambda: self._disconnect(item.name, sock[1]))
        wire = self.wire_at(sp) if item is None else None
        if wire:
            menu.addAction("Insert reroute here", lambda: self.insert_reroute(wire, sp))
            menu.addAction("Delete wire", lambda: self._disconnect(wire[2], wire[3]))
            menu.addSeparator()
        target = item or frame
        if target is not None:
            if not target.isSelected():
                self.scene().clearSelection()
                target.setSelected(True)
            if item is not None and item.data["type"] == "ShaderNodeGroup":
                menu.addAction("Edit group (Tab)", lambda: self.enter_group(item.data.get("group")))
                menu.addAction("Ungroup (Ctrl+Alt+G)", self.ungroup_selected)
            if item is not None:
                menu.addAction("Group selected (Ctrl+G)", self.group_selected)
                menu.addAction("Join in new frame (Ctrl+J)", self.frame_selected)
                if item.data.get("parent"):
                    menu.addAction("Remove from frame (Alt+P)", self.unframe_selected)
                menu.addAction("Mute / Unmute", lambda: self.toggle_mute(item.name))
            menu.addAction("Delete", self.delete_selected)
            menu.addSeparator()
        if self.path:
            menu.addAction("Leave group (Tab)", self.exit_group)
        menu.addAction("Arrange all nodes", self.arrange)
        add = menu.addMenu("Add node")
        self._fill_add_menu(add, sp)
        menu.exec(ev.globalPos())

    def _fill_add_menu(self, menu, scene_pos):
        for cat, entries in gm.catalog()["menu"]:
            sub = menu.addMenu(cat)
            for t, label in entries:
                sub.addAction(label, lambda tt=t, p=scene_pos: self.add_node(tt, p))
        groups = [g for g in (self.root.get("groups") or {}) if g not in self.path]
        if groups:
            sub = menu.addMenu("Group")
            for g in groups:
                sub.addAction(g, lambda gg=g, p=scene_pos: self.add_group(gg, p))

    def keyPressEvent(self, ev):
        k, mod = ev.key(), ev.modifiers()
        ctrl, alt, shift = mod & QtCore.Qt.ControlModifier, mod & QtCore.Qt.AltModifier, mod & QtCore.Qt.ShiftModifier
        if k in (QtCore.Qt.Key_Delete, QtCore.Qt.Key_Backspace, QtCore.Qt.Key_X):
            self.delete_selected()
        elif k in (QtCore.Qt.Key_F, QtCore.Qt.Key_Home):
            self.frame_all()
        elif k == QtCore.Qt.Key_A and shift:
            m = QtWidgets.QMenu(self)
            self._fill_add_menu(m, self.mapToScene(self.mapFromGlobal(QtGui.QCursor.pos())))
            m.exec(QtGui.QCursor.pos())
        elif k == QtCore.Qt.Key_G and ctrl and alt:
            self.ungroup_selected()
        elif k == QtCore.Qt.Key_G and ctrl:
            self.group_selected()
        elif k == QtCore.Qt.Key_Tab:
            sel = [self.nodes[n] for n in self.selected_names() if n in self.nodes]
            if len(sel) == 1 and sel[0].data["type"] == "ShaderNodeGroup":
                self.enter_group(sel[0].data.get("group"))
            else:
                self.exit_group()
        elif k == QtCore.Qt.Key_J and ctrl:
            self.frame_selected()
        elif k == QtCore.Qt.Key_P and alt:
            self.unframe_selected()
        elif k == QtCore.Qt.Key_Z and ctrl:
            self.redo() if shift else self.undo()
        else:
            super().keyPressEvent(ev)

    # ------------------------------------------------ edits
    def add_node(self, node_type, scene_pos=None):
        self.snapshot()
        if scene_pos is None:
            scene_pos = self.mapToScene(self.viewport().rect().center())
        if node_type == "NodeFrame":
            name = gm.join_in_frame(self.graph, [])
            gm.node(self.graph, name)["location"] = [scene_pos.x(), -scene_pos.y()]
        else:
            name = gm.add_node(self.graph, node_type, (scene_pos.x(), -scene_pos.y()))
        self.set_graph(self.root, keep_view=True, keep_selection=False)
        (self.nodes.get(name) or self.frames.get(name)).setSelected(True)
        self.changed.emit(True)
        return name

    def add_group(self, gname, scene_pos=None):
        self.snapshot()
        if scene_pos is None:
            scene_pos = self.mapToScene(self.viewport().rect().center())
        name = gm.add_group_node(self.root, self.graph, gname, (scene_pos.x(), -scene_pos.y()))
        self.set_graph(self.root, keep_view=True, keep_selection=False)
        if name:
            self.nodes[name].setSelected(True)
        self.changed.emit(True)
        return name

    def arrange(self):
        """Tidy layout: columns from the output, no overlapping nodes (undoable)."""
        self.snapshot()
        gm.auto_layout(self.graph)
        self.set_graph(self.root, keep_view=False)
        self.changed.emit(False)

    def insert_reroute(self, link, scene_pos):
        self.snapshot()
        name = gm.insert_reroute(self.graph, list(link), (scene_pos.x(), -scene_pos.y()))
        self.set_graph(self.root, keep_view=True, keep_selection=False)
        self.changed.emit(True)
        return name

    def delete_selected(self):
        names = [n for n in self.selected_names() if gm.node(self.graph, n) and
                 gm.node(self.graph, n)["type"] not in PROTECTED]
        if not names:
            return
        self.snapshot()
        for n in names:
            gm.remove_node(self.graph, n)
        self.set_graph(self.root, keep_view=True, keep_selection=False)
        self.changed.emit(True)

    def toggle_mute(self, name):
        self.snapshot()
        nd = gm.node(self.graph, name)
        nd["mute"] = not nd.get("mute")
        self.nodes[name].update()
        self.changed.emit(True)

    def _disconnect(self, node_name, sock):
        self.snapshot()
        gm.disconnect(self.graph, node_name, sock)
        self.viewport().update()
        self.changed.emit(True)


# ---------------------------------------------------------------- inspector
class NodeInspector(QtWidgets.QScrollArea):
    """Every editable value and setting of the selected node."""
    edited = QtCore.Signal(bool)       # structural

    def __init__(self, view, parent=None):
        super().__init__(parent)
        self.view = view
        self.setWidgetResizable(True)
        self.setFrameShape(QtWidgets.QFrame.NoFrame)
        self.host = QtWidgets.QWidget()
        self.form = QtWidgets.QFormLayout(self.host)
        self.form.setLabelAlignment(QtCore.Qt.AlignRight)
        self.setWidget(self.host)
        self.name = None

    def show_node(self, name):
        from .look_editor import ColorButton, RampEditor
        self.name = name or None
        while self.form.rowCount():
            self.form.removeRow(0)
        nd = gm.node(self.view.graph, name) if name else None
        if nd is None:
            hint = QtWidgets.QLabel("Click a node to edit it, or edit values right on the nodes.\n"
                                    "Right-click the graph to add nodes, groups, frames and reroutes.")
            hint.setProperty("muted", True)
            hint.setWordWrap(True)
            self.form.addRow(hint)
            return
        title = QtWidgets.QLabel("<b>%s</b>  <span style='color:#9a979f'>%s</span>" % (
            nd.get("title", nd["type"]), nd["name"]))
        self.form.addRow(title)
        lab = QtWidgets.QLineEdit(nd.get("label", ""))
        lab.setPlaceholderText("(no label)")
        lab.editingFinished.connect(lambda: self._edit(lambda g: gm.node(g, name).__setitem__("label", lab.text()), False))
        self.form.addRow("Label", lab)
        if nd["type"] == "ShaderNodeGroup":
            b = QtWidgets.QPushButton("Edit group  (Tab)")
            b.clicked.connect(lambda: self.view.enter_group(nd.get("group")))
            self.form.addRow("Group", b)
        for pid, prop in nd.get("props", {}).items():
            self.form.addRow(prop.get("label", pid), self._prop_widget(name, pid, prop))
        if "ramp" in nd:
            interp = Combo()
            for it in ["CONSTANT", "LINEAR", "EASE", "B_SPLINE", "CARDINAL"]:
                interp.addItem(it.title().replace("_", "-"), it)
            interp.setCurrentIndex(max(0, interp.findData(nd["ramp"].get("interpolation"))))
            interp.currentIndexChanged.connect(lambda _i: self._edit(
                lambda g: gm.node(g, name)["ramp"].__setitem__("interpolation", interp.currentData()), True))
            self.form.addRow("Interpolation", interp)
            ramp = RampEditor()
            ramp.set_bands([[e[0], e[1][:3]] for e in nd["ramp"]["elements"]])
            col = ColorButton()

            def push(r=ramp):
                self._edit(lambda g: gm.node(g, name)["ramp"].__setitem__(
                    "elements", [[round(p, 4), list(c)[:3] + [1.0]] for p, c in sorted(r.bands, key=lambda b: b[0])]), True)

            ramp.changed.connect(push)
            ramp.selected.connect(lambda i, r=ramp: col.set_color(r.bands[i][1]))
            col.changed.connect(lambda rgb, r=ramp: (r.bands[r.current].__setitem__(1, rgb), r.update(), push()))
            col.set_color(ramp.bands[0][1])
            self.form.addRow(ramp)
            self.form.addRow("Stop colour", col)
        if nd.get("type") == "ShaderNodeTexImage":
            self.form.addRow("Image", self._image_widget(name, nd))
        linked = {l[3]: l for l in self.view.graph["links"] if l[2] == name}
        for side in ("inputs", "outputs"):
            for s in nd.get(side, []):
                if not s.get("enabled", True) or "value" not in s:
                    continue
                if side == "outputs" and nd["type"] not in ("ShaderNodeValue", "ShaderNodeRGB"):
                    continue
                if side == "inputs" and s["id"] in linked:
                    l = linked[s["id"]]
                    w = QtWidgets.QLabel("← %s . %s" % (l[0], l[1]))
                    w.setProperty("muted", True)
                else:
                    w = self._value_widget(name, side, s)
                self.form.addRow(s["name"], w)

    def _image_widget(self, name, nd):
        box = QtWidgets.QWidget()
        lay = QtWidgets.QVBoxLayout(box)
        lay.setContentsMargins(0, 0, 0, 0)
        row = QtWidgets.QHBoxLayout()
        path = QtWidgets.QLineEdit(nd.get("image", ""))
        path.setPlaceholderText("no image")
        browse = QtWidgets.QPushButton("Browse…")
        row.addWidget(path, 1)
        row.addWidget(browse)
        lay.addLayout(row)
        thumb = QtWidgets.QLabel()
        thumb.setFixedHeight(120)
        thumb.setAlignment(QtCore.Qt.AlignLeft)
        if nd.get("image") and os.path.isfile(nd["image"]):
            thumb.setPixmap(QtGui.QPixmap(nd["image"]).scaled(200, 120, QtCore.Qt.KeepAspectRatio,
                                                               QtCore.Qt.SmoothTransformation))
        else:
            thumb.setText("(no preview)" if nd.get("image") else "")
        lay.addWidget(thumb)

        def set_path(p):
            self._edit(lambda g: gm.node(g, name).__setitem__("image", p), True)
            self.view.set_graph(self.view.root, keep_view=True)
            self.show_node(name)

        path.editingFinished.connect(lambda: set_path(path.text()))
        browse.clicked.connect(lambda: (lambda p: p and set_path(p))(browse_image(self, path.text())))
        return box

    def _edit(self, fn, structural):
        self.view.snapshot()
        fn(self.view.graph)
        if self.name in self.view.nodes:
            self.view.nodes[self.name].update()
        self.view.viewport().update()
        self.edited.emit(structural)

    def _prop_widget(self, name, pid, prop):
        t = prop["type"]
        if t == "ENUM":
            w = Combo()
            for ident, label in prop.get("items", []):
                w.addItem(label, ident)
            w.setCurrentIndex(max(0, w.findData(prop["value"])))
            w.currentIndexChanged.connect(lambda _i: self._edit(lambda g: gm.set_prop(g, name, pid, w.currentData()), True))
        elif t == "BOOLEAN":
            w = QtWidgets.QCheckBox()
            w.setChecked(bool(prop["value"]))
            w.toggled.connect(lambda on: self._edit(lambda g: gm.set_prop(g, name, pid, on), True))
        elif t == "INT":
            w = SpinBox()
            w.setRange(-100000, 100000)
            w.setValue(int(prop["value"]))
            w.valueChanged.connect(lambda v: self._edit(lambda g: gm.set_prop(g, name, pid, v), True))
        elif t == "FLOAT":
            w = DoubleSpinBox()
            w.setRange(-1e6, 1e6)
            w.setDecimals(3)
            w.setValue(float(prop["value"]))
            w.valueChanged.connect(lambda v: self._edit(lambda g: gm.set_prop(g, name, pid, v), True))
        else:
            w = QtWidgets.QLineEdit(str(prop["value"]))
            w.editingFinished.connect(lambda: self._edit(lambda g: gm.set_prop(g, name, pid, w.text()), True))
        return w

    def _value_widget(self, name, side, s):
        from .look_editor import ColorButton
        v, t = s["value"], s["type"]
        if t == "RGBA":
            w = ColorButton(v[:3])
            w.changed.connect(lambda rgb: self._edit(lambda g: gm.set_input(g, name, s["id"], rgb + [1.0], side), True))
            return w
        if isinstance(v, list):
            box = QtWidgets.QWidget()
            lay = QtWidgets.QHBoxLayout(box)
            lay.setContentsMargins(0, 0, 0, 0)
            spins = []
            for c in v[:4]:
                sp = DoubleSpinBox()
                sp.setRange(-1e6, 1e6)
                sp.setDecimals(3)
                sp.setSingleStep(0.05)
                sp.setValue(float(c))
                spins.append(sp)
                lay.addWidget(sp)
            for sp in spins:
                sp.valueChanged.connect(lambda _v: self._edit(
                    lambda g: gm.set_input(g, name, s["id"], [x.value() for x in spins], side), True))
            return box
        if isinstance(v, bool):
            w = QtWidgets.QCheckBox()
            w.setChecked(v)
            w.toggled.connect(lambda on: self._edit(lambda g: gm.set_input(g, name, s["id"], on, side), True))
            return w
        if isinstance(v, (int, float)):
            w = DoubleSpinBox()
            w.setRange(-1e6, 1e6)
            w.setDecimals(3)
            w.setSingleStep(0.05)
            w.setValue(float(v))
            w.valueChanged.connect(lambda val: self._edit(lambda g: gm.set_input(g, name, s["id"], val, side), True))
            return w
        w = QtWidgets.QLineEdit(str(v))
        w.editingFinished.connect(lambda: self._edit(lambda g: gm.set_input(g, name, s["id"], w.text(), side), True))
        return w
