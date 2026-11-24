"""Toon Bridge panel for Maya.

    import toon_bridge.ui; toon_bridge.ui.show()

Sections, top to bottom, follow the artist's order of work:
  Looks      pick a look, assign it to the selection, toggle a viewport preview
  Shot       camera, frame range, outlines, quality
  Pre-flight checks the scene, selects problems, applies safe fixes
  Render     current frame or whole shot; Blender runs in the background
  Result     the rendered frames, with a flipbook, Render View and Open in Blender
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

from . import exporter, launcher, looks as looks_mod, preflight

WINDOW = "toonBridgePanel"
STATUS_COLORS = {preflight.OK: "#4caf50", preflight.WARN: "#f0b429", preflight.ERROR: "#e5484d"}


def look_icon(look, size=28):
    """Paint a little toon sphere from the look's bands, so the list reads at a glance."""
    pm = QtGui.QPixmap(size, size)
    pm.fill(QtCore.Qt.transparent)
    p = QtGui.QPainter(pm)
    p.setRenderHint(QtGui.QPainter.Antialiasing)
    base = look.get("base_color", "maya")
    base = [0.85, 0.6, 0.45] if base == "maya" else base
    bands = look.get("bands", [[0.0, [1, 1, 1]]])
    r = size / 2.0 - 2
    c = QtCore.QPointF(size / 2.0, size / 2.0)
    # draw from darkest band (whole disc) to brightest (small offset disc)
    for i, (_, mult) in enumerate(bands):
        col = QtGui.QColor.fromRgbF(*[min(1.0, b * m) for b, m in zip(base, mult)])
        k = 1.0 - 0.45 * i / max(1, len(bands) - 1) if len(bands) > 1 else 1.0
        off = (1.0 - k) * r * 0.6
        p.setPen(QtCore.Qt.NoPen)
        p.setBrush(col)
        p.drawEllipse(QtCore.QPointF(c.x() - off, c.y() - off), r * k, r * k)
    ol = look.get("outline")
    if ol:
        pen = QtGui.QPen(QtGui.QColor.fromRgbF(*ol.get("color", [0, 0, 0])))
        pen.setWidthF(1.6)
        p.setPen(pen)
        p.setBrush(QtCore.Qt.NoBrush)
        p.drawEllipse(c, r, r)
    p.end()
    return QtGui.QIcon(pm)


