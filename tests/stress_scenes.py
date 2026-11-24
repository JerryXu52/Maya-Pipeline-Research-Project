"""Stress test on real production-style scenes that ship with Maya 2026.

    mayapy tests/stress_scenes.py [name ...]

For each scene: open it, report what is in it (meshes, polys, skinning,
shader types, textures, lights), run pre-flight and its fixes, add a test
camera move (and a joint rotation on rigged characters so the skin deforms),
export 12 frames, render frames 1 and 12 in the pop-art look, and save a
contact sheet to docs/images/stress_<name>.png. Results go to stdout as
STRESS lines and to renders/stress/report.json.
"""
import json
import os
import sys
import time

REPO = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, REPO)

# Arnold scenes need mtoa; mayapy does not scan the shared module folder by default
os.environ["MAYA_MODULE_PATH"] = os.pathsep.join(filter(None, [
    os.environ.get("MAYA_MODULE_PATH"), "/Users/Shared/Autodesk/modules/maya/2026"]))
from PySide6 import QtCore, QtGui, QtWidgets  # noqa: E402
app = QtWidgets.QApplication(["stress"])      # before Maya (see make_video.py)
import maya.standalone  # noqa: E402
maya.standalone.initialize()
import maya.cmds as cmds  # noqa: E402

from toon_bridge import exporter, launcher, looks, preflight  # noqa: E402

EX = "/Applications/Autodesk/maya2026/Maya.app/Contents/Examples"
SCENES = {
    "eric": EX + "/Animation/Rigs/rp_eric_rigged_HIK_arnold.ma",
    "robot": EX + "/Animation/Rigs/M4Y4-B07.ma",
    "building": EX + "/Tutorials/Demo/TutorialBuildingDemo.ma",
    "sophia": EX + "/Modeling/People/rp_sophia_posed_100k_arnold.ma",
    "room": EX + "/Tutorials/LS/Interactive_LightingAndShading.ma",
}
OUT = os.path.join(REPO, "renders", "stress")
START, END = 1, 12


def say(*a):
    print("STRESS", *a, flush=True)


def inventory():
    meshes = looks.mesh_transforms()
    polys = sum(cmds.polyEvaluate(m, face=True) or 0 for m in meshes)
    shader_types = {}
    textured = 0
    for m in meshes:
        sg = looks.shading_engine(m)
        sh = (cmds.listConnections(sg + ".surfaceShader") or [None])[0] if sg else None
        if sh:
            shader_types[cmds.nodeType(sh)] = shader_types.get(cmds.nodeType(sh), 0) + 1
            if cmds.listConnections(sh, source=True, destination=False, type="file"):
                textured += 1
    return {
        "meshes": len(meshes),
        "polys": polys,
        "skinClusters": len(cmds.ls(type="skinCluster")),
        "joints": len(cmds.ls(type="joint")),
        "shaders": shader_types,
        "textured_meshes": textured,
        "lights": len(cmds.ls(lights=True)),
        "namespaces": [n for n in cmds.namespaceInfo(":", listOnlyNamespaces=True) if n not in ("UI", "shared")],
    }


def add_joint_motion():
    """Rotate a spine/arm joint over the clip so skinned meshes really deform."""
    joints = cmds.ls(type="joint")
    for pattern in ("LeftArm", "LeftForeArm", "Spine1", "Spine", "arm", "Arm"):
        hits = [j for j in joints if pattern in j and not cmds.getAttr(j + ".rotateZ", lock=True)
                and not cmds.listConnections(j + ".rotateZ", source=True, destination=False)]
        if hits:
            j = hits[0]
            try:
                v = cmds.getAttr(j + ".rotateZ")
                cmds.setKeyframe(j, attribute="rotateZ", time=START, value=v)
                cmds.setKeyframe(j, attribute="rotateZ", time=END, value=v + 35)
                return j
            except RuntimeError:
                continue
    return None


def add_camera(meshes):
    bb = cmds.exactWorldBoundingBox(meshes)
    cx, cy, cz = [(bb[i] + bb[i + 3]) / 2.0 for i in range(3)]
    size = max(bb[3] - bb[0], bb[4] - bb[1], bb[5] - bb[2])
    cam, shape = cmds.camera(name="stressCam", focalLength=35)
    cam = cmds.rename(cam, "stressCam")
    shape = cmds.listRelatives(cam, shapes=True)[0]
    cmds.setAttr(shape + ".farClipPlane", size * 50)
    cmds.setAttr(shape + ".nearClipPlane", size * 0.001)
    pivot = cmds.group(empty=True, name="stressCamPivot")
    cmds.move(cx, cy, cz, pivot)
    cmds.parent(cam, pivot, relative=True)
    height = bb[4] - bb[1]
    if height < size * 0.35:     # a wide, flat set: come in low and close, like a street-level shot
        cmds.move(0, height * 0.9, size * 0.55, cam, objectSpace=True, relative=True)
        cmds.setAttr(shape + ".focalLength", 24)
    else:                        # a character: full body in frame
        cmds.move(0, size * 0.15, size * 2.3, cam, objectSpace=True, relative=True)
    cmds.aimConstraint(pivot, cam, aimVector=(0, 0, -1), upVector=(0, 1, 0), worldUpType="scene")
    cmds.setKeyframe(pivot, attribute="rotateY", time=START, value=-25)
    cmds.setKeyframe(pivot, attribute="rotateY", time=END, value=-5)
    return cam


