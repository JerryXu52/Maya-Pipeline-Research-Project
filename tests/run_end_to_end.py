"""End-to-end check in headless Maya: build demo -> export -> Blender render -> verify PNGs.

    mayapy tests/run_end_to_end.py [--frames 1,36,72 | --all] [--preview]

Writes to renders/demo_shot/ (git-ignored). Exit code 0 only if every
requested frame exists, is the right size, and is not blank.
"""
import os
import sys
import time

REPO = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, REPO)
sys.path.insert(0, os.path.join(REPO, "demo"))

import maya.standalone  # noqa: E402
maya.standalone.initialize()
import maya.cmds as cmds  # noqa: E402

import make_demo_scene  # noqa: E402
from toon_bridge import exporter, launcher, preflight  # noqa: E402


def png_stats(path):
    """(width, height, distinct colours in a sample) using Qt, which mayapy has."""
    from PySide6 import QtGui
    img = QtGui.QImage(path)
    cols = set()
    for y in range(0, img.height(), max(1, img.height() // 40)):
        for x in range(0, img.width(), max(1, img.width() // 40)):
            cols.add(img.pixel(x, y))
    return img.width(), img.height(), len(cols)


def main():
    argv = sys.argv[1:]
    preview = "--preview" in argv
    cam = make_demo_scene.build(save=False)
    if "--all" in argv:
        frames = None
    else:
        spec = argv[argv.index("--frames") + 1] if "--frames" in argv else "1,36,72"
        frames = [int(f) for f in spec.split(",")]

    results = preflight.run_all(camera=cam)
    for r in results:
        print("PREFLIGHT %-5s %s: %s" % (r.status, r.title, r.summary))

    shot_dir = os.path.join(REPO, "renders", "demo_shot")
    t0 = time.time()
    shot = exporter.export_shot(cam, make_demo_scene.START, make_demo_scene.END, shot_dir)
    print("exported %s in %.1fs" % (shot, time.time() - t0))

    todo = frames or [None]
    ok = True
    for f in todo:
        cmd = launcher.build_command(shot, frame=f, preview=preview)
        t0 = time.time()
        code, lines = launcher.run_blocking(cmd, echo=True)
        print("blender exit %d in %.1fs" % (code, time.time() - t0))
        if code != 0:
            print("\n".join(lines[-30:]))
            ok = False
    check = frames or list(range(make_demo_scene.START, make_demo_scene.END + 1))
    w, h = cmds.getAttr("defaultResolution.width"), cmds.getAttr("defaultResolution.height")
    if preview:
        w, h = w // 2, h // 2
    for f in check:
        p = os.path.join(shot_dir, "frames", "toon.%04d.png" % f)
        if not os.path.isfile(p):
            print("MISSING", p)
            ok = False
            continue
        pw, ph, ncol = png_stats(p)
        good = (pw, ph) == (w, h) and ncol > 8
        ok = ok and good
        print("%s frame %d %dx%d colours=%d" % ("OK  " if good else "BAD ", f, pw, ph, ncol))
    print("END TO END:", "PASS" if ok else "FAIL")
    return ok


if __name__ == "__main__":
    ok = main()
    sys.stdout.flush()
    os._exit(0 if ok else 1)
