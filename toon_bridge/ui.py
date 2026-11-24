"""Toon Bridge panel: three steps, all inside Maya.

    cmds.toonBridge(open=True)          # once the plug-in is loaded
    import toon_bridge.ui; toon_bridge.ui.show()

  1 STYLE   pick a style card; one click gives every object a look (by name:
            head -> skin, eye -> eyes, ground -> ground). Change any row by hand.
  2 CHECK   pre-flight runs by itself; one "Fix all" button.
  3 RENDER  one button. Frames appear below as Blender finishes them; play
            them, scrub them with the Maya timeline, show them on the camera in
            the viewport, export an MP4, or open the scene in Blender.
"""
import os
import subprocess
import sys

import maya.cmds as cmds
from maya.app.general.mayaMixin import MayaQWidgetDockableMixin

try:
    from PySide6 import QtCore, QtGui, QtWidgets
except ImportError:
    from PySide2 import QtCore, QtGui, QtWidgets

from . import exporter, launcher, looks as looks_mod, preflight, styles

WINDOW = "toonBridgePanel"
ACCENT = "#ff3d7f"
OK_C, WARN_C, ERR_C = "#3ecf8e", "#f5b83d", "#ff5a5f"
STYLE_ATTR = "defaultRenderGlobals.toonStyle"
IP_NAME = "toonBridgePreview"

QSS = """
QWidget#toonBridgePanel, QScrollArea, QWidget#tbContent { background: #262628; }
QLabel { color: #e8e6e3; }
QLabel[muted="true"] { color: #9a979f; }
QFrame#card { background: #2f2f33; border: 1px solid #3a3a40; border-radius: 10px; }
QLabel#stepNum { background: %(a)s; color: white; border-radius: 12px; font-weight: 700; }
QLabel#stepNum[done="true"] { background: #3ecf8e; }
QLabel#stepTitle { font-size: 14px; font-weight: 700; }
QToolButton#styleCard { background: #232326; border: 2px solid #3a3a40; border-radius: 10px;
    color: #e8e6e3; padding: 6px; font-weight: 600; }
QToolButton#styleCard:hover { border-color: #6a6a74; }
QToolButton#styleCard:checked { border-color: %(a)s; background: #35262d; }
QPushButton { background: #3a3a40; color: #e8e6e3; border: 1px solid #4a4a52; border-radius: 6px;
    padding: 5px 10px; }
QPushButton:hover { background: #45454d; }
QPushButton:disabled { color: #6f6d74; background: #303034; }
QPushButton:checked { background: #4a3540; border-color: %(a)s; }
QPushButton#primary { background: %(a)s; border: none; color: white; font-weight: 700; font-size: 14px;
    padding: 10px; border-radius: 8px; }
QPushButton#primary:hover { background: #ff5c94; }
QPushButton#primary:disabled { background: #5a3a46; color: #b9a6ad; }
QPushButton#seg { border-radius: 0; padding: 5px 12px; }
QPushButton#seg:checked { background: %(a)s; border-color: %(a)s; color: white; font-weight: 600; }
QPushButton#chip { border-radius: 11px; padding: 2px 10px; font-size: 11px; }
QTreeWidget { background: #232326; color: #e8e6e3; border: 1px solid #3a3a40; border-radius: 6px;
    alternate-background-color: #29292c; }
QHeaderView::section { background: #2f2f33; color: #9a979f; border: none; padding: 4px; }
QComboBox, QSpinBox, QDoubleSpinBox, QLineEdit { background: #232326; color: #e8e6e3;
    border: 1px solid #4a4a52; border-radius: 5px; padding: 3px 6px; }
QProgressBar { background: #232326; border: none; border-radius: 4px; max-height: 8px; color: transparent; }
QProgressBar::chunk { background: %(a)s; border-radius: 4px; }
QCheckBox { color: #e8e6e3; }
""" % {"a": ACCENT}


class _NoWheelMixin(object):
    """Ignore the mouse wheel unless the field was clicked into.

    In a scrolling panel the wheel otherwise lands on whatever dropdown is under
    the pointer and silently changes it (found in live Maya: scrolling the panel
    re-assigned an object's look once per wheel step).
    """

    def _no_wheel_init(self):
        self.setFocusPolicy(QtCore.Qt.StrongFocus)

    def wheelEvent(self, event):
        if self.hasFocus():
            super().wheelEvent(event)
        else:
            event.ignore()


class Combo(_NoWheelMixin, QtWidgets.QComboBox):
    def __init__(self, *a, **k):
        super().__init__(*a, **k)
        self._no_wheel_init()


class SpinBox(_NoWheelMixin, QtWidgets.QSpinBox):
    def __init__(self, *a, **k):
        super().__init__(*a, **k)
        self._no_wheel_init()


class DoubleSpinBox(_NoWheelMixin, QtWidgets.QDoubleSpinBox):
    def __init__(self, *a, **k):
        super().__init__(*a, **k)
        self._no_wheel_init()


def _style_icon(key, w=176, h=100):
    p = styles.icon_path(key)
    if os.path.isfile(p):
        pm = QtGui.QPixmap(p)
    else:
        pm = QtGui.QPixmap(w, h)
        pm.fill(QtGui.QColor("#444"))
    return QtGui.QIcon(pm.scaled(w, h, QtCore.Qt.KeepAspectRatioByExpanding, QtCore.Qt.SmoothTransformation))


def _swatch(look, size=14):
    pm = QtGui.QPixmap(size, size)
    pm.fill(QtCore.Qt.transparent)
    p = QtGui.QPainter(pm)
    p.setRenderHint(QtGui.QPainter.Antialiasing)
    base = look.get("base_color", "maya")
    base = [0.85, 0.55, 0.45] if base == "maya" else base
    p.setBrush(QtGui.QColor.fromRgbF(*[min(1.0, b) for b in base]))
    p.setPen(QtGui.QPen(QtGui.QColor("#111"), 1))
    p.drawEllipse(1, 1, size - 2, size - 2)
    p.end()
    return QtGui.QIcon(pm)


