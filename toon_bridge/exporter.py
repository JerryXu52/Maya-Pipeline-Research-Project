"""Export a Maya shot for Blender: an Alembic cache plus shot.json.

Alembic carries the geometry and its animation (including skinned and
deforming meshes). Everything that has to be converted exactly - camera,
lights, look names, colours - goes into shot.json as raw Maya values, and
blender/render.py converts them with toon_bridge/convert.py. Keeping the
conversion in one small, tested file is what makes the lighting match.
"""
import datetime
import json
import os

import maya.cmds as cmds

from . import looks as looks_mod

LIGHT_TYPES = {
    "directionalLight": "directional",
    "pointLight": "point",
    "spotLight": "spot",
    "areaLight": "area",
    "ambientLight": "ambient",
}

DEFAULT_SETTINGS = {
    "outlines": True,
    "transparent": False,
    "samples": 16,
    "background": [0.92, 0.91, 0.87],
    "ambient": [0.04, 0.04, 0.05],
    "outline_scale": 1.0,
}


def short_name(node):
    return node.split("|")[-1].split(":")[-1]


def default_shot_dir():
    scene = cmds.file(query=True, sceneName=True)
    if scene:
        base = os.path.splitext(os.path.basename(scene))[0]
        root = os.path.join(os.path.dirname(scene), "toon_bridge")
    else:
        base = "untitled"
        root = os.path.join(os.path.expanduser("~"), "toon_bridge")
    return os.path.join(root, base)


def render_cameras():
    """Cameras worth rendering: non-startup cameras first, then persp."""
    cams = []
    for shape in cmds.ls(type="camera", long=True) or []:
        t = cmds.listRelatives(shape, parent=True, fullPath=True)[0]
        if not cmds.camera(shape, query=True, startupCamera=True):
            cams.append(t)
    persp = cmds.ls("|persp", long=True)
    return cams + persp


def _shape(transform, kind=None):
    shapes = cmds.listRelatives(transform, shapes=True, fullPath=True, type=kind) or []
    return shapes[0] if shapes else None


def _resolution():
    return [cmds.getAttr("defaultResolution.width"), cmds.getAttr("defaultResolution.height")]


def _fps():
    unit = cmds.currentUnit(query=True, time=True)
    table = {"game": 15, "film": 24, "pal": 25, "ntsc": 30, "show": 48, "palf": 50, "ntscf": 60}
    if unit in table:
        return table[unit]
    if unit.endswith("fps"):
        return float(unit[:-3])
    return 24


def camera_data(cam, frames):
    shape = _shape(cam, "camera")
    data = {
        "name": short_name(cam),
        "h_aperture": cmds.getAttr(shape + ".horizontalFilmAperture"),
        "v_aperture": cmds.getAttr(shape + ".verticalFilmAperture"),
        "film_fit": cmds.getAttr(shape + ".filmFit"),
        "near": cmds.getAttr(shape + ".nearClipPlane"),
        "far": cmds.getAttr(shape + ".farClipPlane"),
        "frames": {},
    }
    for f in frames:
        data["frames"][str(f)] = {
            "matrix": cmds.getAttr(cam + ".worldMatrix[0]", time=f),
            "focal": cmds.getAttr(shape + ".focalLength", time=f),
        }
    return data


def light_data(frames):
    out = []
    for shape in cmds.ls(lights=True, long=True) or []:
        kind = LIGHT_TYPES.get(cmds.nodeType(shape))
        t = cmds.listRelatives(shape, parent=True, fullPath=True)[0]
        if kind is None or not cmds.ls(t, visible=True):
            continue
        L = {
            "name": short_name(t),
            "type": kind,
            "color": list(cmds.getAttr(shape + ".color")[0]),
            "frames": {},
        }
        if kind in ("point", "spot", "area") and cmds.objExists(shape + ".decayRate"):
            L["decay"] = cmds.getAttr(shape + ".decayRate")
        if kind == "spot":
            L["cone_deg"] = cmds.getAttr(shape + ".coneAngle")
            L["penumbra_deg"] = cmds.getAttr(shape + ".penumbraAngle")
        for f in frames:
            L["frames"][str(f)] = {
                "matrix": cmds.getAttr(t + ".worldMatrix[0]", time=f),
                "intensity": cmds.getAttr(shape + ".intensity", time=f),
            }
        out.append(L)
    return out


def alembic_roots(transforms):
    """Drop transforms whose ancestor is already exported (it comes along)."""
    chosen = set(transforms)
    roots = []
    for t in transforms:
        parts = t.split("|")
        ancestors = {"|".join(parts[:i]) for i in range(2, len(parts))}
        if not ancestors & chosen:
            roots.append(t)
    return roots


def export_alembic(roots, start, end, path):
    if not cmds.pluginInfo("AbcExport", query=True, loaded=True):
        cmds.loadPlugin("AbcExport", quiet=True)
    job = "-frameRange %d %d -uvWrite -worldSpace -writeVisibility -stripNamespaces -dataFormat ogawa" % (start, end)
    for r in roots:
        job += " -root %s" % r
    job += ' -file "%s"' % path.replace("\\", "/")
    cmds.AbcExport(j=job)


def export_shot(camera, start, end, shot_dir=None, settings=None, objects=None):
    """Write <shot_dir>/scene.abc and <shot_dir>/shot.json. Returns the json path."""
    shot_dir = shot_dir or default_shot_dir()
    os.makedirs(shot_dir, exist_ok=True)
    start, end = int(start), int(end)
    frames = list(range(start, end + 1))
    transforms = looks_mod.mesh_transforms(objects)
    if not transforms:
        raise RuntimeError("Nothing to export: no visible meshes.")

    abc = os.path.join(shot_dir, "scene.abc")
    export_alembic(alembic_roots(transforms), start, end, abc)

    obj_info = []
    for t in transforms:
        obj_info.append({
            "name": short_name(t),
            "maya_path": t,
            "look": looks_mod.get_look(t) or looks_mod.DEFAULT_LOOK,
            "color": looks_mod.object_color(t),
        })

    st = dict(DEFAULT_SETTINGS)
    st.update(settings or {})
    shot = {
        "version": 1,
        "maya_scene": cmds.file(query=True, sceneName=True),
        "exported": datetime.datetime.now().isoformat(timespec="seconds"),
        "frame_start": start,
        "frame_end": end,
        "fps": _fps(),
        "resolution": _resolution(),
        "alembic": "scene.abc",
        "output": "frames/toon.####.png",
        "camera": camera_data(camera, frames),
        "lights": light_data(frames),
        "objects": obj_info,
        "settings": st,
    }
    path = os.path.join(shot_dir, "shot.json")
    with open(path, "w") as f:
        json.dump(shot, f, indent=1)
    return path
