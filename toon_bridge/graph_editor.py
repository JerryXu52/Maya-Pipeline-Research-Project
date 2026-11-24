"""A Blender-style shader node editor inside Maya, for the real EEVEE node graph of a look.

Mouse (Blender / Maya habits):
  left-drag a node ............ move it            left-drag on empty ..... box select
  drag from an output socket .. connect            drag a linked input .... reconnect / pull off
  wheel ....................... zoom               middle-drag / Alt+drag .. pan
  right-click empty ........... Add node menu      right-click node ........ Delete / Mute
  Shift+A ..................... Add node           X / Delete .............. delete selected
  F / Home .................... frame all          Ctrl+Z / Ctrl+Shift+Z ... undo / redo
Click a node to edit its values and settings in the inspector beside the graph.
"""
import copy
import os

try:
    from PySide6 import QtCore, QtGui, QtWidgets
except ImportError:
    from PySide2 import QtCore, QtGui, QtWidgets

from . import graph_model as gm
from .ui import Combo, DoubleSpinBox, SpinBox

ROW = 20
HEAD = 24
PROTECTED = {"ShaderNodeOutputMaterial"}


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
            rows.append(("text", os.path.basename(d.get("image") or "") or "(no image)"))
        if d.get("type") == "ShaderNodeAttribute":
            rows.append(("text", "“%s”" % props.get("attribute_name", {}).get("value", "")))
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
        title = d.get("label") or d.get("title") or d["type"]
        if muted:
            title += "  (muted)"
        p.drawText(QtCore.QRectF(8, 0, self.w - 16, HEAD), QtCore.Qt.AlignVCenter, title)
        f.setBold(False)
        f.setPointSizeF(8.5)
        p.setFont(f)
        linked = {l[3] for l in self.view.graph["links"] if l[2] == self.name}
        for i, (kind, item) in enumerate(self.rows):
            y = HEAD + i * ROW
            r = QtCore.QRectF(10, y, self.w - 20, ROW)
            p.setPen(QtGui.QColor("#d8d5d0"))
            if kind == "out":
                p.drawText(r, QtCore.Qt.AlignVCenter | QtCore.Qt.AlignRight, item["name"])
                self._dot(p, self.w, y + ROW / 2.0, item["type"])
            elif kind == "in":
                self._dot(p, 0, y + ROW / 2.0, item["type"])
                text = item["name"]
                if item["id"] not in linked and "value" in item:
                    if item["type"] == "RGBA":
                        sw = QtCore.QRectF(self.w - 46, y + 4, 36, ROW - 8)
                        p.fillRect(sw, _qc(item["value"]))
                        p.setPen(QtGui.QColor("#111"))
                        p.drawRect(sw)
                        p.setPen(QtGui.QColor("#d8d5d0"))
                    else:
                        text = "%s  %s" % (item["name"], _fmt(item["value"]))
                p.drawText(r, QtCore.Qt.AlignVCenter | QtCore.Qt.AlignLeft, text)
            elif kind == "prop":
                pid, prop = item
                box = QtCore.QRectF(8, y + 2, self.w - 16, ROW - 4)
                p.setBrush(QtGui.QColor("#252528"))
                p.setPen(QtGui.QColor("#4a4a50"))
                p.drawRoundedRect(box, 3, 3)
                p.setPen(QtGui.QColor("#e6e3de"))
                p.drawText(box.adjusted(6, 0, -6, 0), QtCore.Qt.AlignVCenter, _enum_label(prop) + "  ▾")
            elif kind == "ramp":
                strip = QtCore.QRectF(8, y + 3, self.w - 16, ROW - 6)
                els = sorted(item["elements"], key=lambda e: e[0])
                const = item.get("interpolation") == "CONSTANT"
                if const:
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
            elif kind == "text":
                p.drawText(r, QtCore.Qt.AlignVCenter | QtCore.Qt.AlignLeft, item)

    @staticmethod
    def _dot(p, x, y, kind):
        p.setBrush(QtGui.QColor(gm.SOCKET_COLORS.get(kind, "#cccccc")))
        p.setPen(QtGui.QPen(QtGui.QColor("#111"), 1))
        p.drawEllipse(QtCore.QPointF(x, y), 5, 5)

    def itemChange(self, change, value):
        if change == QtWidgets.QGraphicsItem.ItemPositionHasChanged:
            self.view.node_moved(self)
        return super().itemChange(change, value)


