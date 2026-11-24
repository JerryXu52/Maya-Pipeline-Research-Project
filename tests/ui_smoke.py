"""Drive the real plug-in and panel in headless Maya, like a user would.

    mayapy tests/ui_smoke.py [--shot docs/images/panel.png]

Loads plug-ins/toonBridge.py, builds the presentation scene, then in the panel:
picks a style (looks assigned by name), runs the check, Fix all, renders this
frame and a 4-frame range through the background Blender job, puts the frames
on the camera as an image plane, and exports an MP4. With --shot it also saves
an image of the panel (the panel is never shown on screen).
"""
import faulthandler
import os
import sys

faulthandler.enable()
from PySide6 import QtCore, QtWidgets  # noqa: E402
app = QtWidgets.QApplication(["ui_smoke"])   # before Maya, or Maya makes a non-GUI Qt app
import maya.standalone  # noqa: E402
maya.standalone.initialize()
import maya.cmds as cmds  # noqa: E402

REPO = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path[:0] = [REPO, os.path.join(REPO, "demo")]
PLUGIN = os.path.join(REPO, "plug-ins", "toonBridge.py")

ok = True


def check(name, cond):
    global ok
    ok = ok and bool(cond)
    print("%-4s %s" % ("OK" if cond else "FAIL", name), flush=True)


def wait(job, seconds=180):
    loop = QtCore.QEventLoop()
    result = {}
    job.finished.connect(lambda good, summary: (result.update(ok=good, summary=summary), loop.quit()))
    QtCore.QTimer.singleShot(seconds * 1000, loop.quit)
    if job.running():
        loop.exec()
    return result


cmds.loadPlugin(PLUGIN)
check("plug-in loads", cmds.pluginInfo("toonBridge", query=True, loaded=True))
check("toonBridge command registered", "toonBridge" in (cmds.pluginInfo("toonBridge", query=True, command=True) or []))

import make_presentation_scene as ps  # noqa: E402
from toon_bridge import looks, styles, ui  # noqa: E402

cam = ps.build()
panel = ui.ToonBridgePanel()
panel.resize(480, 2000)
panel.cam_combo.setCurrentIndex(panel.cam_combo.findText("shotCam"))
out = os.path.join(REPO, "renders", "ui_smoke")
panel.out_edit.setText(out)

check("four style cards", len(panel.style_buttons) == 4)
check("table lists every mesh", panel.obj_table.topLevelItemCount() == len(looks.mesh_transforms()))
check("check finds the planted duplicate names", not panel.run_check())

panel.choose_style("pop")
check("style: head gets the skin look", looks.get_look("|bean_GRP|bean_rig|bean_root_jnt|bean_mid_jnt|bean_top_jnt|bean_head") == "pop_skin")
check("style: eyes get the eye look", looks.get_look("|bean_GRP|bean_rig|bean_root_jnt|bean_mid_jnt|bean_top_jnt|bean_eye_L") == "flat_ink")
check("style: roof top gets the ground look", looks.get_look("|roofA_top") == "pop_ground")
check("style: hand-picked looks kept", looks.get_look("|antenna") == "pop_comic")
check("style sets print effects", panel.misreg_spin.value() == 3 and panel.twos_chk.isChecked())
check("style saved in the scene", cmds.getAttr("defaultRenderGlobals.toonStyle") == "pop")

panel.choose_style("cel", apply=False)
n = panel.apply_style(overwrite=True)
check("apply style replaces all looks when asked",
      all(looks.get_look(t) == styles.look_for("cel", t) for t in looks.mesh_transforms())
      and looks.get_look("|antenna") == "cel_2d")
panel.choose_style("pop", apply=False)
panel.apply_style(overwrite=True)

row = panel.obj_table.topLevelItem(0)
combo = panel.obj_table.itemWidget(row, 1)
target = row.data(0, QtCore.Qt.UserRole)
combo.setCurrentIndex(combo.findData("manga_ink"))
check("changing a row's look tags the object", looks.get_look(target) == "manga_ink")

check("Fix all clears the errors", panel.fix_all())
panel.choose_style("flat")
check("switching style restyles style/auto looks", looks.get_look("|bean_GRP|bean_rig|bean_root_jnt|bean_mid_jnt|bean_top_jnt|bean_head") == "flat_ink")
check("...but keeps the look picked by hand", looks.get_look(target) == "manga_ink")
panel.choose_style("pop")
check("check is green after fixing", panel.run_check())

cmds.currentTime(40)
panel._time_changed()        # in the GUI a timeChanged scriptJob calls this; mayapy has no scriptJobs
check("render button names the frame", panel.render_btn.text() == "Render frame 40")
started = panel.render(current_only=True, ask=False)
res = wait(panel.job)
png = os.path.join(out, "current_frame", "frames", "toon.0040.png")
check("render this frame", started and res.get("ok") and os.path.isfile(png))
check("frame shown in the viewer", panel.viewer.current_path() == png)

panel.range_group.button(2).setChecked(True)
panel.start_spin.setValue(37)
panel.end_spin.setValue(40)
check("custom range label", panel.render_btn.text() == "Render frames 37–40")
panel.render(ask=False)
res = wait(panel.job)
check("render a range: 4 frames", res.get("ok") and len(panel.viewer.frames) == 4)

panel.viewer.show_frame(39)
check("viewer follows a timeline frame", panel.viewer.current_path().endswith("toon.0039.png"))
ip = panel.show_in_viewport(True)
check("image plane on the camera, frame-synced", ip and cmds.getAttr(ip + ".useFrameExtension") == 1)
panel.show_in_viewport(False)
check("image plane removed", not cmds.ls("toonBridgePreview*", type="imagePlane"))

mp4 = os.path.join(out, "test.mp4")
if os.path.isfile(mp4):
    os.remove(mp4)
res = wait(panel.export_mp4(mp4))
check("Export MP4", res.get("ok") and os.path.isfile(mp4) and os.path.getsize(mp4) > 10000)

panel.refresh()                       # what opening the scene again does
panel.out_edit.setText(out)           # (refresh resets Output to the scene's default folder)
check("last render reloads", panel.load_last_render() == 4)

if "--shot" in sys.argv:
    dst = os.path.join(REPO, sys.argv[sys.argv.index("--shot") + 1])
    panel.range_group.button(0).setChecked(True)
    cmds.currentTime(40)
    panel._update_range_label()
    panel.viewer.load_folder(os.path.join(out, "frames"))
    panel.viewer.show_frame(40)
    panel.run_check()
    # Never shown on screen, so the scroll area never sizes its content: grab the content
    # itself at the dock's width (460) and its natural height.
    content = panel.findChild(QtWidgets.QWidget, "tbContent")
    content.setFixedWidth(460)
    content.layout().activate()
    content.resize(460, content.layout().totalHeightForWidth(460) if content.layout().hasHeightForWidth()
                   else content.sizeHint().height())
    content.layout().activate()
    panel.viewer._show_index(panel.viewer.slider.value())
    content.grab().save(dst)
    print("PANEL", dst, flush=True)

cmds.unloadPlugin("toonBridge")
check("plug-in unloads", not cmds.pluginInfo("toonBridge", query=True, loaded=True))
print("UI SMOKE:", "PASS" if ok else "FAIL", flush=True)
os._exit(0 if ok else 1)
