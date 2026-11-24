"""Drive the Look Editor in headless Maya: nodes, edits, previews, save.

    mayapy tests/look_editor_smoke.py [--shot docs/images/look_editor.png]
Works on a copy of looks.json, so the real library is not changed.
"""
import json
import os
import shutil
import sys
import tempfile

from PySide6 import QtCore, QtWidgets
app = QtWidgets.QApplication(["look_editor_smoke"])
import maya.standalone  # noqa: E402
maya.standalone.initialize()
import maya.cmds as cmds  # noqa: E402

REPO = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path[:0] = [REPO, os.path.join(REPO, "demo")]
from toon_bridge import look_editor, lookdefs  # noqa: E402

ok = True


def check(name, cond):
    global ok
    ok = ok and bool(cond)
    print("%-4s %s" % ("OK" if cond else "FAIL", name), flush=True)


def wait(job, seconds=120):
    if job is None:
        return {}
    loop = QtCore.QEventLoop()
    res = {}
    job.finished.connect(lambda good, s: (res.update(ok=good, s=s), QtCore.QTimer.singleShot(50, loop.quit)))
    QtCore.QTimer.singleShot(seconds * 1000, loop.quit)
    if job.running():
        loop.exec()
    QtWidgets.QApplication.processEvents()
    return res


tmp = tempfile.mkdtemp()
lib = os.path.join(tmp, "looks.json")
shutil.copy(os.path.join(REPO, "blender", "looks.json"), lib)
import make_presentation_scene as ps  # noqa: E402
ps.build()
ed = look_editor.LookEditor(looks_path=lib)
ed.resize(1260, 640)
ed.preview_timer.stop()

check("library lists every look", ed.look_list.count() == len(ed.looks))
check("graph has 12 nodes", len(ed.graph.items) == 12)
ed.select_look("cel_2d")
check("cel_2d: halftone node off", not ed.graph.items["halftone"].enabled)
ed.toggle_node("halftone")
check("switch a node on from its header", ed.look()["halftone"]["enabled"] and ed.graph.items["halftone"].enabled)
check("edits mark the library unsaved", ed.is_dirty() and ed.save_btn.isEnabled())

ed.select_node("bands")
ed.ramp.bands[0][1] = [0.2, 0.3, 0.9]
ed.ramp.changed.emit()
check("ramp edit reaches the look", ed.look()["bands"][0][1] == [0.2, 0.3, 0.9])
ed.ramp.mouseDoubleClickEvent  # (adding stops is a mouse action; covered by adding one directly)
ed.ramp.bands.append([0.8, [1.2, 1.2, 1.1]])
ed.ramp.changed.emit()
check("added a highlight band", len(ed.look()["bands"]) == 3)
ed.preview_timer.stop()

res = wait(ed.render_preview())
check("swatch preview renders", res.get("ok") and ed.last_preview and os.path.isfile(ed.last_preview))
swatch = ed.last_preview

ed.select_node("halftone")
ed._set(["halftone", "per_screen"], 35.0)
ed.preview_timer.stop()
res = wait(ed.render_preview())
check("a new edit gives a new preview", res.get("ok") and ed.last_preview != swatch)

from toon_bridge import preflight  # noqa: E402
ed.mode_group.button(1).setChecked(True)
ed.preview_timer.stop()
check("this-frame preview explains a scene problem", ed.render_preview() is None
      and "step 2" in ed.preview_status.text())
for r in preflight.run_all(camera="shotCam"):       # what Fix all in the panel does
    if r.fix and r.status != "ok":
        r.fix()
cmds.currentTime(40)
res = wait(ed.render_preview(), 180)
check("this-frame preview renders the shot with unsaved looks", res.get("ok") and ed.last_preview
      and ed.last_preview.endswith("toon.0040.png"))
ed.mode_group.button(0).setChecked(True)
ed.preview_timer.stop()

ed.save()
saved = json.load(open(lib))
check("save writes the edited look", lookdefs.normalize(saved["cel_2d"])["halftone"]["per_screen"] == 35.0)
check("saved file keeps every look", len([k for k in saved if not k.startswith("_")]) == len(ed.looks))
check("after save: nothing unsaved", not ed.is_dirty())

new = ed.duplicate()
check("duplicate makes a new look", new in ed.looks and ed.name == new)
ed.revert()
check("revert drops unsaved looks", new not in ed.looks)

if "--shot" in sys.argv:
    dst = os.path.join(REPO, sys.argv[sys.argv.index("--shot") + 1])
    ed.select_look("pop_comic")
    ed.select_node("halftone")
    ed.preview_timer.stop()
    wait(ed.render_preview())
    ed.layout().activate()
    ed.graph.resize(ed.graph.size())
    ed.graph.fit()
    ed.grab().save(dst)
    print("SHOT", dst, flush=True)

print("LOOK EDITOR:", "PASS" if ok else "FAIL", flush=True)
os._exit(0 if ok else 1)