class FrameViewer(QtWidgets.QWidget):
    """Shows rendered frames; plays them as a flipbook."""

    def __init__(self, parent=None):
        super().__init__(parent)
        self.frames = {}          # frame number -> path
        self.fps = 24
        self.label = QtWidgets.QLabel("No render yet")
        self.label.setAlignment(QtCore.Qt.AlignCenter)
        self.label.setMinimumHeight(180)
        self.label.setSizePolicy(QtWidgets.QSizePolicy.Expanding, QtWidgets.QSizePolicy.Expanding)
        self.label.setStyleSheet("background:#1d1d1d; color:#777; border-radius:4px;")
        self.slider = QtWidgets.QSlider(QtCore.Qt.Horizontal)
        self.slider.valueChanged.connect(self._show_index)
        self.play_btn = QtWidgets.QPushButton("Play")
        self.play_btn.setCheckable(True)
        self.play_btn.toggled.connect(self._toggle)
        self.frame_lbl = QtWidgets.QLabel("")
        self.timer = QtCore.QTimer(self)
        self.timer.timeout.connect(self._tick)
        self._cache = {}
        row = QtWidgets.QHBoxLayout()
        row.addWidget(self.play_btn)
        row.addWidget(self.slider, 1)
        row.addWidget(self.frame_lbl)
        lay = QtWidgets.QVBoxLayout(self)
        lay.setContentsMargins(0, 0, 0, 0)
        lay.addWidget(self.label, 1)
        lay.addLayout(row)

    def clear(self):
        self.frames, self._cache = {}, {}
        self.slider.setRange(0, 0)
        self.label.setText("Rendering...")
        self.label.setPixmap(QtGui.QPixmap())

    def add(self, frame, path):
        self.frames[frame] = path
        self._cache.pop(frame, None)
        keys = sorted(self.frames)
        self.slider.setRange(0, len(keys) - 1)
        self.slider.setValue(keys.index(frame))
        self._show_index(keys.index(frame))

    def load_folder(self, folder):
        self.clear()
        if not os.path.isdir(folder):
            self.label.setText("No frames in " + folder)
            return
        for name in sorted(os.listdir(folder)):
            if name.startswith("toon.") and name.endswith(".png"):
                self.frames[int(name.split(".")[1])] = os.path.join(folder, name)
        if self.frames:
            self.slider.setRange(0, len(self.frames) - 1)
            self._show_index(0)

    def current_path(self):
        keys = sorted(self.frames)
        return self.frames[keys[self.slider.value()]] if keys else None

    def _pixmap(self, frame):
        if frame not in self._cache:
            self._cache[frame] = QtGui.QPixmap(self.frames[frame])
        return self._cache[frame]

    def _show_index(self, i):
        keys = sorted(self.frames)
        if not keys:
            return
        f = keys[max(0, min(i, len(keys) - 1))]
        pm = self._pixmap(f)
        self.label.setPixmap(pm.scaled(self.label.size(), QtCore.Qt.KeepAspectRatio, QtCore.Qt.SmoothTransformation))
        self.frame_lbl.setText("frame %d" % f)

    def resizeEvent(self, ev):
        super().resizeEvent(ev)
        self._show_index(self.slider.value())

    def _toggle(self, on):
        self.play_btn.setText("Stop" if on else "Play")
        if on and len(self.frames) > 1:
            self.timer.start(int(1000 / max(1, self.fps)))
        else:
            self.timer.stop()
            self.play_btn.setChecked(False)

    def _tick(self):
        n = len(self.frames)
        if n:
            self.slider.setValue((self.slider.value() + 1) % n)


