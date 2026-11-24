"""Pre-render the presentation shot so the flipbook plays instantly in class.

    mayapy demo/prerender_presentation.py [--frames 1,40,96]

Builds demo/presentation.ma in memory, does the live-demo steps in code
(assign the hero's looks, run pre-flight fixes), and renders into the folder
the panel uses for that scene: demo/toon_bridge/presentation/frames/.
In class, press 'Load Shot Frames' to show them. The saved .ma is untouched.
"""
import os
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
REPO = os.path.dirname(HERE)
sys.path[:0] = [REPO, HERE]
from PySide6 import QtWidgets  # noqa: E402
app = QtWidgets.QApplication(["prerender"])
import maya.standalone  # noqa: E402
maya.standalone.initialize()
import maya.cmds as cmds  # noqa: E402

import make_presentation_scene as ps  # noqa: E402
from toon_bridge import exporter, launcher, preflight  # noqa: E402

cam = ps.build(save=False)
for r in preflight.run_all(camera=cam):
    print("BEFORE %-5s %s: %s" % (r.status, r.title, r.summary), flush=True)
ps.stage_for_render()
for r in preflight.run_all(camera=cam):
    print("AFTER  %-5s %s: %s" % (r.status, r.title, r.summary), flush=True)
shot_dir = os.path.join(HERE, "toon_bridge", "presentation")
shot = exporter.export_shot(cam, ps.START, ps.END, shot_dir,
                            settings={"misregister_px": 3, "on_twos": True})
frames = None
if "--frames" in sys.argv:
    frames = [int(f) for f in sys.argv[sys.argv.index("--frames") + 1].split(",")]
for f in frames or [None]:
    code, lines = launcher.run_blocking(launcher.build_command(shot, frame=f))
    print("blender exit", code, [l for l in lines if "WARN" in l or "ERROR" in l][:10], flush=True)
print("FRAMES", os.path.join(shot_dir, "frames"), flush=True)
os._exit(0)
