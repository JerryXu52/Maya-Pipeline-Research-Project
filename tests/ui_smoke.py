"""Smoke test of the real panel in headless Maya: build it, press its buttons, render a frame.

    mayapy tests/ui_smoke.py

Uses the same ToonBridgePanel class as the GUI (not shown as a dock: there is
no Maya main window in mayapy). Renders frame 36 through the QProcess path and
waits for the finished signal.
"""
import faulthandler
import os
faulthandler.enable()
import sys

REPO = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path[:0] = [REPO, os.path.join(REPO, "demo")]
from PySide6 import QtCore, QtWidgets  # noqa: E402
app = QtWidgets.QApplication(["ui_smoke"])   # before Maya, or Maya makes a non-GUI app
import maya.standalone  # noqa: E402
maya.standalone.initialize()
import maya.cmds as cmds  # noqa: E402
import make_demo_scene  # noqa: E402
from toon_bridge import ui, looks  # noqa: E402

ok = True


def check(name, cond):
    global ok
    ok = ok and bool(cond)
    print("%-4s %s" % ("OK" if cond else "FAIL", name), flush=True)


make_demo_scene.build()
panel = ui.ToonBridgePanel()
check("panel lists all looks", panel.look_list.count() == len(looks.load_looks()))
check("shotCam in camera list", panel.cam_combo.findText("shotCam") >= 0)
panel.cam_combo.setCurrentIndex(panel.cam_combo.findText("shotCam"))
check("playback range 1-72", (panel.start_spin.value(), panel.end_spin.value()) == (1, 72))

# assign a look through the panel
cube = cmds.polyCube(name="uiTestCube")[0]
cmds.move(-80, 10, 40, cube)
cmds.select(cube)
row = [panel.look_list.item(i).data(QtCore.Qt.UserRole) for i in range(panel.look_list.count())].index("cel_metal")
panel.look_list.setCurrentRow(row)
panel.assign_look()
check("Assign to Selected tags the cube", looks.get_look("|uiTestCube") == "cel_metal")
panel.select_look()
check("Select Objects selects tagged meshes", "uiTestCube" in (cmds.ls(selection=True) or []))

panel.preview_chk.setChecked(True)
check("viewport preview swaps shaders", (looks.shading_engine("|uiTestCube") or "").startswith("toonPreview_"))
panel.preview_chk.setChecked(False)
check("preview off restores shader", not (looks.shading_engine("|uiTestCube") or "").startswith("toonPreview_"))

check("pre-flight passes", panel.run_preflight())
check("pre-flight rows shown", panel.pf_tree.topLevelItemCount() == 7)

out = os.path.join(REPO, "renders", "ui_smoke")
panel.out_edit.setText(out)
cmds.currentTime(36)
loop = QtCore.QEventLoop()
result = {}


def done(good, summary):
    result["ok"], result["summary"] = good, summary
    loop.quit()


panel.render(current_only=True)
panel.job.finished.connect(done)
QtCore.QTimer.singleShot(120000, loop.quit)
loop.exec()
print("render:", result, flush=True)
png = os.path.join(out, "current_frame", "frames", "toon.0036.png")
check("Render Current Frame finished ok", result.get("ok"))
check("frame written", os.path.isfile(png))
check("viewer shows the frame", panel.viewer.current_path() == png)
check("progress bar complete", panel.progress.value() == panel.progress.maximum())
print("UI SMOKE:", "PASS" if ok else "FAIL", flush=True)
os._exit(0 if ok else 1)
