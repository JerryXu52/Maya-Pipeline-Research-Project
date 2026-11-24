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


def settle_then_preview(editor):
    """Wait for any sync/preview already running (the editor queues new requests), then preview."""
    for _ in range(10):       # a finished job may start the preview it had queued: drain them all
        busy = [j for j in (editor.sync_job, editor.preview_job) if j is not None and j.running()]
        if not busy:
            break
        for job in busy:
            wait(job)
        QtWidgets.QApplication.processEvents()
    editor._preview_again = False
    editor.preview_timer.stop()
    return wait(editor.render_preview())


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

# ---------------------------------------------------------------- full node graph
from toon_bridge import graph_model as gm  # noqa: E402
ed.select_look("pop_comic")
ed.view_group.button(1).setChecked(True)
wait(ed.sync_job)
g = ed.full.graph
check("full graph: Blender's real pop_comic tree (48 nodes)", len(g["nodes"]) == 48 and len(g["links"]) == 58)
check("full graph: every node drawn", len(ed.full.nodes) == 48)
check("template graph is not the look's own yet", not ed.look().get("graph"))

ed.full.scene().clearSelection()
ed.full.nodes["TB Saturation"].setSelected(True)
check("selecting a node fills the inspector", ed.node_inspector.name == "TB Saturation")
pos_before = list(ed.full.graph["nodes"][0]["location"])
ed.full.nodes[ed.full.graph["nodes"][0]["name"]].moveBy(30, 0)
ed.full.changed.emit(False)
check("only moving template nodes does not change the look", not ed.look().get("graph"))
if "--shot2" in sys.argv:
    dst = os.path.join(REPO, sys.argv[sys.argv.index("--shot2") + 1])
    ed.full.scene().clearSelection()
    ed.full.nodes["TB Halftone"].setSelected(True)
    settle_then_preview(ed)
    ed.layout().activate()
    ed.full.resetTransform()
    ed.full.scale(0.75, 0.75)
    ed.full.centerOn(ed.full.nodes["TB Halftone"])
    ed.grab().save(dst)
    print("SHOT2", dst, flush=True)

ed.full.snapshot()
gm.set_input(ed.full.graph, "TB Saturation", "Saturation", 2.2)
ed._full_changed(True)
res = settle_then_preview(ed)
check("value edit: look now owns its graph, preview renders", ed.look().get("graph") and res.get("ok"))
check("value survives Blender's rebuild", gm.socket(gm.node(ed.look()["graph"], "TB Saturation"), "inputs", "Saturation")["value"] == 2.2)

mix = ed.full.add_node("ShaderNodeMix")
settle_then_preview(ed)
m = gm.node(ed.look()["graph"], mix)
check("add node: Blender's Mix node comes back", m is not None and m["type"] == "ShaderNodeMix")
ed.full.snapshot()
gm.set_prop(ed.full.graph, mix, "data_type", "FLOAT")
ed._full_changed(True)
settle_then_preview(ed)
m = gm.node(ed.look()["graph"], mix)
check("setting change: Blender shows the Float sockets and hides Color ones",
      gm.socket(m, "inputs", "A_Float")["enabled"] and not gm.socket(m, "inputs", "A_Color")["enabled"])
ed.full.snapshot()
check("connect sockets", gm.connect(ed.full.graph, mix, "Result_Float", "TB Emission", "Strength"))
ed._full_changed(True)
res = settle_then_preview(ed)
check("link survives Blender's rebuild", [mix, "Result_Float", "TB Emission", "Strength"] in ed.look()["graph"]["links"]
      and res.get("ok"))
n_before = len(ed.full.graph["links"])
ed.full.undo()
check("undo removes the link", len(ed.full.graph["links"]) == n_before - 1)
ed.full.redo()
settle_then_preview(ed)

ed.save()
saved = json.load(open(lib))
check("save keeps the full graph", "graph" in saved["pop_comic"] and len(saved["pop_comic"]["graph"]["nodes"]) == 49)

from toon_bridge import exporter, launcher  # noqa: E402
looks_file = os.path.join(tmp, "looks_for_render.json")
json.dump({k: v for k, v in saved.items()}, open(looks_file, "w"))
cmds.currentTime(40)
shot = exporter.export_shot("shotCam", 40, 40, os.path.join(tmp, "graph_shot"), looks_file=looks_file)
code, lines = launcher.run_blocking(launcher.build_command(shot, preview=True))
warns = [l for l in lines if "WARN graph" in l]
check("a shot renders with the edited graph (no graph warnings)", code == 0 and not warns and
      os.path.isfile(os.path.join(tmp, "graph_shot", "frames", "toon.0040.png")))

ed.view_group.button(0).setChecked(True)

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
