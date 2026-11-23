"""Camera/axis match check: render the same frame in Maya Software and Blender, then overlay.

    mayapy tests/camera_match.py [frame]

Both renders use the shot camera at 640x360. The Blender render goes through
the whole bridge (Alembic + shot.json + convert.py). Writes
docs/images/camera_match_<frame>.png: Maya render on the left, Blender toon in
the middle, and a difference overlay on the right (Maya edges in magenta over
the Blender frame). It also prints the share of pixels whose
foreground/background classification agrees.
"""
import os
import shutil
import sys

REPO = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, REPO)
sys.path.insert(0, os.path.join(REPO, "demo"))

import maya.standalone  # noqa: E402
maya.standalone.initialize()
import maya.cmds as cmds  # noqa: E402
from PySide6 import QtGui, QtCore  # noqa: E402

import make_demo_scene  # noqa: E402
from toon_bridge import exporter, launcher  # noqa: E402

W, H = 640, 360


def main():
    frame = int(sys.argv[1]) if len(sys.argv) > 1 else 36
    cam = make_demo_scene.build(save=False)
    cmds.setAttr("defaultResolution.width", W)
    cmds.setAttr("defaultResolution.height", H)
    out_dir = os.path.join(REPO, "renders", "camera_match")
    os.makedirs(out_dir, exist_ok=True)

    # Maya Software render with a black background and a flat white matte
    cmds.currentTime(frame)
    cmds.setAttr("defaultRenderGlobals.currentRenderer", "mayaSoftware", type="string")
    cmds.setAttr("defaultRenderGlobals.imageFormat", 32)     # png
    cmds.workspace(fileRule=["images", out_dir])
    maya_img = cmds.render(cam, x=W, y=H)
    print("maya render:", maya_img)

    # Blender, through the bridge, no outlines so silhouettes compare fairly
    shot = exporter.export_shot(cam, frame, frame, os.path.join(out_dir, "shot"),
                                settings={"outlines": False, "background": [0, 0, 0]})
    code, lines = launcher.run_blocking(launcher.build_command(shot, frame=frame))
    if code:
        print("\n".join(lines[-20:]))
        return False
    bl_img = os.path.join(out_dir, "shot", "frames", "toon.%04d.png" % frame)

    a = QtGui.QImage(maya_img).convertToFormat(QtGui.QImage.Format_RGB32)
    b = QtGui.QImage(bl_img).convertToFormat(QtGui.QImage.Format_RGB32)
    assert (a.width(), a.height()) == (b.width(), b.height()), (a.size(), b.size())

    def fg(img, x, y):
        c = QtGui.QColor(img.pixel(x, y))
        return c.red() + c.green() + c.blue() > 30      # anything not the black background

    agree = 0
    overlay = b.copy()
    for y in range(H):
        for x in range(W):
            fa, fb = fg(a, x, y), fg(b, x, y)
            agree += fa == fb
            if fa != fb:
                overlay.setPixel(x, y, QtGui.qRgb(255, 0, 255))
    score = agree / float(W * H)

    sheet = QtGui.QImage(W * 3, H, QtGui.QImage.Format_RGB32)
    p = QtGui.QPainter(sheet)
    p.drawImage(0, 0, a)
    p.drawImage(W, 0, b)
    p.drawImage(W * 2, 0, overlay)
    p.setPen(QtGui.QColor(255, 255, 255))
    p.setFont(QtGui.QFont("Helvetica", 14))
    p.drawText(10, 22, "Maya Software (frame %d)" % frame)
    p.drawText(W + 10, 22, "Blender EEVEE via bridge")
    p.drawText(W * 2 + 10, 22, "mismatch in magenta: %.2f%% agree" % (score * 100))
    p.end()
    out = os.path.join(REPO, "docs", "images", "camera_match_%d.png" % frame)
    sheet.save(out)
    print("CAMERA MATCH frame %d: %.2f%% of pixels agree -> %s" % (frame, score * 100, out))
    return score > 0.98


if __name__ == "__main__":
    ok = main()
    sys.stdout.flush()
    os._exit(0 if ok else 1)
