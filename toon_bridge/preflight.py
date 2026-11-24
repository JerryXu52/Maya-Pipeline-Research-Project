"""Pre-flight: scene checks that run before anything is sent to Blender.

This is Idea 2 from the proposal, scoped to what the bridge needs. Each check
returns a Result with a status (ok / warn / error), the offending nodes so
the UI can select them, and an optional fix. A fix must be safe: it only
touches what the check reported and never edits referenced nodes.
"""
import maya.cmds as cmds

from . import exporter, launcher
from . import looks as looks_mod

OK, WARN, ERROR = "ok", "warn", "error"


class Result(object):
    def __init__(self, title, status, summary, nodes=None, fix=None, fix_label=None):
        self.title = title
        self.status = status
        self.summary = summary
        self.nodes = nodes or []
        self.fix = fix
        self.fix_label = fix_label

    def __repr__(self):
        return "<%s %s: %s>" % (self.status, self.title, self.summary)


def check_blender():
    path = launcher.find_blender()
    if path:
        return Result("Blender found", OK, path)
    return Result("Blender found", ERROR, "Set the Blender path in Settings.")


def check_camera(camera):
    if not camera or not cmds.objExists(camera):
        return Result("Render camera", ERROR, "No camera chosen.")
    if camera.split("|")[-1] == "persp":
        return Result("Render camera", WARN, "Rendering the persp camera; a shot camera is safer.", [camera])
    return Result("Render camera", OK, camera.split("|")[-1])


def check_unique_names(meshes):
    """Looks are re-applied in Blender by object name, so names must be unique."""
    seen = {}
    for t in meshes:
        seen.setdefault(exporter.short_name(t), []).append(t)
    dupes = [t for ts in seen.values() if len(ts) > 1 for t in ts]
    if not dupes:
        return Result("Unique object names", OK, "%d meshes" % len(meshes))

    def fix():
        groups = {}
        for t in dupes:
            groups.setdefault(exporter.short_name(t), []).append(t)
        for name, ts in groups.items():
            # rename deepest paths first so parent renames do not break child paths
            for i, t in enumerate(sorted(ts, key=lambda p: -p.count("|"))[1:], 1):
                if cmds.referenceQuery(t, isNodeReferenced=True):
                    continue
                cmds.rename(t, "%s_%d" % (name.split(":")[-1], i))
    return Result("Unique object names", ERROR,
                  "%d meshes share a name; Blender would not know which look goes where." % len(dupes),
                  dupes, fix, "Rename with suffix")


def check_looks(meshes):
    library = looks_mod.load_looks()
    untagged = [t for t in meshes if not looks_mod.get_look(t)]
    unknown = [t for t in meshes if looks_mod.get_look(t) and looks_mod.get_look(t) not in library]
    if unknown:
        return Result("Looks assigned", ERROR, "%d meshes use a look that is not in the library." % len(unknown),
                      unknown, lambda: looks_mod.assign(looks_mod.DEFAULT_LOOK, unknown, source="auto"), "Set to toon_auto")
    if untagged:
        return Result("Looks assigned", WARN, "%d meshes have no look; they will use toon_auto." % len(untagged),
                      untagged, lambda: looks_mod.assign(looks_mod.DEFAULT_LOOK, untagged, source="auto"), "Tag as toon_auto")
    return Result("Looks assigned", OK, "every mesh has a look")


def check_negative_scale(meshes):
    """Negative scale flips normals, which turns the inverted-hull outline inside out."""
    bad = []
    for t in meshes:
        m = cmds.xform(t, query=True, worldSpace=True, matrix=True)
        x, y, z = m[0:3], m[4:7], m[8:11]
        det = (x[0] * (y[1] * z[2] - y[2] * z[1]) - x[1] * (y[0] * z[2] - y[2] * z[0])
               + x[2] * (y[0] * z[1] - y[1] * z[0]))
        if det < 0:
            bad.append(t)
    if bad:
        return Result("No negative scale", WARN, "%d meshes are mirrored; outlines may render inside out." % len(bad), bad)
    return Result("No negative scale", OK, "")


def check_lights():
    kinds = {}
    for s in cmds.ls(lights=True, long=True) or []:
        kinds.setdefault(cmds.nodeType(s), []).append(cmds.listRelatives(s, parent=True, fullPath=True)[0])
    if not kinds.get("directionalLight"):
        def fix():
            l = cmds.directionalLight(name="toonKeyLightShape", intensity=1.0)
            t = cmds.listRelatives(l, parent=True)[0]
            cmds.rotate(-50, -40, 0, t)
        return Result("Key light", WARN, "No directional light: Blender will add a default sun.",
                      fix=fix, fix_label="Add directional light")
    other = [t for k, ts in kinds.items() if k not in exporter.LIGHT_TYPES for t in ts]
    approx = kinds.get("pointLight", []) + kinds.get("spotLight", []) + kinds.get("areaLight", [])
    if other:
        return Result("Key light", WARN, "%d lights are not converted (e.g. Arnold lights)." % len(other), other)
    if approx:
        return Result("Key light", WARN, "Point/spot/area intensity is approximate; directional is exact.", approx)
    return Result("Key light", OK, "%d directional" % len(kinds["directionalLight"]))


def check_textures(meshes):
    """Textured meshes send their colour map; a map we can't find falls back to grey."""
    used, missing = [], []
    for t in meshes:
        sg = looks_mod.shading_engine(t)
        shaders = cmds.listConnections(sg + ".surfaceShader") if sg else None
        if not shaders:
            continue
        has_tex = cmds.listHistory(shaders[0]) or []
        has_tex = [n for n in has_tex if cmds.nodeType(n) in ("file", "aiImage")]
        if not has_tex:
            continue
        (used if looks_mod.object_texture(t) else missing).append(t)
    if missing:
        return Result("Textures", WARN, "%d textured meshes: colour map not found (or UDIM); they use grey." % len(missing),
                      missing)
    if used:
        return Result("Textures", OK, "%d meshes send their colour map" % len(used))
    return Result("Textures", OK, "flat colours")


def run_all(camera=None, objects=None):
    meshes = looks_mod.mesh_transforms(objects)
    if not meshes:
        return [Result("Meshes to send", ERROR, "No visible meshes.")]
    return [
        check_blender(),
        check_camera(camera),
        check_unique_names(meshes),
        check_looks(meshes),
        check_negative_scale(meshes),
        check_lights(),
        check_textures(meshes),
    ]


def blocking(results):
    return [r for r in results if r.status == ERROR]