class Card(QtWidgets.QFrame):
    """A numbered step: badge, title, one-line hint, then its content."""

    def __init__(self, number, title, hint, parent=None):
        super().__init__(parent)
        self.setObjectName("card")
        self.number = str(number)
        lay = QtWidgets.QVBoxLayout(self)
        lay.setContentsMargins(14, 12, 14, 14)
        lay.setSpacing(10)
        head = QtWidgets.QHBoxLayout()
        self.badge = QtWidgets.QLabel(self.number)
        self.badge.setObjectName("stepNum")
        self.badge.setFixedSize(24, 24)
        self.badge.setAlignment(QtCore.Qt.AlignCenter)
        t = QtWidgets.QLabel(title)
        t.setObjectName("stepTitle")
        self.hint = QtWidgets.QLabel(hint)
        self.hint.setProperty("muted", True)
        self.hint.setWordWrap(True)
        head.addWidget(self.badge)
        head.addSpacing(6)
        head.addWidget(t)
        head.addStretch(1)
        lay.addLayout(head)
        lay.addWidget(self.hint)
        self.body = QtWidgets.QVBoxLayout()
        self.body.setSpacing(8)
        lay.addLayout(self.body)

    def set_done(self, done):
        self.badge.setText("✓" if done else self.number)
        self.badge.setProperty("done", bool(done))
        self.badge.style().unpolish(self.badge)
        self.badge.style().polish(self.badge)


def segmented(labels, parent=None):
    """A row of checkable buttons where exactly one is on. Returns (widget, QButtonGroup)."""
    w = QtWidgets.QWidget(parent)
    lay = QtWidgets.QHBoxLayout(w)
    lay.setContentsMargins(0, 0, 0, 0)
    lay.setSpacing(0)
    group = QtWidgets.QButtonGroup(w)
    for i, text in enumerate(labels):
        b = QtWidgets.QPushButton(text)
        b.setObjectName("seg")
        b.setCheckable(True)
        group.addButton(b, i)
        lay.addWidget(b)
    group.button(0).setChecked(True)
    return w, group


class FrameViewer(QtWidgets.QWidget):
    """Rendered frames with play / scrub. Can follow the Maya timeline."""

    def __init__(self, parent=None):
        super().__init__(parent)
        self.frames = {}
        self.fps = 24
        self._cache = {}
        self.label = QtWidgets.QLabel("Your render appears here")
        self.label.setAlignment(QtCore.Qt.AlignCenter)
        self.label.setMinimumHeight(220)
        self.label.setSizePolicy(QtWidgets.QSizePolicy.Expanding, QtWidgets.QSizePolicy.Expanding)
        self.label.setStyleSheet("background:#1b1b1d; color:#6f6d74; border-radius:8px;")
        self.play_btn = QtWidgets.QPushButton("▶")
        self.play_btn.setFixedWidth(40)
        self.play_btn.setCheckable(True)
        self.play_btn.toggled.connect(self._toggle)
        self.slider = QtWidgets.QSlider(QtCore.Qt.Horizontal)
        self.slider.valueChanged.connect(self._show_index)
        self.frame_lbl = QtWidgets.QLabel("")
        self.frame_lbl.setProperty("muted", True)
        self.frame_lbl.setMinimumWidth(70)
        self.timer = QtCore.QTimer(self)
        self.timer.timeout.connect(self._tick)
        row = QtWidgets.QHBoxLayout()
        row.addWidget(self.play_btn)
        row.addWidget(self.slider, 1)
        row.addWidget(self.frame_lbl)
        lay = QtWidgets.QVBoxLayout(self)
        lay.setContentsMargins(0, 0, 0, 0)
        lay.addWidget(self.label, 1)
        lay.addLayout(row)

    def clear(self, text="Rendering…"):
        self.frames, self._cache = {}, {}
        self.slider.setRange(0, 0)
        self.label.setPixmap(QtGui.QPixmap())
        self.label.setText(text)
        self.frame_lbl.setText("")

    def add(self, frame, path):
        self.frames[frame] = path
        self._cache.pop(frame, None)
        keys = sorted(self.frames)
        self.slider.setRange(0, len(keys) - 1)
        self.slider.setValue(keys.index(frame))
        self._show_index(keys.index(frame))

    def load_folder(self, folder):
        self.clear("Your render appears here")
        if not os.path.isdir(folder):
            return 0
        for name in sorted(os.listdir(folder)):
            parts = name.split(".")
            if name.startswith("toon.") and name.endswith(".png") and len(parts) == 3 and parts[1].isdigit():
                self.frames[int(parts[1])] = os.path.join(folder, name)
        if self.frames:
            self.slider.setRange(0, len(self.frames) - 1)
            self._show_index(0)
        return len(self.frames)

    def current_path(self):
        keys = sorted(self.frames)
        return self.frames[keys[self.slider.value()]] if keys else None

    def show_frame(self, frame):
        keys = sorted(self.frames)
        if keys:
            nearest = min(keys, key=lambda k: abs(k - frame))
            self.slider.setValue(keys.index(nearest))

    def _show_index(self, i):
        keys = sorted(self.frames)
        if not keys:
            return
        f = keys[max(0, min(i, len(keys) - 1))]
        if f not in self._cache:
            self._cache[f] = QtGui.QPixmap(self.frames[f])
        self.label.setPixmap(self._cache[f].scaled(self.label.size(), QtCore.Qt.KeepAspectRatio,
                                                   QtCore.Qt.SmoothTransformation))
        self.frame_lbl.setText("frame %d" % f)

    def _tick(self):
        if self.frames:
            self.slider.setValue((self.slider.value() + 1) % len(self.frames))

    def resizeEvent(self, ev):
        super().resizeEvent(ev)
        self._show_index(self.slider.value())

    def _toggle(self, on):
        self.play_btn.setText("❚❚" if on else "▶")
        if on and len(self.frames) > 1:
            self.timer.start(int(1000 / max(1, self.fps)))
        else:
            self.timer.stop()