class ToonBridgePanel(MayaQWidgetDockableMixin, QtWidgets.QWidget):
    def __init__(self, parent=None):
        super().__init__(parent)
        self.setObjectName(WINDOW)
        self.setWindowTitle("Toon Bridge (Maya -> Blender EEVEE)")
        self.job = None
        self.looks = looks_mod.load_looks()
        self.results = []

        root = QtWidgets.QVBoxLayout(self)
        split = QtWidgets.QSplitter(QtCore.Qt.Vertical)
        root.addWidget(split)
        top = QtWidgets.QWidget()
        tl = QtWidgets.QVBoxLayout(top)
        tl.setContentsMargins(0, 0, 0, 0)
        tl.addWidget(self._build_looks())
        tl.addWidget(self._build_shot())
        tl.addWidget(self._build_preflight())
        tl.addWidget(self._build_render())
        scroll = QtWidgets.QScrollArea()
        scroll.setWidgetResizable(True)
        scroll.setWidget(top)
        split.addWidget(scroll)
        split.addWidget(self._build_result())
        split.setSizes([520, 360])
        self.refresh_cameras()
        self.use_playback_range()
        self.status("Ready. Blender: %s" % (launcher.find_blender() or "NOT FOUND - set it in Settings"))

    # ------------------------------------------------------------- sections
    def _build_looks(self):
        box = QtWidgets.QGroupBox("1  Looks")
        lay = QtWidgets.QVBoxLayout(box)
        self.look_list = QtWidgets.QListWidget()
        self.look_list.setIconSize(QtCore.QSize(28, 28))
        self.look_list.setMaximumHeight(190)
        for name, look in self.looks.items():
            it = QtWidgets.QListWidgetItem(look_icon(look), "%s   (%s)" % (look.get("label", name), name))
            it.setData(QtCore.Qt.UserRole, name)
            self.look_list.addItem(it)
        self.look_list.setCurrentRow(0)
        self.look_list.itemDoubleClicked.connect(lambda *_: self.assign_look())
        lay.addWidget(self.look_list)
        row = QtWidgets.QHBoxLayout()
        for text, fn in [("Assign to Selected", self.assign_look), ("Select Objects", self.select_look),
                         ("Clear Look", self.clear_look), ("Show Tags", self.show_tags)]:
            b = QtWidgets.QPushButton(text)
            b.clicked.connect(fn)
            row.addWidget(b)
        lay.addLayout(row)
        self.preview_chk = QtWidgets.QCheckBox("Viewport toon preview (rampShader stand-ins, restores originals when off)")
        self.preview_chk.toggled.connect(self.toggle_preview)
        lay.addWidget(self.preview_chk)
        return box

    def _build_shot(self):
        box = QtWidgets.QGroupBox("2  Shot")
        form = QtWidgets.QFormLayout(box)
        cam_row = QtWidgets.QHBoxLayout()
        self.cam_combo = QtWidgets.QComboBox()
        rb = QtWidgets.QPushButton("Refresh")
        rb.clicked.connect(self.refresh_cameras)
        cam_row.addWidget(self.cam_combo, 1)
        cam_row.addWidget(rb)
        form.addRow("Camera", cam_row)
        fr = QtWidgets.QHBoxLayout()
        self.start_spin = QtWidgets.QSpinBox()
        self.end_spin = QtWidgets.QSpinBox()
        for s in (self.start_spin, self.end_spin):
            s.setRange(-100000, 100000)
        pb = QtWidgets.QPushButton("Playback Range")
        pb.clicked.connect(self.use_playback_range)
        fr.addWidget(self.start_spin)
        fr.addWidget(QtWidgets.QLabel("to"))
        fr.addWidget(self.end_spin)
        fr.addWidget(pb)
        form.addRow("Frames", fr)
        opts = QtWidgets.QHBoxLayout()
        self.outline_chk = QtWidgets.QCheckBox("Outlines")
        self.outline_chk.setChecked(True)
        self.transp_chk = QtWidgets.QCheckBox("Transparent background")
        self.quality_combo = QtWidgets.QComboBox()
        self.quality_combo.addItems(["Final (100%, 16 samples)", "Preview (50%, 4 samples)"])
        opts.addWidget(self.outline_chk)
        opts.addWidget(self.transp_chk)
        opts.addWidget(self.quality_combo)
        form.addRow("Options", opts)
        self.line_combo = QtWidgets.QComboBox()
        for label, mode in [("2D ink lines (Freestyle, constant width)", "ink"),
                            ("3D hull outlines (per-look width)", "hull"), ("Both", "both")]:
            self.line_combo.addItem(label, mode)
        form.addRow("Line style", self.line_combo)
        self.sel_only_chk = QtWidgets.QCheckBox("Only selected objects (leave out rig controls, helpers)")
        form.addRow("Send", self.sel_only_chk)
        pop = QtWidgets.QHBoxLayout()
        self.misreg_spin = QtWidgets.QSpinBox()
        self.misreg_spin.setRange(0, 12)
        self.misreg_spin.setValue(3)
        self.misreg_spin.setSuffix(" px")
        self.twos_chk = QtWidgets.QCheckBox("Animate on twos")
        self.twos_chk.setChecked(True)
        pop.addWidget(QtWidgets.QLabel("Misregistration"))
        pop.addWidget(self.misreg_spin)
        pop.addWidget(self.twos_chk)
        pop.addStretch(1)
        form.addRow("Print effects", pop)
        bg_row = QtWidgets.QHBoxLayout()
        self.bg_btn = QtWidgets.QPushButton()
        self.bg_btn.setFixedWidth(60)
        self.bg_btn.clicked.connect(self.pick_background)
        bg_row.addWidget(self.bg_btn)
        bg_row.addWidget(QtWidgets.QLabel("sky / backdrop colour, saved in the scene"))
        bg_row.addStretch(1)
        form.addRow("Background", bg_row)
        self._show_background()
        self.outline_spin = QtWidgets.QDoubleSpinBox()
        self.outline_spin.setRange(0.1, 10.0)
        self.outline_spin.setSingleStep(0.25)
        self.outline_spin.setValue(1.0)
        self.outline_spin.setSuffix(" x")
        form.addRow("Outline width", self.outline_spin)
        out_row = QtWidgets.QHBoxLayout()
        self.out_edit = QtWidgets.QLineEdit(exporter.default_shot_dir())
        ob = QtWidgets.QPushButton("...")
        ob.setFixedWidth(30)
        ob.clicked.connect(self.browse_out)
        out_row.addWidget(self.out_edit, 1)
        out_row.addWidget(ob)
        form.addRow("Shot folder", out_row)
        bl_row = QtWidgets.QHBoxLayout()
        self.blender_edit = QtWidgets.QLineEdit(launcher.find_blender() or "")
        self.blender_edit.editingFinished.connect(lambda: launcher.save_path(self.blender_edit.text()))
        bb = QtWidgets.QPushButton("...")
        bb.setFixedWidth(30)
        bb.clicked.connect(self.browse_blender)
        bl_row.addWidget(self.blender_edit, 1)
        bl_row.addWidget(bb)
        form.addRow("Blender", bl_row)
        return box

    def _build_preflight(self):
        box = QtWidgets.QGroupBox("3  Pre-flight")
        lay = QtWidgets.QVBoxLayout(box)
        self.pf_tree = QtWidgets.QTreeWidget()
        self.pf_tree.setHeaderLabels(["Check", "Result"])
        self.pf_tree.setRootIsDecorated(False)
        self.pf_tree.setMaximumHeight(170)
        self.pf_tree.header().setStretchLastSection(True)
        self.pf_tree.setColumnWidth(0, 170)
        self.pf_tree.itemDoubleClicked.connect(self._select_issue)
        lay.addWidget(self.pf_tree)
        row = QtWidgets.QHBoxLayout()
        b1 = QtWidgets.QPushButton("Check Scene")
        b1.clicked.connect(self.run_preflight)
        b2 = QtWidgets.QPushButton("Select Problem Nodes")
        b2.clicked.connect(lambda: self._select_issue(self.pf_tree.currentItem()))
        self.fix_btn = QtWidgets.QPushButton("Fix")
        self.fix_btn.clicked.connect(self.fix_issue)
        self.fix_btn.setEnabled(False)
        self.pf_tree.currentItemChanged.connect(self._issue_changed)
        for b in (b1, b2, self.fix_btn):
            row.addWidget(b)
        lay.addLayout(row)
        return box

    def _build_render(self):
        box = QtWidgets.QGroupBox("4  Render in Blender EEVEE")
        lay = QtWidgets.QVBoxLayout(box)
        row = QtWidgets.QHBoxLayout()
        self.frame_btn = QtWidgets.QPushButton("Render Current Frame")
        self.frame_btn.clicked.connect(lambda: self.render(current_only=True))
        self.shot_btn = QtWidgets.QPushButton("Render Shot")
        self.shot_btn.clicked.connect(lambda: self.render(current_only=False))
        self.stop_btn = QtWidgets.QPushButton("Stop")
        self.stop_btn.setEnabled(False)
        self.stop_btn.clicked.connect(self.stop)
        for b in (self.frame_btn, self.shot_btn):
            b.setMinimumHeight(34)
            b.setStyleSheet("font-weight:bold;")
        row.addWidget(self.frame_btn)
        row.addWidget(self.shot_btn)
        row.addWidget(self.stop_btn)
        lay.addLayout(row)
        self.progress = QtWidgets.QProgressBar()
        self.progress.setRange(0, 1)
        self.progress.setValue(0)
        lay.addWidget(self.progress)
        self.status_lbl = QtWidgets.QLabel("")
        self.status_lbl.setWordWrap(True)
        lay.addWidget(self.status_lbl)
        return box

    def _build_result(self):
        box = QtWidgets.QGroupBox("5  Result")
        lay = QtWidgets.QVBoxLayout(box)
        self.viewer = FrameViewer()
        lay.addWidget(self.viewer, 1)
        row = QtWidgets.QHBoxLayout()
        for text, fn in [("Load Shot Frames", self.load_frames), ("Show in Render View", self.to_render_view),
                         ("Open Folder", self.open_folder), ("Open .blend in Blender", self.open_blend),
                         ("Log", self.toggle_log)]:
            b = QtWidgets.QPushButton(text)
            b.clicked.connect(fn)
            row.addWidget(b)
        lay.addLayout(row)
        self.log = QtWidgets.QPlainTextEdit()
        self.log.setReadOnly(True)
        self.log.setMaximumBlockCount(2000)
        self.log.setVisible(False)
        self.log.setMinimumHeight(120)
        lay.addWidget(self.log)
        return box

    # ------------------------------------------------------------- looks
    def current_look(self):
        it = self.look_list.currentItem()
        return it.data(QtCore.Qt.UserRole) if it else looks_mod.DEFAULT_LOOK

    def assign_look(self):
        look = self.current_look()
        done = looks_mod.assign(look)
        if self.preview_chk.isChecked():
            looks_mod.preview_on(done)
        self.status("Assigned %s to %d mesh(es)." % (look, len(done)) if done else "Select some meshes first.")

    def select_look(self):
        objs = looks_mod.objects_with_look(self.current_look())
        cmds.select(objs, replace=True) if objs else cmds.select(clear=True)
        self.status("%d object(s) use %s." % (len(objs), self.current_look()))

    def clear_look(self):
        sel = cmds.ls(selection=True, long=True)
        looks_mod.preview_off(looks_mod.mesh_transforms(sel) if sel else None)
        done = looks_mod.clear(sel)
        self.status("Cleared look on %d mesh(es)." % len(done))

    def show_tags(self):
        rows = [(exporter.short_name(t), looks_mod.get_look(t) or "-") for t in looks_mod.mesh_transforms()]
        self.log.setVisible(True)
        self.log.appendPlainText("\n".join("%-24s %s" % r for r in rows))

    def toggle_preview(self, on):
        n = looks_mod.preview_on() if on else looks_mod.preview_off()
        self.status("Toon preview %s on %d mesh(es)." % ("on" if on else "off", len(n)))

    # ------------------------------------------------------------- shot
    def refresh_cameras(self):
        if hasattr(self, "bg_btn"):
            self._show_background()
        cur = self.cam_combo.currentData()
        self.cam_combo.clear()
        for c in exporter.render_cameras():
            self.cam_combo.addItem(exporter.short_name(c), c)
        if cur:
            i = self.cam_combo.findData(cur)
            if i >= 0:
                self.cam_combo.setCurrentIndex(i)

    def use_playback_range(self):
        self.start_spin.setValue(int(cmds.playbackOptions(query=True, minTime=True)))
        self.end_spin.setValue(int(cmds.playbackOptions(query=True, maxTime=True)))

    def _show_background(self):
        rgb = exporter.scene_background() or exporter.DEFAULT_SETTINGS["background"]
        c = QtGui.QColor.fromRgbF(*rgb)
        self.bg_btn.setStyleSheet("background:%s; border:1px solid #555; border-radius:3px;" % c.name())

    def pick_background(self):
        rgb = exporter.scene_background() or exporter.DEFAULT_SETTINGS["background"]
        c = QtWidgets.QColorDialog.getColor(QtGui.QColor.fromRgbF(*rgb), self, "Background colour")
        if c.isValid():
            exporter.set_scene_background([c.redF(), c.greenF(), c.blueF()])
            self._show_background()

    def browse_out(self):
        d = QtWidgets.QFileDialog.getExistingDirectory(self, "Shot folder", self.out_edit.text())
        if d:
            self.out_edit.setText(d)

    def browse_blender(self):
        p, _ = QtWidgets.QFileDialog.getOpenFileName(self, "Blender executable", "/Applications")
        if p:
            if p.endswith(".app"):
                p = os.path.join(p, "Contents", "MacOS", "Blender")
            self.blender_edit.setText(p)
            launcher.save_path(p)

    def settings(self):
        return {
            "outlines": self.outline_chk.isChecked(),
            "transparent": self.transp_chk.isChecked(),
            "outline_scale": self.outline_spin.value(),
            "line_mode": self.line_combo.currentData(),
            "misregister_px": self.misreg_spin.value(),
            "on_twos": self.twos_chk.isChecked(),
        }

    # ------------------------------------------------------------- pre-flight
    def run_preflight(self):
        objects = cmds.ls(selection=True, long=True) if self.sel_only_chk.isChecked() else None
        self.results = preflight.run_all(camera=self.cam_combo.currentData(), objects=objects or None)
        self.pf_tree.clear()
        for r in self.results:
            it = QtWidgets.QTreeWidgetItem([r.title, r.summary + ("   [fix: %s]" % r.fix_label if r.fix else "")])
            it.setForeground(0, QtGui.QBrush(QtGui.QColor(STATUS_COLORS[r.status])))
            it.setText(0, {"ok": "✔ ", "warn": "⚠ ", "error": "✖ "}[r.status] + r.title)
            it.setData(0, QtCore.Qt.UserRole, self.results.index(r))
            it.setToolTip(1, r.summary)
            self.pf_tree.addTopLevelItem(it)
        errors = preflight.blocking(self.results)
        self.status("Pre-flight: %d error(s), %d warning(s)." % (
            len(errors), len([r for r in self.results if r.status == preflight.WARN])))
        return not errors

    def _result_for(self, item):
        if item is None:
            return None
        return self.results[item.data(0, QtCore.Qt.UserRole)]

    def _issue_changed(self, item, _prev=None):
        r = self._result_for(item)
        self.fix_btn.setEnabled(bool(r and r.fix))
        self.fix_btn.setText("Fix: " + r.fix_label if r and r.fix else "Fix")

    def _select_issue(self, item, _col=None):
        r = self._result_for(item)
        if r and r.nodes:
            cmds.select([n for n in r.nodes if cmds.objExists(n)], replace=True)

    def fix_issue(self):
        r = self._result_for(self.pf_tree.currentItem())
        if r and r.fix:
            cmds.undoInfo(openChunk=True, chunkName="toonBridgeFix")
            try:
                r.fix()
            finally:
                cmds.undoInfo(closeChunk=True)
            self.run_preflight()

    # ------------------------------------------------------------- render
    def render(self, current_only):
        if self.job and self.job.running():
            return
        if self.blender_edit.text():
            launcher.save_path(self.blender_edit.text())
        if not self.run_preflight():
            self.status("Fix the red pre-flight items first.")
            return
        cam = self.cam_combo.currentData()
        shot_dir = self.out_edit.text()
        if current_only:
            f = int(cmds.currentTime(query=True))
            start = end = f
            shot_dir = os.path.join(shot_dir, "current_frame")
        else:
            start, end = self.start_spin.value(), self.end_spin.value()
        preview = self.quality_combo.currentIndex() == 1
        # No QApplication.processEvents() here: pumping Qt events while Maya is
        # mid-command crashed Maya intermittently (bisected in tests/ui_smoke.py).
        self.status("Exporting frames %d-%d..." % (start, end))
        gui = not cmds.about(batch=True)     # waitCursor is GUI-only; it can crash headless Maya
        try:
            if gui:
                cmds.waitCursor(state=True)
            objects = cmds.ls(selection=True, long=True) if self.sel_only_chk.isChecked() else None
            if self.sel_only_chk.isChecked() and not objects:
                self.status("'Only selected objects' is on, but nothing is selected.")
                return
            shot = exporter.export_shot(cam, start, end, shot_dir, self.settings(), objects=objects)
        except Exception as exc:
            self.status("Export failed: %s" % exc)
            return
        finally:
            if gui:
                cmds.waitCursor(state=False)
        self.last_shot_dir = shot_dir
        cmd = launcher.build_command(shot, preview=preview, blender=self.blender_edit.text() or None)
        self.job = launcher.BlenderJob(cmd, self)
        self.job.message.connect(self.log.appendPlainText)
        self.job.progress.connect(self._progress)
        self.job.frame_done.connect(self.viewer.add)
        self.job.finished.connect(self._finished)
        self.viewer.clear()
        self.viewer.fps = int(round(exporter._fps()))
        self.progress.setRange(0, 0)       # busy until Blender reports the total
        self._busy(True)
        self.status("Blender is rendering %s..." % ("frame %d" % start if current_only else "frames %d-%d" % (start, end)))
        self.job.start()

    def stop(self):
        if self.job:
            self.job.stop()

    def _progress(self, done, total):
        self.progress.setRange(0, max(1, total))
        self.progress.setValue(done)

    def _finished(self, ok, summary):
        self._busy(False)
        self.progress.setRange(0, 1)
        self.progress.setValue(1 if ok else 0)
        self.status(("Done: " if ok else "") + summary)
        if not ok:
            self.log.setVisible(True)
        elif len(self.viewer.frames) == 1:
            self.to_render_view()

    def _busy(self, on):
        for b in (self.frame_btn, self.shot_btn):
            b.setEnabled(not on)
        self.stop_btn.setEnabled(on)

    # ------------------------------------------------------------- result
    def _shot_dir(self):
        return getattr(self, "last_shot_dir", None) or self.out_edit.text()

    def load_frames(self):
        self.viewer.load_folder(os.path.join(self.out_edit.text(), "frames"))

    def to_render_view(self):
        path = self.viewer.current_path()
        if not path:
            return
        if not cmds.window("renderViewWindow", exists=True):
            cmds.RenderViewWindow()
        cmds.renderWindowEditor("renderView", edit=True, loadImage=path)

    def open_folder(self):
        d = os.path.join(self._shot_dir(), "frames")
        d = d if os.path.isdir(d) else self._shot_dir()
        opener = "open" if sys.platform == "darwin" else ("explorer" if sys.platform.startswith("win") else "xdg-open")
        subprocess.Popen([opener, d])

    def open_blend(self):
        blend = os.path.join(self._shot_dir(), "toon_shot.blend")
        blender = self.blender_edit.text() or launcher.find_blender()
        if os.path.isfile(blend) and blender:
            subprocess.Popen([blender, blend], env=launcher._clean_env())
        else:
            self.status("Render something first (no toon_shot.blend yet).")

    def toggle_log(self):
        self.log.setVisible(not self.log.isVisible())

    def status(self, text):
        self.status_lbl.setText(text)
        print("[Toon Bridge] " + text)


_panel = None


def show():
    """Open (or re-open) the panel as a dockable Maya window."""
    global _panel
    ctrl = WINDOW + "WorkspaceControl"
    if cmds.workspaceControl(ctrl, exists=True):
        cmds.deleteUI(ctrl)
    if _panel is not None:
        try:
            _panel.deleteLater()
        except RuntimeError:
            pass
    _panel = ToonBridgePanel()
    _panel.show(dockable=True, floating=True, width=560, height=900)
    return _panel
