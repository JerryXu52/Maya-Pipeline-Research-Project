"""Capture docs/images/panel.png: the real Toon Bridge panel after a render.

    mayapy docs/panel_screenshot.py

Builds the demo scene, assigns a look through the panel, runs pre-flight,
renders the current frame with Blender, then grabs the panel as an image
(off-screen: no window appears).
"""
import os
import sys

from PySide6 import QtCore, QtWidgets
app = QtWidgets.QApplication(["panel_screenshot"])   # before Maya
import maya.standalone  # noqa: E402
maya.standalone.initialize()
import maya.cmds as cmds  # noqa: E402

REPO = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path[:0] = [REPO, os.path.join(REPO, "demo")]
import make_demo_scene  # noqa: E402
from toon_bridge import ui  # noqa: E402

make_demo_scene.build()
panel = ui.ToonBridgePanel()
panel.resize(620, 1700)          # never shown: grab() renders it off-screen
panel.findChild(QtWidgets.QSplitter).setSizes([1150, 520])
panel.layout().activate()
panel.cam_combo.setCurrentIndex(panel.cam_combo.findText("shotCam"))
names = [panel.look_list.item(i).data(QtCore.Qt.UserRole) for i in range(panel.look_list.count())]
panel.look_list.setCurrentRow(names.index("pop_comic"))
cmds.select("bean_body")
panel.assign_look()
panel.out_edit.setText(os.path.join(REPO, "renders", "panel_shot"))
cmds.currentTime(36)
loop = QtCore.QEventLoop()
panel.render(current_only=True)
panel.job.finished.connect(lambda *a: loop.quit())
QtCore.QTimer.singleShot(120000, loop.quit)
loop.exec()
panel.run_preflight()
panel.layout().activate()
panel.findChild(QtWidgets.QSplitter).setSizes([1150, 520])
panel.viewer.label.resize(580, 330)
panel.viewer._show_index(0)
out = os.path.join(REPO, "docs", "images", "panel.png")
panel.grab().save(out)
print("PANEL", out, flush=True)
os._exit(0)