class ToonBridgePanel(MayaQWidgetDockableMixin, QtWidgets.QWidget):
    def __init__(self, parent=None):
        super().__init__(parent)
        self.setObjectName(WINDOW)
        self.setWindowTitle("Toon Bridge")
        self.setStyleSheet(QSS)
        self.job = None
        self.video_job = None
        self.looks = looks_mod.load_looks()
        self.results = []
        self.style_key = "pop"
        self._jobs = []
        self._log_lines = []
        self._building_table = False

        outer = QtWidgets.QVBoxLayout(self)
        outer.setContentsMargins(0, 0, 0, 0)
        scroll = QtWidgets.QScrollArea()
        scroll.setWidgetResizable(True)
        scroll.setFrameShape(QtWidgets.QFrame.NoFrame)
        scroll.setHorizontalScrollBarPolicy(QtCore.Qt.ScrollBarAlwaysOff)
        content = QtWidgets.QWidget()
        content.setObjectName("tbContent")
        lay = QtWidgets.QVBoxLayout(content)
        lay.setContentsMargins(12, 12, 12, 12)
        lay.setSpacing(12)
        lay.addLayout(self._build_header())
        self.render_card = self._build_render()      # built first: other steps read its settings
        self.style_card = self._build_style()
        self.check_card = self._build_check()
        self.result_card = self._build_result()
        for c in (self.style_card, self.check_card, self.render_card, self.result_card):
            lay.addWidget(c)
        lay.addStretch(1)
        scroll.setWidget(content)
        outer.addWidget(scroll)

        self.refresh()
        self._install_script_jobs()

    # ------------------------------------------------------------------ header
    def _build_header(self):
        row = QtWidgets.QHBoxLayout()
        col = QtWidgets.QVBoxLayout()
        title = QtWidgets.QLabel("Toon Bridge")
        title.setStyleSheet("font-size:20px; font-weight:800;")
        sub = QtWidgets.QLabel("Render your Maya shot in a comic style with Blender EEVEE")
        sub.setProperty("muted", True)
        sub.setWordWrap(True)
        col.addWidget(title)
        col.addWidget(sub)
        row.addLayout(col, 1)
        self.blender_chip = QtWidgets.QPushButton()
        self.blender_chip.setObjectName("chip")
        self.blender_chip.clicked.connect(self.browse_blender)
        row.addWidget(self.blender_chip, 0, QtCore.Qt.AlignTop)
        return row

    def _update_blender_chip(self):
        path = launcher.find_blender()
        if path:
            v = launcher.blender_version(path) or ""
            self.blender_chip.setText("●  Blender %s" % v)
            self.blender_chip.setStyleSheet("color:%s;" % OK_C)
            self.blender_chip.setToolTip(path + "\nClick to choose a different Blender.")
        else:
            self.blender_chip.setText("●  Blender not found — set it")
            self.blender_chip.setStyleSheet("color:%s;" % ERR_C)
            self.blender_chip.setToolTip("Click to choose Blender.app / blender.exe")

    # ------------------------------------------------------------------ 1 style
    def _build_style(self):
        card = Card(1, "Choose a style", "Pick a look for the whole shot. Change any object in the list.")
        grid = QtWidgets.QGridLayout()
        grid.setSpacing(8)
        self.style_group = QtWidgets.QButtonGroup(self)
        self.style_buttons = {}
        for i, key in enumerate(styles.ORDER):
            st = styles.STYLES[key]
            b = QtWidgets.QToolButton()
            b.setObjectName("styleCard")
            b.setCheckable(True)
            b.setIcon(_style_icon(key))
            b.setIconSize(QtCore.QSize(176, 100))
            b.setMinimumWidth(120)
            b.setText(st["label"])
            b.setToolTip(st["blurb"])
            b.setToolButtonStyle(QtCore.Qt.ToolButtonTextUnderIcon)
            b.setSizePolicy(QtWidgets.QSizePolicy.Expanding, QtWidgets.QSizePolicy.Fixed)
            b.clicked.connect(lambda _=False, k=key: self.choose_style(k))
            self.style_group.addButton(b)
            self.style_buttons[key] = b
            grid.addWidget(b, i // 2, i % 2)
        card.body.addLayout(grid)
        self.style_blurb = QtWidgets.QLabel("")
        self.style_blurb.setProperty("muted", True)
        card.body.addWidget(self.style_blurb)

        row = QtWidgets.QHBoxLayout()
        self.apply_btn = QtWidgets.QPushButton("Apply style to all objects")
        self.apply_btn.clicked.connect(lambda: self.apply_style(overwrite=self.overwrite_chk.isChecked()))
        self.overwrite_chk = QtWidgets.QCheckBox("Also replace looks picked by hand")
        row.addWidget(self.apply_btn)
        row.addWidget(self.overwrite_chk)
        row.addStretch(1)
        card.body.addLayout(row)

        self.obj_filter = QtWidgets.QLineEdit()
        self.obj_filter.setPlaceholderText("Filter objects…")
        self.obj_filter.textChanged.connect(self._filter_table)
        card.body.addWidget(self.obj_filter)
        self.obj_table = QtWidgets.QTreeWidget()
        self.obj_table.setHeaderLabels(["Object", "Look"])
        self.obj_table.setRootIsDecorated(False)
        self.obj_table.setAlternatingRowColors(True)
        self.obj_table.setSelectionMode(QtWidgets.QAbstractItemView.ExtendedSelection)
        self.obj_table.setColumnWidth(0, 150)
        self.obj_table.setHorizontalScrollBarPolicy(QtCore.Qt.ScrollBarAlwaysOff)
        self.obj_table.header().setStretchLastSection(True)
        self.obj_table.setMinimumHeight(180)
        self.obj_table.itemSelectionChanged.connect(self._table_to_maya_selection)
        card.body.addWidget(self.obj_table)

        row2 = QtWidgets.QHBoxLayout()
        row2.addWidget(QtWidgets.QLabel("Maya selection →"))
        self.sel_look_combo = self._look_combo()
        row2.addWidget(self.sel_look_combo, 1)
        b = QtWidgets.QPushButton("Assign")
        b.clicked.connect(self.assign_to_selection)
        row2.addWidget(b)
        card.body.addLayout(row2)
        self.preview_chk = QtWidgets.QCheckBox("Preview looks in the viewport (rough)")
        self.preview_chk.toggled.connect(self.toggle_preview)
        card.body.addWidget(self.preview_chk)
        return card

    def _look_combo(self, current=None):
        c = Combo()
        # long look names must not make the panel wider than its dock
        c.setSizeAdjustPolicy(QtWidgets.QComboBox.AdjustToMinimumContentsLengthWithIcon)
        c.setMinimumContentsLength(10)
        for name, look in self.looks.items():
            c.addItem(_swatch(look), look.get("label", name), name)
        if current:
            i = c.findData(current)
            if i >= 0:
                c.setCurrentIndex(i)
        return c

    def _scene_style(self):
        if cmds.objExists(STYLE_ATTR):
            k = cmds.getAttr(STYLE_ATTR)
            if k in styles.STYLES:
                return k
        return "pop"

    def _save_scene_style(self, key):
        if not cmds.objExists(STYLE_ATTR):
            cmds.addAttr("defaultRenderGlobals", longName="toonStyle", dataType="string")
        cmds.setAttr(STYLE_ATTR, key, type="string")

    def _show_style(self, key):
        st = styles.STYLES[key]
        self.style_buttons[key].setChecked(True)
        self.style_blurb.setText(st["blurb"])
        s = st["settings"]
        self.line_combo.setCurrentIndex(max(0, self.line_combo.findData(s.get("line_mode", "ink"))))
        self.misreg_spin.setValue(s.get("misregister_px", 0))
        self.twos_chk.setChecked(s.get("on_twos", False))

    def choose_style(self, key, apply=True):
        """Select a style: its render settings, its background, and looks for objects without one."""
        self.style_key = key
        self._show_style(key)
        exporter.set_scene_background(styles.STYLES[key]["background"])
        self._save_scene_style(key)
        self._show_background()
        if apply:
            self.apply_style(overwrite=False)

    def apply_style(self, overwrite=False):
        n = styles.apply(self.style_key, self._meshes(), overwrite=overwrite)
        kept = len([t for t in self._meshes() if looks_mod.get_source(t) == "hand"]) if not overwrite else 0
        self.status("%s: restyled %d object(s)%s." % (styles.STYLES[self.style_key]["label"], n,
                    ", kept %d you picked by hand" % kept if kept else ""))
        if self.preview_chk.isChecked():
            looks_mod.preview_on()
        self.refresh_table()
        self.run_check()
        return n

    def _selected_objects(self):
        if self.sel_only_chk.isChecked():
            return cmds.ls(selection=True, long=True) or None
        return None

    def _meshes(self):
        return looks_mod.mesh_transforms(self._selected_objects())

    def refresh_table(self):
        self._building_table = True
        self.obj_table.clear()
        for t in looks_mod.mesh_transforms():
            it = QtWidgets.QTreeWidgetItem([exporter.short_name(t), ""])
            it.setData(0, QtCore.Qt.UserRole, t)
            it.setToolTip(0, t)
            self.obj_table.addTopLevelItem(it)
            look = looks_mod.get_look(t)
            combo = self._look_combo(look)
            if not look:
                combo.insertItem(0, "— none —", None)
                combo.setCurrentIndex(0)
            combo.currentIndexChanged.connect(lambda _i, tt=t, c=combo: self._row_look_changed(tt, c))
            self.obj_table.setItemWidget(it, 1, combo)
        self._building_table = False
        self._filter_table(self.obj_filter.text())

    def _row_look_changed(self, transform, combo):
        if self._building_table:
            return
        look = combo.currentData()
        if look:
            looks_mod.assign(look, [transform])
            if self.preview_chk.isChecked():
                looks_mod.preview_on([transform])
            self.status("%s → %s" % (exporter.short_name(transform), look))
            self.run_check()

    def _filter_table(self, text):
        text = (text or "").lower()
        for i in range(self.obj_table.topLevelItemCount()):
            it = self.obj_table.topLevelItem(i)
            it.setHidden(bool(text) and text not in it.text(0).lower())

    def _table_to_maya_selection(self):
        if self._building_table:
            return
        nodes = [it.data(0, QtCore.Qt.UserRole) for it in self.obj_table.selectedItems()]
        nodes = [n for n in nodes if cmds.objExists(n)]
        if nodes:
            cmds.select(nodes, replace=True)

    def assign_to_selection(self):
        look = self.sel_look_combo.currentData()
        done = looks_mod.assign(look)
        if not done:
            self.status("Select some meshes in Maya first.")
            return []
        if self.preview_chk.isChecked():
            looks_mod.preview_on(done)
        self.status("Gave %d selected object(s) the look %s." % (len(done), look))
        self.refresh_table()
        self.run_check()
        return done

    def toggle_preview(self, on):
        n = looks_mod.preview_on() if on else looks_mod.preview_off()
        self.status("Viewport preview %s (%d objects)." % ("on" if on else "off", len(n)))

    # ------------------------------------------------------------------ 2 check
    def _build_check(self):
        card = Card(2, "Check the scene", "Runs by itself. A fix only touches what the check found.")
        row = QtWidgets.QHBoxLayout()
        self.check_summary = QtWidgets.QLabel("")
        self.fix_all_btn = QtWidgets.QPushButton("Fix all")
        self.fix_all_btn.clicked.connect(self.fix_all)
        recheck = QtWidgets.QPushButton("Check again")
        recheck.clicked.connect(self.run_check)
        row.addWidget(self.check_summary, 1)
        row.addWidget(self.fix_all_btn)
        row.addWidget(recheck)
        card.body.addLayout(row)
        self.issue_box = QtWidgets.QVBoxLayout()
        self.issue_box.setSpacing(6)
        card.body.addLayout(self.issue_box)
        return card

    def run_check(self):
        self.results = preflight.run_all(camera=self.cam_combo.currentData(), objects=self._selected_objects())
        for r in self.results:
            # objects without a look get the current style's looks, not a generic default
            if r.title == "Looks assigned" and r.status == preflight.WARN and r.nodes:
                r.fix = lambda nodes=list(r.nodes): styles.apply(self.style_key, nodes)
                r.fix_label = "Use %s looks" % styles.STYLES[self.style_key]["label"]
        while self.issue_box.count():
            w = self.issue_box.takeAt(0).widget()
            if w:
                w.deleteLater()
        issues = [r for r in self.results if r.status != preflight.OK]
        errors = preflight.blocking(self.results)
        for r in issues:
            self.issue_box.addWidget(self._issue_row(r))
        if errors:
            text, color = "✖  %d problem(s) to fix before rendering" % len(errors), ERR_C
        elif issues:
            text, color = "✔  Ready — %d note(s)" % len(issues), WARN_C
        else:
            text, color = "✔  Ready to render", OK_C
        self.check_summary.setText(text)
        self.check_summary.setStyleSheet("font-weight:600; color:%s;" % color)
        self.fix_all_btn.setVisible(any(r.fix for r in issues))
        self.check_card.set_done(not errors)
        return not errors

    def _issue_row(self, r):
        w = QtWidgets.QFrame()
        w.setStyleSheet("QFrame{background:#262628;border-radius:6px;}")
        lay = QtWidgets.QHBoxLayout(w)
        lay.setContentsMargins(8, 6, 8, 6)
        dot = QtWidgets.QLabel("●")
        dot.setStyleSheet("color:%s;" % (ERR_C if r.status == preflight.ERROR else WARN_C))
        text = QtWidgets.QLabel("<b>%s</b><br><span style='color:#9a979f'>%s</span>" % (r.title, r.summary))
        text.setWordWrap(True)
        lay.addWidget(dot, 0, QtCore.Qt.AlignTop)
        lay.addWidget(text, 1)
        if r.nodes:
            s = QtWidgets.QPushButton("Select")
            s.clicked.connect(lambda _=False, n=r.nodes: cmds.select([x for x in n if cmds.objExists(x)], replace=True))
            lay.addWidget(s)
        if r.fix:
            f = QtWidgets.QPushButton(r.fix_label or "Fix")
            f.clicked.connect(lambda _=False, rr=r: self._apply_fixes([rr]))
            lay.addWidget(f)
        return w

    def _apply_fixes(self, results):
        cmds.undoInfo(openChunk=True, chunkName="toonBridgeFix")
        try:
            for r in results:
                if r.fix:
                    r.fix()
        finally:
            cmds.undoInfo(closeChunk=True)
        self.refresh_table()
        return self.run_check()

    def fix_all(self):
        """Apply every available fix; a fix can uncover the next issue, so loop a few times."""
        for _ in range(3):
            todo = [r for r in self.results if r.fix and r.status != preflight.OK]
            if not todo:
                break
            self._apply_fixes(todo)
        self.status("Fixed what could be fixed automatically (Ctrl+Z undoes a fix).")
        return not preflight.blocking(self.results)

    # ------------------------------------------------------------------ 3 render
    def _build_render(self):
        card = Card(3, "Render", "Blender works in the background; Maya stays usable.")
        form = QtWidgets.QFormLayout()
        form.setLabelAlignment(QtCore.Qt.AlignRight)
        self.cam_combo = Combo()
        self.cam_combo.setSizeAdjustPolicy(QtWidgets.QComboBox.AdjustToMinimumContentsLengthWithIcon)
        self.cam_combo.setMinimumContentsLength(12)
        form.addRow("Camera", self.cam_combo)
        range_w, self.range_group = segmented(["This frame", "Playback", "Custom"])
        self.range_group.idToggled.connect(lambda _i, _on: self._update_range_label())
        form.addRow("Frames", range_w)
        crow = QtWidgets.QHBoxLayout()
        crow.setContentsMargins(0, 0, 0, 0)
        self.start_spin = SpinBox()
        self.end_spin = SpinBox()
        for s in (self.start_spin, self.end_spin):
            s.setRange(-100000, 100000)
            s.valueChanged.connect(lambda _v: self._update_range_label())
        crow.addWidget(self.start_spin)
        crow.addWidget(QtWidgets.QLabel("to"))
        crow.addWidget(self.end_spin)
        crow.addStretch(1)
        self.custom_row = QtWidgets.QWidget()
        self.custom_row.setLayout(crow)
        form.addRow("", self.custom_row)
        q_w, self.quality_group = segmented(["Final", "Quick preview"])
        for g in (self.range_group, self.quality_group):
            for b in g.buttons():
                b.setSizePolicy(QtWidgets.QSizePolicy.Expanding, QtWidgets.QSizePolicy.Fixed)
        form.addRow("Quality", q_w)
        card.body.addLayout(form)

        self.render_btn = QtWidgets.QPushButton("Render")
        self.render_btn.setObjectName("primary")
        self.render_btn.clicked.connect(self.render_clicked)
        card.body.addWidget(self.render_btn)
        prow = QtWidgets.QHBoxLayout()
        self.progress = QtWidgets.QProgressBar()
        self.progress.setRange(0, 1)
        self.progress.setValue(0)
        self.progress.setTextVisible(False)
        self.stop_btn = QtWidgets.QPushButton("Cancel")
        self.stop_btn.setVisible(False)
        self.stop_btn.clicked.connect(self.stop)
        prow.addWidget(self.progress, 1)
        prow.addWidget(self.stop_btn)
        card.body.addLayout(prow)
        self.status_lbl = QtWidgets.QLabel("")
        self.status_lbl.setWordWrap(True)
        self.status_lbl.setProperty("muted", True)
        card.body.addWidget(self.status_lbl)

        self.adv_btn = QtWidgets.QToolButton()
        self.adv_btn.setText("▸  Advanced settings")
        self.adv_btn.setCheckable(True)
        self.adv_btn.setStyleSheet("QToolButton{color:#9a979f;border:none;background:transparent;}")
        self.adv_btn.toggled.connect(self._toggle_advanced)
        card.body.addWidget(self.adv_btn)
        self.adv = QtWidgets.QWidget()
        af = QtWidgets.QFormLayout(self.adv)
        af.setLabelAlignment(QtCore.Qt.AlignRight)
        self.line_combo = Combo()
        for label, mode in [("2D ink lines", "ink"), ("3D outlines (hull)", "hull"), ("Both", "both")]:
            self.line_combo.addItem(label, mode)
        af.addRow("Lines", self.line_combo)
        self.outline_spin = DoubleSpinBox()
        self.outline_spin.setRange(0.0, 10.0)
        self.outline_spin.setSingleStep(0.25)
        self.outline_spin.setValue(1.0)
        self.outline_spin.setSuffix(" ×")
        self.outline_spin.setToolTip("0 turns lines off")
        af.addRow("Line width", self.outline_spin)
        self.misreg_spin = SpinBox()
        self.misreg_spin.setRange(0, 12)
        self.misreg_spin.setSuffix(" px")
        af.addRow("Colour offset", self.misreg_spin)
        self.twos_chk = QtWidgets.QCheckBox("Animate on twos")
        self.twos_chk.setToolTip("Hold each rendered drawing for two frames, like hand-drawn animation")
        af.addRow("", self.twos_chk)
        self.bg_btn = QtWidgets.QPushButton()
        self.bg_btn.setFixedWidth(70)
        self.bg_btn.clicked.connect(self.pick_background)
        af.addRow("Background", self.bg_btn)
        self.transp_chk = QtWidgets.QCheckBox("Transparent background")
        af.addRow("", self.transp_chk)
        self.sel_only_chk = QtWidgets.QCheckBox("Only selected objects")
        self.sel_only_chk.setToolTip("Send just the Maya selection, e.g. to leave out rig control shapes")
        af.addRow("", self.sel_only_chk)
        orow = QtWidgets.QHBoxLayout()
        self.out_edit = QtWidgets.QLineEdit()
        ob = QtWidgets.QPushButton("…")
        ob.setFixedWidth(30)
        ob.clicked.connect(self.browse_out)
        orow.addWidget(self.out_edit, 1)
        orow.addWidget(ob)
        af.addRow("Output", orow)
        self.adv.setVisible(False)
        card.body.addWidget(self.adv)
        return card

    def _toggle_advanced(self, on):
        self.adv.setVisible(on)
        self.adv_btn.setText(("▾" if on else "▸") + "  Advanced settings")

    def _update_range_label(self):
        rid = self.range_group.checkedId()
        self.custom_row.setVisible(rid == 2)
        a, b = self.frame_range()
        self.render_btn.setText("Render frame %d" % a if a == b else "Render frames %d–%d" % (a, b))

    def frame_range(self):
        rid = self.range_group.checkedId()
        if rid == 0:
            f = int(cmds.currentTime(query=True))
            return f, f
        if rid == 1:
            return (int(cmds.playbackOptions(query=True, minTime=True)),
                    int(cmds.playbackOptions(query=True, maxTime=True)))
        return self.start_spin.value(), self.end_spin.value()

    def settings(self):
        return {
            "outlines": self.outline_spin.value() > 0,
            "outline_scale": max(self.outline_spin.value(), 0.01),
            "line_mode": self.line_combo.currentData(),
            "misregister_px": self.misreg_spin.value(),
            "on_twos": self.twos_chk.isChecked(),
            "transparent": self.transp_chk.isChecked(),
        }

    def _show_background(self):
        rgb = exporter.scene_background() or exporter.DEFAULT_SETTINGS["background"]
        self.bg_btn.setStyleSheet("background:%s; border:1px solid #555; border-radius:5px;"
                                  % QtGui.QColor.fromRgbF(*rgb).name())

    def pick_background(self):
        rgb = exporter.scene_background() or exporter.DEFAULT_SETTINGS["background"]
        c = QtWidgets.QColorDialog.getColor(QtGui.QColor.fromRgbF(*rgb), self, "Background colour")
        if c.isValid():
            exporter.set_scene_background([c.redF(), c.greenF(), c.blueF()])
            self._show_background()

    def browse_out(self):
        d = QtWidgets.QFileDialog.getExistingDirectory(self, "Output folder", self.out_edit.text())
        if d:
            self.out_edit.setText(d)
            self.load_last_render()

    def browse_blender(self):
        start = "/Applications" if sys.platform == "darwin" else ""
        p, _ = QtWidgets.QFileDialog.getOpenFileName(self, "Choose Blender", start)
        if p:
            if p.endswith(".app"):
                p = os.path.join(p, "Contents", "MacOS", "Blender")
            launcher.save_path(p)
            self._update_blender_chip()
            self.run_check()

    def render_clicked(self):
        self.render(ask=True)

    def render(self, current_only=None, ask=True):
        """Check (and fix, if the user agrees), export, start Blender. True if a job started."""
        if self.job and self.job.running():
            return False
        if current_only is not None:
            self.range_group.button(0 if current_only else 1).setChecked(True)
        if not self.run_check():
            if not all(r.fix for r in preflight.blocking(self.results)):
                self.status("Fix the red items in step 2 first.")
                return False
            if ask:
                box = QtWidgets.QMessageBox(QtWidgets.QMessageBox.Question, "Toon Bridge",
                                            "The check found problems it can fix for you.", parent=self)
                go = box.addButton("Fix and render", QtWidgets.QMessageBox.AcceptRole)
                box.addButton(QtWidgets.QMessageBox.Cancel)
                box.exec()
                if box.clickedButton() is not go:
                    return False
            if not self.fix_all():
                self.status("Some problems need a manual fix (step 2).")
                return False
        start, end = self.frame_range()
        single = start == end
        root = self.out_edit.text() or exporter.default_shot_dir()
        shot_dir = os.path.join(root, "current_frame") if single else root
        self.status("Exporting %s…" % ("frame %d" % start if single else "frames %d–%d" % (start, end)))
        # No processEvents() here: pumping Qt events mid-command crashed Maya (see tests/ui_smoke.py).
        try:
            shot = exporter.export_shot(self.cam_combo.currentData(), start, end, shot_dir,
                                        self.settings(), objects=self._selected_objects())
        except Exception as exc:
            self.status("Export failed: %s" % exc)
            return False
        self.last_shot_dir = shot_dir
        preview = self.quality_group.checkedId() == 1
        self.job = launcher.BlenderJob(launcher.build_command(shot, preview=preview), self)
        self.job.message.connect(self._log)
        self.job.progress.connect(self._progress)
        self.job.frame_done.connect(self.viewer.add)
        self.job.finished.connect(self._finished)
        self.viewer.clear()
        self.viewer.fps = int(round(exporter._fps()))
        self.progress.setRange(0, 0)
        self._busy(True)
        self.status("Blender is rendering…")
        self.job.start()
        return True

    def stop(self):
        if self.job:
            self.job.stop()

    def _progress(self, done, total):
        self.progress.setRange(0, max(1, total))
        self.progress.setValue(done)
        if total and done:
            self.status("Blender is rendering: frame %d of %d" % (done, total))

    def _finished(self, ok, summary):
        self._busy(False)
        self.progress.setRange(0, 1)
        self.progress.setValue(1 if ok else 0)
        self.status(("✔ " + summary) if ok else summary)
        self.render_card.set_done(ok)
        self._update_result_buttons()
        if ok and self.ip_btn.isChecked():
            self.show_in_viewport(True)

    def _busy(self, on):
        self.render_btn.setEnabled(not on)
        self.stop_btn.setVisible(on)

    def _log(self, line):
        self._log_lines.append(line)
        del self._log_lines[:-400]

    # ------------------------------------------------------------------ result
    def _build_result(self):
        card = Card(4, "Result", "Play it here, or scrub it on the camera in the viewport.")
        card.badge.setText("▶")
        card.number = "▶"
        self.viewer = FrameViewer()
        card.body.addWidget(self.viewer)
        self.follow_chk = QtWidgets.QCheckBox("Follow the Maya timeline")
        self.follow_chk.setChecked(True)
        card.body.addWidget(self.follow_chk)
        grid = QtWidgets.QGridLayout()
        grid.setSpacing(6)
        self.ip_btn = QtWidgets.QPushButton("Show in viewport")
        self.ip_btn.setCheckable(True)
        self.ip_btn.setToolTip("Puts the rendered frames on the camera as an image plane:\n"
                               "look through the camera and scrub the timeline.")
        self.ip_btn.toggled.connect(self.show_in_viewport)
        self.rv_btn = QtWidgets.QPushButton("Render View")
        self.rv_btn.clicked.connect(self.to_render_view)
        self.mp4_btn = QtWidgets.QPushButton("Export MP4…")
        self.mp4_btn.clicked.connect(lambda: self.export_mp4())
        self.blend_btn = QtWidgets.QPushButton("Open in Blender")
        self.blend_btn.clicked.connect(self.open_blend)
        self.folder_btn = QtWidgets.QPushButton("Show files")
        self.folder_btn.clicked.connect(self.open_folder)
        self.log_btn = QtWidgets.QPushButton("Log")
        self.log_btn.clicked.connect(self.show_log)
        for i, b in enumerate([self.ip_btn, self.rv_btn, self.mp4_btn, self.blend_btn, self.folder_btn, self.log_btn]):
            grid.addWidget(b, i // 3, i % 3)
        card.body.addLayout(grid)
        return card

    def _shot_dir(self):
        return getattr(self, "last_shot_dir", None) or self.out_edit.text()

    def _frames_dir(self):
        return os.path.join(self._shot_dir(), "frames")

    def _update_result_buttons(self):
        has = bool(self.viewer.frames)
        for b in (self.ip_btn, self.rv_btn, self.mp4_btn, self.folder_btn):
            b.setEnabled(has)
        self.blend_btn.setEnabled(os.path.isfile(os.path.join(self._shot_dir(), "toon_shot.blend")))

    def load_last_render(self):
        """Show frames already on disk for this scene (e.g. rendered last session)."""
        n = self.viewer.load_folder(os.path.join(self.out_edit.text(), "frames"))
        self.last_shot_dir = self.out_edit.text() if n else None
        if n:
            self.status("Showing your last render (%d frames)." % n)
        self._update_result_buttons()
        return n

    def show_in_viewport(self, on):
        """An image plane on the render camera with the toon frames, following the timeline."""
        for ip in cmds.ls(IP_NAME + "*", type="imagePlane") or []:
            parent = cmds.listRelatives(ip, parent=True)
            cmds.delete(parent or ip)
        if not on:
            self.status("Removed the toon frames from the camera.")
            return None
        first = self.viewer.frames.get(min(self.viewer.frames)) if self.viewer.frames else None
        cam = self.cam_combo.currentData()
        if not first or not cam:
            self.ip_btn.blockSignals(True)
            self.ip_btn.setChecked(False)
            self.ip_btn.blockSignals(False)
            return None
        shape = cmds.listRelatives(cam, shapes=True, type="camera", fullPath=True)[0]
        _t, s = cmds.imagePlane(camera=shape, fileName=first, name=IP_NAME)
        if len(self.viewer.frames) > 1:
            cmds.setAttr(s + ".useFrameExtension", 1)
        cmds.setAttr(s + ".fit", 1)                       # best fit to the resolution gate
        # The frames are finished display colours. Maya's colour management would run
        # them through its film view transform again and wash them out (seen live).
        cm = s + ".colorManagementEnabled"
        if cmds.objExists(cm):
            for src in cmds.listConnections(cm, source=True, destination=False, plugs=True) or []:
                cmds.disconnectAttr(src, cm)      # it follows the global switch; only this plane opts out
            cmds.setAttr(cm, 0)
        near = cmds.getAttr(shape + ".nearClipPlane")
        cmds.setAttr(s + ".depth", max(near * 2.0, 0.2))  # in front of every object
        self.status("Look through %s and scrub the timeline to see the toon frames." % exporter.short_name(cam))
        return s

    def to_render_view(self):
        path = self.viewer.current_path()
        if path and not cmds.about(batch=True):
            if not cmds.window("renderViewWindow", exists=True):
                cmds.RenderViewWindow()
            cmds.renderWindowEditor("renderView", edit=True, loadImage=path)

    def export_mp4(self, out_path=None):
        if not out_path:
            default = os.path.join(self._shot_dir(), "toon_shot.mp4")
            out_path, _ = QtWidgets.QFileDialog.getSaveFileName(self, "Export MP4", default, "MP4 video (*.mp4)")
            if not out_path:
                return None
        cmd = launcher.video_command(self._frames_dir(), out_path, exporter._fps())
        self.video_job = launcher.BlenderJob(cmd, self)
        self.video_job.finished.connect(lambda ok, s, p=out_path: self.status(
            ("✔ Saved %s" % p) if ok and os.path.isfile(p) else "MP4 export failed: %s" % s))
        self.status("Writing MP4…")
        self.video_job.start()
        return self.video_job

    def open_folder(self):
        d = self._frames_dir()
        d = d if os.path.isdir(d) else self._shot_dir()
        opener = "open" if sys.platform == "darwin" else ("explorer" if sys.platform.startswith("win") else "xdg-open")
        subprocess.Popen([opener, d])

    def open_blend(self):
        blend = os.path.join(self._shot_dir(), "toon_shot.blend")
        blender = launcher.find_blender()
        if os.path.isfile(blend) and blender:
            subprocess.Popen([blender, blend], env=launcher._clean_env())

    def show_log(self):
        box = QtWidgets.QDialog(self)
        box.setWindowTitle("Toon Bridge log")
        box.resize(640, 420)
        lay = QtWidgets.QVBoxLayout(box)
        t = QtWidgets.QPlainTextEdit("\n".join(self._log_lines) or "(nothing yet)")
        t.setReadOnly(True)
        lay.addWidget(t)
        box.show()

    # ------------------------------------------------------------------ plumbing
    def status(self, text):
        self.status_lbl.setText(text)
        print("[Toon Bridge] " + text)

    def refresh(self, *_args):
        """Re-read the scene: cameras, style, objects, background, check, last render."""
        self._update_blender_chip()
        cur = self.cam_combo.currentData()
        self.cam_combo.clear()
        for c in exporter.render_cameras():
            self.cam_combo.addItem(exporter.short_name(c), c)
        if cur and self.cam_combo.findData(cur) >= 0:
            self.cam_combo.setCurrentIndex(self.cam_combo.findData(cur))
        self.start_spin.setValue(int(cmds.playbackOptions(query=True, minTime=True)))
        self.end_spin.setValue(int(cmds.playbackOptions(query=True, maxTime=True)))
        self.out_edit.setText(exporter.default_shot_dir())
        self.style_key = self._scene_style()
        self._show_style(self.style_key)
        self._show_background()
        self.refresh_table()
        self._update_range_label()
        self.run_check()
        self.load_last_render()

    def _install_script_jobs(self):
        if cmds.about(batch=True):
            return
        self._jobs.append(cmds.scriptJob(event=["timeChanged", self._time_changed], protected=False))
        self._jobs.append(cmds.scriptJob(event=["SceneOpened", self._scene_changed], protected=False))
        self._jobs.append(cmds.scriptJob(event=["NewSceneOpened", self._scene_changed], protected=False))
        jobs = list(self._jobs)
        self.destroyed.connect(lambda *_a: kill_jobs(jobs))

    def _scene_changed(self):
        try:
            self.refresh()
        except RuntimeError:
            pass

    def _time_changed(self):
        try:
            if self.follow_chk.isChecked() and self.viewer.frames:
                self.viewer.show_frame(int(cmds.currentTime(query=True)))
            if self.range_group.checkedId() == 0:
                self._update_range_label()
        except RuntimeError:       # panel already deleted
            pass

    def dockCloseEventTriggered(self):
        kill_jobs(self._jobs)
        self._jobs = []


def kill_jobs(jobs):
    for j in jobs:
        try:
            if cmds.scriptJob(exists=j):
                cmds.scriptJob(kill=j, force=True)
        except RuntimeError:
            pass


_panel = None


def panel():
    return _panel


def show():
    """Open (or re-open) the panel, docked on the right of Maya."""
    global _panel
    ctrl = WINDOW + "WorkspaceControl"
    if cmds.workspaceControl(ctrl, exists=True):
        cmds.deleteUI(ctrl)
    if _panel is not None:
        try:
            kill_jobs(_panel._jobs)
            _panel.deleteLater()
        except RuntimeError:
            pass
    _panel = ToonBridgePanel()
    _panel.show(dockable=True, floating=False, area="right", width=460, height=900)
    return _panel


def close():
    global _panel
    if _panel is not None:
        try:
            kill_jobs(_panel._jobs)
        except RuntimeError:
            pass
    ctrl = WINDOW + "WorkspaceControl"
    if cmds.workspaceControl(ctrl, exists=True):
        cmds.deleteUI(ctrl)
    _panel = None
