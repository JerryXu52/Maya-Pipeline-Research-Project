"""Make the demo video: Maya render vs Toon Bridge, both line styles, look sheet, camera match.

    mayapy demo/make_video.py            -> docs/video/toon_bridge_demo.mp4

Everything in the video is rendered by the tool itself:
  * Maya Software render of the demo shot (the "3D" source)
  * the same shot through Toon Bridge with 3D hull outlines
  * the same shot through Toon Bridge with 2D ink lines (the default)
Needs ffmpeg on PATH.
"""
import os
import shutil
import subprocess
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
REPO = os.path.dirname(HERE)
sys.path.insert(0, REPO)
sys.path.insert(0, HERE)

# A GUI QApplication must exist before Maya starts: maya.standalone creates a
# non-GUI QCoreApplication otherwise, and fonts/widgets then crash.
from PySide6 import QtCore, QtGui, QtWidgets  # noqa: E402
app = QtWidgets.QApplication.instance() or QtWidgets.QApplication(["make_video"])
import maya.standalone  # noqa: E402
maya.standalone.initialize()
import maya.cmds as cmds  # noqa: E402

import make_demo_scene  # noqa: E402
from toon_bridge import exporter, launcher  # noqa: E402


OUT = os.path.join(REPO, "renders", "video")
W, H = 1920, 1080
FPS = 24
BG = QtGui.QColor(24, 23, 28)
INK = QtGui.QColor(245, 242, 236)
ACCENT = QtGui.QColor(255, 176, 92)


def ffmpeg():
    for p in (shutil.which("ffmpeg"), "/opt/homebrew/bin/ffmpeg", "/usr/local/bin/ffmpeg"):
        if p and os.path.isfile(p):
            return p
    raise RuntimeError("ffmpeg not found")


REUSE = "--reuse" in sys.argv     # skip renders whose frames already exist


def _have(paths):
    return REUSE and all(os.path.isfile(p) for p in paths.values())


def render_maya(cam, folder, w, h):
    """Maya Software render of every frame, depth-map shadows on, for the side-by-side."""
    os.makedirs(folder, exist_ok=True)
    cached = {f: os.path.join(folder, "maya.%04d.png" % f)
              for f in range(make_demo_scene.START, make_demo_scene.END + 1)}
    if _have(cached):
        return cached
    cmds.setAttr("defaultRenderGlobals.currentRenderer", "mayaSoftware", type="string")
    cmds.setAttr("defaultRenderGlobals.imageFormat", 32)
    cmds.setAttr("defaultResolution.width", w)
    cmds.setAttr("defaultResolution.height", h)
    cmds.setAttr("defaultRenderQuality.edgeAntiAliasing", 1)
    cmds.setAttr("keyLightShape.useDepthMapShadows", 1)
    cmds.setAttr("keyLightShape.dmapResolution", 2048)
    cmds.workspace(fileRule=["images", folder])
    paths = {}
    for f in range(make_demo_scene.START, make_demo_scene.END + 1):
        cmds.currentTime(f)
        img = cmds.render(cam, x=w, y=h)
        dst = os.path.join(folder, "maya.%04d.png" % f)
        shutil.move(img, dst)
        paths[f] = dst
        print("maya frame", f, flush=True)
    cmds.setAttr("defaultResolution.width", 1280)
    cmds.setAttr("defaultResolution.height", 720)
    return paths


def render_toon(cam, folder, line_mode):
    cached = {f: os.path.join(folder, "frames", "toon.%04d.png" % f)
              for f in range(make_demo_scene.START, make_demo_scene.END + 1)}
    if _have(cached):
        return cached
    shot = exporter.export_shot(cam, make_demo_scene.START, make_demo_scene.END, folder,
                                settings={"line_mode": line_mode})
    code, lines = launcher.run_blocking(launcher.build_command(shot), echo=False)
    if code:
        print("\n".join(lines[-30:]))
        raise RuntimeError("Blender failed")
    fdir = os.path.join(folder, "frames")
    return {f: os.path.join(fdir, "toon.%04d.png" % f) for f in range(make_demo_scene.START, make_demo_scene.END + 1)}


class Writer(object):
    def __init__(self, folder):
        self.folder = folder
        self.n = 0
        if os.path.isdir(folder):
            shutil.rmtree(folder)
        os.makedirs(folder)

    def add(self, img, repeat=1):
        for _ in range(repeat):
            self.n += 1
            img.save(os.path.join(self.folder, "v.%05d.png" % self.n))


def canvas():
    img = QtGui.QImage(W, H, QtGui.QImage.Format_RGB32)
    img.fill(BG)
    return img


def text(p, x, y, s, size, color=INK, bold=False, align=QtCore.Qt.AlignLeft, width=None):
    f = QtGui.QFont("Helvetica Neue", size)
    f.setBold(bold)
    p.setFont(f)
    p.setPen(color)
    if width:
        p.drawText(QtCore.QRectF(x, y, width, size * 2.2), align | QtCore.Qt.AlignVCenter, s)
    else:
        p.drawText(QtCore.QPointF(x, y), s)


def card(title, subtitle, lines=()):
    img = canvas()
    p = QtGui.QPainter(img)
    p.setRenderHint(QtGui.QPainter.Antialiasing)
    text(p, 0, 380, title, 64, bold=True, align=QtCore.Qt.AlignHCenter, width=W)
    text(p, 0, 500, subtitle, 30, ACCENT, align=QtCore.Qt.AlignHCenter, width=W)
    for i, l in enumerate(lines):
        text(p, 0, 600 + i * 52, l, 24, align=QtCore.Qt.AlignHCenter, width=W)
    p.end()
    return img