def sheet(paths, name, title):
    imgs = [QtGui.QImage(p) for p in paths if os.path.isfile(p)]
    if not imgs:
        return None
    w = 960
    h = int(imgs[0].height() * w / imgs[0].width())
    out = QtGui.QImage(w * len(imgs), h + 40, QtGui.QImage.Format_RGB32)
    out.fill(QtGui.QColor(24, 23, 28))
    p = QtGui.QPainter(out)
    p.setRenderHint(QtGui.QPainter.SmoothPixmapTransform)
    for i, im in enumerate(imgs):
        p.drawImage(i * w, 40, im.scaled(w, h, QtCore.Qt.KeepAspectRatio, QtCore.Qt.SmoothTransformation))
    p.setPen(QtGui.QColor(240, 240, 240))
    p.setFont(QtGui.QFont("Helvetica Neue", 16))
    p.drawText(12, 27, title)
    p.end()
    dst = os.path.join(REPO, "docs", "images", "stress_%s.png" % name)
    out.save(dst)
    return dst


def run(name, path):
    rec = {"scene": os.path.basename(path)}
    t0 = time.time()
    cmds.file(new=True, force=True)
    for plug in ("mtoa", "AbcExport"):
        try:
            cmds.loadPlugin(plug, quiet=True)
        except RuntimeError as exc:
            say(name, "could not load", plug, exc)
    try:
        # executeScriptNodes=False: tutorial scenes run UI scripts on open that need the GUI
        cmds.file(path, open=True, force=True, ignoreVersion=True, prompt=False, executeScriptNodes=False)
    except RuntimeError as exc:          # missing plug-ins etc.: Maya still opens what it can
        say(name, "open warning:", str(exc).strip()[:200])
    rec["open_s"] = round(time.time() - t0, 1)
    rec.update(inventory())
    say(name, "joint animated:", rec.get("animated_joint"))
    say(name, "inventory", json.dumps({k: rec[k] for k in rec if k != "scene"}))

    # what an artist would select: everything except rig control shapes
    def geometry():
        return [m for m in looks.mesh_transforms() if "_CTRL" not in m]
    meshes = geometry()
    rec["sent_meshes"] = len(meshes)
    cmds.playbackOptions(minTime=START, maxTime=END)
    cmds.setAttr("defaultResolution.width", 1280)
    cmds.setAttr("defaultResolution.height", 720)
    rec["animated_joint"] = add_joint_motion()
    cam = add_camera(meshes)
    looks.assign("pop_comic", meshes)

    before = preflight.run_all(camera=cam, objects=meshes)
    rec["preflight_before"] = ["%s: %s %s" % (r.title, r.status, r.summary) for r in before if r.status != "ok"]
    for _ in range(3):                      # fixes can uncover the next issue
        for r in preflight.run_all(camera=cam, objects=geometry()):
            if r.fix and r.status != "ok":
                r.fix()
    meshes = geometry()       # names may have changed
    after = preflight.run_all(camera=cam, objects=meshes)
    rec["preflight_after"] = ["%s: %s %s" % (r.title, r.status, r.summary) for r in after if r.status != "ok"]
    for line in rec["preflight_before"]:
        say(name, "preflight before:", line)
    for line in rec["preflight_after"]:
        say(name, "preflight after:", line)
    if preflight.blocking(after):
        rec["result"] = "BLOCKED by pre-flight"
        return rec

    shot_dir = os.path.join(OUT, name)
    t0 = time.time()
    shot = exporter.export_shot(cam, START, END, shot_dir, objects=meshes,
                                settings={"misregister_px": 2, "on_twos": True})
    rec["export_s"] = round(time.time() - t0, 1)
    rec["abc_mb"] = round(os.path.getsize(os.path.join(shot_dir, "scene.abc")) / 1e6, 1)

    t0 = time.time()
    code, lines = launcher.run_blocking(launcher.build_command(shot))
    rec["render_s"] = round(time.time() - t0, 1)
    rec["blender_exit"] = code
    rec["warnings"] = [l[len("TOONBRIDGE "):] for l in lines if l.startswith("TOONBRIDGE WARN")][:20]
    for w in rec["warnings"]:
        say(name, "blender:", w)
    if code:
        rec["result"] = "Blender failed"
        rec["log_tail"] = lines[-25:]
        return rec
    frames = [os.path.join(shot_dir, "frames", "toon.%04d.png" % f) for f in (START, (START + END) // 2, END)]
    rec["sheet"] = sheet(frames, name, "%s  (%d meshes, %d polys, %d skinClusters, %d textured)" % (
        rec["scene"], rec["meshes"], rec["polys"], rec["skinClusters"], rec["textured_meshes"]))
    rec["result"] = "OK"
    return rec


def main():
    names = sys.argv[1:] or list(SCENES)
    os.makedirs(OUT, exist_ok=True)
    report = {}
    for n in names:
        try:
            report[n] = run(n, SCENES[n])
        except Exception as exc:
            import traceback
            traceback.print_exc()
            report[n] = {"result": "EXCEPTION %s" % exc}
        say(n, "RESULT", report[n].get("result"), "export %ss render %ss" % (
            report[n].get("export_s"), report[n].get("render_s")))
    with open(os.path.join(OUT, "report.json"), "w") as f:
        json.dump(report, f, indent=1)


if __name__ == "__main__":
    main()
    sys.stdout.flush()
    os._exit(0)