# ---------------------------------------------------------------- the canvas
class GraphView(QtWidgets.QGraphicsView):
    changed = QtCore.Signal(bool)          # structural: True when Blender should rebuild
    nodeSelected = QtCore.Signal(str)

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
        self.graph = {"nodes": [], "links": []}
        self.nodes = {}
        self._drag = None          # (from_node, from_sock) while dragging a wire
        self._drag_pos = None
        self._pan = None
        self._moved = False
        self.undo_stack, self.redo_stack = [], []
        self.scene().selectionChanged.connect(self._selection)

    # ------------------------------------------------ graph in / out
    def set_graph(self, graph, keep_view=False, keep_selection=True):
        sel = self.selected_names() if keep_selection else []
        self.graph = graph
        self.nodes = {}
        self.scene().blockSignals(True)
        self.scene().clear()
        for nd in graph["nodes"]:
            it = GraphNode(self, nd)
            self.scene().addItem(it)
            self.nodes[nd["name"]] = it
            if nd["name"] in sel:
                it.setSelected(True)
        self.scene().blockSignals(False)
        if not keep_view:
            self.frame_all(readable=True)
        self.viewport().update()

    def snapshot(self):
        self.undo_stack.append(copy.deepcopy(self.graph))
        del self.undo_stack[:-50]
        self.redo_stack = []

    def undo(self):
        if self.undo_stack:
            self.redo_stack.append(copy.deepcopy(self.graph))
            self.set_graph(self.undo_stack.pop(), keep_view=True)
            self.changed.emit(True)

    def redo(self):
        if self.redo_stack:
            self.undo_stack.append(copy.deepcopy(self.graph))
            self.set_graph(self.redo_stack.pop(), keep_view=True)
            self.changed.emit(True)

    def selected_names(self):
        out = []
        for it in self.scene().selectedItems():
            if isinstance(it, GraphNode):
                out.append(it.name)
        return out

    def _selection(self):
        names = self.selected_names()
        self.nodeSelected.emit(names[0] if len(names) == 1 else "")
        self.viewport().update()

    def frame_all(self, readable=False):
        """Fit every node in view. readable=True never zooms out past where text is legible
        (big graphs then open centred, and F shows the whole thing)."""
        if not self.nodes:
            return
        r = QtCore.QRectF()
        for it in self.nodes.values():
            r = r.united(it.sceneBoundingRect())
        self.fitInView(r.adjusted(-40, -40, 40, 40), QtCore.Qt.KeepAspectRatio)
        if readable and self.transform().m11() < 0.6:
            self.resetTransform()
            self.scale(0.6, 0.6)
            self.centerOn(r.center())

    def node_moved(self, item):
        item.data["location"] = [round(item.pos().x(), 1), round(-item.pos().y(), 1)]
        self._moved = True
        self.viewport().update()

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
        # wires are painted here (not scene items): Qt deleted wire items once Maya
        # re-parented the window, so nothing outside the node items is kept alive
        p.setRenderHint(QtGui.QPainter.Antialiasing)
        for a, ao, b, bi in self.graph["links"]:
            na, nb = self.nodes.get(a), self.nodes.get(b)
            if not na or not nb:
                continue
            p1, p2 = na.socket_pos("out", ao), nb.socket_pos("in", bi)
            if p1 is None or p2 is None:
                continue
            kind = (gm.socket(na.data, "outputs", ao) or {}).get("type", "VALUE")
            self._wire(p, p1, p2, gm.SOCKET_COLORS.get(kind, "#aaa"), na.isSelected() or nb.isSelected())

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

    # ------------------------------------------------ mouse
    def _node_and_socket(self, scene_pos):
        for it in self.scene().items(scene_pos):
            if isinstance(it, GraphNode):
                return it, it.socket_at(scene_pos)
        # sockets sit on the node edge: look slightly outside too
        for it in self.nodes.values():
            s = it.socket_at(scene_pos)
            if s:
                return it, s
        return None, None

    def mousePressEvent(self, ev):
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
                if side == "outputs":
                    self._drag = (item.name, sid)
                else:      # pulling a linked input re-picks its wire from the source
                    old = gm.links_into(self.graph, item.name, sid)
                    if old:
                        self.snapshot()
                        gm.disconnect(self.graph, item.name, sid)
                        self._drag = (old[0][0], old[0][1])
                        self._detached = True
                    else:
                        return
                self._drag_pos = sp
                self.setDragMode(QtWidgets.QGraphicsView.NoDrag)
                return
            if item is not None:
                self._press_positions = {n: it.pos() for n, it in self.nodes.items()}
        super().mousePressEvent(ev)

    def mouseMoveEvent(self, ev):
        if self._pan is not None:
            d = ev.pos() - self._pan
            self._pan = ev.pos()
            self.horizontalScrollBar().setValue(self.horizontalScrollBar().value() - d.x())
            self.verticalScrollBar().setValue(self.verticalScrollBar().value() - d.y())
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
        if self._drag:
            item, sock = self._node_and_socket(self.mapToScene(ev.pos()))
            detached = getattr(self, "_detached", False)
            if item is not None and sock and sock[0] == "inputs":
                if not detached:
                    self.snapshot()
                gm.connect(self.graph, self._drag[0], self._drag[1], item.name, sock[1])
                self.changed.emit(True)
            elif detached:
                self.changed.emit(True)
            self._drag, self._drag_pos, self._detached = None, None, False
            self.setDragMode(QtWidgets.QGraphicsView.RubberBandDrag)
            self.viewport().update()
            return
        super().mouseReleaseEvent(ev)
        if self._moved:
            self._moved = False
            before = getattr(self, "_press_positions", None)
            if before:
                g = copy.deepcopy(self.graph)
                for n, pos in before.items():
                    nd = gm.node(g, n)
                    if nd:
                        nd["location"] = [round(pos.x(), 1), round(-pos.y(), 1)]
                self.undo_stack.append(g)
                self.redo_stack = []
            self.changed.emit(False)      # positions only: no rebuild needed

    def wheelEvent(self, ev):
        f = 1.15 if ev.angleDelta().y() > 0 else 1 / 1.15
        s = self.transform().m11() * f
        if 0.08 < s < 4:
            self.scale(f, f)

    def contextMenuEvent(self, ev):
        sp = self.mapToScene(ev.pos())
        item, sock = self._node_and_socket(sp)
        menu = QtWidgets.QMenu(self)
        if sock and sock[0] == "inputs" and gm.links_into(self.graph, item.name, sock[1]):
            menu.addAction("Disconnect", lambda: self._disconnect(item.name, sock[1]))
        if item is not None:
            if not item.isSelected():
                self.scene().clearSelection()
                item.setSelected(True)
            menu.addAction("Mute / Unmute", lambda: self.toggle_mute(item.name))
            menu.addAction("Delete", self.delete_selected)
            menu.addSeparator()
        add = menu.addMenu("Add node")
        self._fill_add_menu(add, sp)
        menu.exec(ev.globalPos())

    def _fill_add_menu(self, menu, scene_pos):
        for cat, entries in gm.catalog()["menu"]:
            sub = menu.addMenu(cat)
            for t, label in entries:
                sub.addAction(label, lambda tt=t, p=scene_pos: self.add_node(tt, p))

    def keyPressEvent(self, ev):
        k, mod = ev.key(), ev.modifiers()
        if k in (QtCore.Qt.Key_Delete, QtCore.Qt.Key_Backspace, QtCore.Qt.Key_X):
            self.delete_selected()
        elif k in (QtCore.Qt.Key_F, QtCore.Qt.Key_Home):
            self.frame_all()
        elif k == QtCore.Qt.Key_A and mod & QtCore.Qt.ShiftModifier:
            m = QtWidgets.QMenu(self)
            pos = self.mapToScene(self.mapFromGlobal(QtGui.QCursor.pos()))
            self._fill_add_menu(m, pos)
            m.exec(QtGui.QCursor.pos())
        elif k == QtCore.Qt.Key_Z and mod & QtCore.Qt.ControlModifier:
            self.redo() if mod & QtCore.Qt.ShiftModifier else self.undo()
        else:
            super().keyPressEvent(ev)

    # ------------------------------------------------ edits
    def add_node(self, node_type, scene_pos=None):
        self.snapshot()
        if scene_pos is None:
            scene_pos = self.mapToScene(self.viewport().rect().center())
        name = gm.add_node(self.graph, node_type, (scene_pos.x(), -scene_pos.y()))
        self.set_graph(self.graph, keep_view=True, keep_selection=False)
        self.nodes[name].setSelected(True)
        self.changed.emit(True)
        return name

    def delete_selected(self):
        names = [n for n in self.selected_names() if gm.node(self.graph, n)["type"] not in PROTECTED]
        if not names:
            return
        self.snapshot()
        for n in names:
            gm.remove_node(self.graph, n)
        self.set_graph(self.graph, keep_view=True, keep_selection=False)
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
            hint = QtWidgets.QLabel("Click a node to edit it.\nRight-click the graph to add nodes.")
            hint.setProperty("muted", True)
            self.form.addRow(hint)
            return
        title = QtWidgets.QLabel("<b>%s</b>  <span style='color:#9a979f'>%s</span>" % (
            nd.get("title", nd["type"]), nd["name"]))
        self.form.addRow(title)
        lab = QtWidgets.QLineEdit(nd.get("label", ""))
        lab.setPlaceholderText("(no label)")
        lab.editingFinished.connect(lambda: self._edit(lambda g: gm.node(g, name).__setitem__("label", lab.text()), False))
        self.form.addRow("Label", lab)
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
            path = QtWidgets.QLineEdit(nd.get("image", ""))
            path.editingFinished.connect(lambda: self._edit(lambda g: gm.node(g, name).__setitem__("image", path.text()), True))
            self.form.addRow("Image", path)
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
            for i, c in enumerate(v[:4]):
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