def panel(p, path, x, y, w, h, label):
    pm = QtGui.QImage(path).scaled(w, h, QtCore.Qt.KeepAspectRatio, QtCore.Qt.SmoothTransformation)
    p.drawImage(x + (w - pm.width()) // 2, y + (h - pm.height()) // 2, pm)
    text(p, x, y + h + 18, label, 24, align=QtCore.Qt.AlignHCenter, width=w)


def side_by_side(left, right, l_label, r_label, title, f):
    img = canvas()
    p = QtGui.QPainter(img)
    p.setRenderHint(QtGui.QPainter.SmoothPixmapTransform)
    text(p, 0, 90, title, 34, bold=True, align=QtCore.Qt.AlignHCenter, width=W)
    pw, ph = 920, 518
    panel(p, left, 27, 250, pw, ph, l_label)
    panel(p, right, W - 27 - pw, 250, pw, ph, r_label)
    text(p, 0, 960, "frame %d" % f, 20, QtGui.QColor(150, 150, 160), align=QtCore.Qt.AlignHCenter, width=W)
    p.end()
    return img


def full(path, caption, f):
    img = canvas()
    p = QtGui.QPainter(img)
    p.setRenderHint(QtGui.QPainter.SmoothPixmapTransform)
    panel(p, path, 0, 0, W, 980, caption)
    p.end()
    return img


def still(path, title, caption):
    img = canvas()
    p = QtGui.QPainter(img)
    p.setRenderHint(QtGui.QPainter.SmoothPixmapTransform)
    text(p, 0, 90, title, 34, bold=True, align=QtCore.Qt.AlignHCenter, width=W)
    pm = QtGui.QImage(path).scaled(1800, 760, QtCore.Qt.KeepAspectRatio, QtCore.Qt.SmoothTransformation)
    p.drawImage((W - pm.width()) // 2, 200 + (760 - pm.height()) // 2, pm)
    text(p, 60, 990, caption, 24, align=QtCore.Qt.AlignHCenter, width=W - 120)
    p.end()
    return img


def main():
    cam = make_demo_scene.build(save=False)
    frames = range(make_demo_scene.START, make_demo_scene.END + 1)
    maya = render_maya(cam, os.path.join(OUT, "maya"), 1280, 720)
    hull = render_toon(cam, os.path.join(OUT, "toon_hull"), "hull")
    ink = render_toon(cam, os.path.join(OUT, "toon_ink"), "ink")

    w = Writer(os.path.join(OUT, "comp"))
    w.add(card("Toon Bridge", "Maya shot  →  Blender EEVEE cel shading  →  back into Maya",
               ["Jianrui (Jerry) Xu · SVA MFA Computer Arts · Research Project",
                "Everything below was rendered by the tool from one Maya scene"]), FPS * 4)
    w.add(card("1. The Maya scene", "Modelled, skinned, animated and lit in Maya",
               ["Skinned character that bends and hops · moving camera with a zoom",
                "A directional sun that sweeps across the shot"]), FPS * 3)
    for f in frames:
        w.add(full(maya[f], "Maya Software render (the 3D source)", f))
    w.add(card("2. One click: Render Shot", "Alembic + shot.json → headless Blender → EEVEE",
               ["Looks re-applied by name · camera and lights converted (Y-up cm → Z-up m)",
                "72 frames at 1280×720 in about 40 seconds"]), FPS * 3)
    for _ in range(2):
        for f in frames:
            w.add(side_by_side(maya[f], ink[f], "Maya (3D)", "Toon Bridge → Blender EEVEE (2D cel)",
                               "Same shot, same camera, same sun", f))
    w.add(card("3. 3D look → 2D look", "Two line styles",
               ["3D hull outlines: a shell around each mesh, thinner with distance",
                "2D ink lines: Freestyle strokes with a constant width on screen, plus inner creases"]), FPS * 3)
    for f in frames:
        w.add(side_by_side(hull[f], ink[f], "3D hull outlines", "2D ink lines (default)",
                           "Line style", f))
    for f in frames:
        w.add(full(ink[f], "Final: 2D cel look · two-tone shadows · ink lines · hard cast shadows", f))
    w.add(still(os.path.join(REPO, "docs", "images", "look_sheet.png"), "4. The look library (Blender node trees)",
                "Shader to RGB → Constant Color Ramp bands · hard specular · rim · outlines. "
                "Editable in Blender's node editor."), FPS * 5)
    w.add(still(os.path.join(REPO, "docs", "images", "camera_match_36.png"), "5. Verified against Maya",
                "Same frame rendered by Maya and by the bridge: 99.13% of pixels agree; the rest are 1-px edges. "
                "Sun strength = π × Maya intensity, matched to 3 decimals."), FPS * 5)
    w.add(card("Toon Bridge", "github.com/JerryXu52/Maya-Pipeline-Research-Project",
               ["Next: live link for scrubbing · Line Art · textures · Arnold lights"]), FPS * 4)

    dst_dir = os.path.join(REPO, "docs", "video")
    os.makedirs(dst_dir, exist_ok=True)
    dst = os.path.join(dst_dir, "toon_bridge_demo.mp4")
    subprocess.check_call([ffmpeg(), "-loglevel", "error", "-y", "-framerate", str(FPS),
                           "-i", os.path.join(w.folder, "v.%05d.png"),
                           "-c:v", "libx264", "-pix_fmt", "yuv420p", "-crf", "23", "-preset", "slow",
                           "-movflags", "+faststart", dst])
    print("VIDEO", dst, "%d frames, %.1f s" % (w.n, w.n / float(FPS)))


if __name__ == "__main__":
    main()
    sys.stdout.flush()
    os._exit(0)
