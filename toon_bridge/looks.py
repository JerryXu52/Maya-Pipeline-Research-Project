"""Look tags on Maya objects, plus an optional toon preview in the viewport.

A look is stored on the mesh's transform as a string attribute `toonLook`.
Strings survive save/reload and referencing, and are easy to query.
"""
import json
import os

import maya.cmds as cmds

REPO = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
LOOKS_JSON = os.path.join(REPO, "blender", "looks.json")
LOOK_ATTR = "toonLook"
DEFAULT_LOOK = "toon_auto"
PREVIEW_ORIG_ATTR = "toonOrigSG"


def load_looks():
    with open(LOOKS_JSON) as f:
        return {k: v for k, v in json.load(f).items() if not k.startswith("_")}


def mesh_transforms(nodes=None):
    """Transforms that own a visible, non-intermediate mesh (long names)."""
    if nodes:
        shapes = cmds.listRelatives(nodes, allDescendents=True, type="mesh", fullPath=True) or []
        shapes += cmds.ls(nodes, type="mesh", long=True) or []
    else:
        shapes = cmds.ls(type="mesh", long=True) or []
    shapes = [s for s in shapes if not cmds.getAttr(s + ".intermediateObject")]
    visible = set(cmds.ls(shapes, visible=True, long=True) or [])
    out = []
    for s in shapes:
        if s not in visible:
            continue
        t = cmds.listRelatives(s, parent=True, fullPath=True)[0]
        if t not in out:
            out.append(t)
    return out


def get_look(transform):
    if cmds.attributeQuery(LOOK_ATTR, node=transform, exists=True):
        return cmds.getAttr(transform + "." + LOOK_ATTR) or None
    return None


def assign(look, nodes=None):
    """Tag the selected (or given) meshes with `look`. Returns the transforms."""
    nodes = nodes or cmds.ls(selection=True, long=True)
    targets = mesh_transforms(nodes)
    for t in targets:
        if not cmds.attributeQuery(LOOK_ATTR, node=t, exists=True):
            cmds.addAttr(t, longName=LOOK_ATTR, dataType="string")
        cmds.setAttr(t + "." + LOOK_ATTR, look, type="string")
    return targets


def clear(nodes=None):
    nodes = nodes or cmds.ls(selection=True, long=True)
    targets = mesh_transforms(nodes)
    for t in targets:
        if cmds.attributeQuery(LOOK_ATTR, node=t, exists=True):
            cmds.deleteAttr(t + "." + LOOK_ATTR)
    return targets


def objects_with_look(look):
    return [t for t in mesh_transforms() if get_look(t) == look]


# ---------------------------------------------------------------- colours
COLOR_ATTRS = {
    "standardSurface": ("baseColor", "base"),
    "aiStandardSurface": ("baseColor", "base"),
    "openPBRSurface": ("baseColor", "baseWeight"),
    "lambert": ("color", "diffuse"),
    "blinn": ("color", "diffuse"),
    "phong": ("color", "diffuse"),
    "phongE": ("color", "diffuse"),
    "rampShader": ("color[0].color_Color", None),
    "surfaceShader": ("outColor", None),
}


def shading_engine(transform):
    shapes = cmds.listRelatives(transform, shapes=True, noIntermediate=True, fullPath=True) or []
    for s in shapes:
        sgs = cmds.listConnections(s, type="shadingEngine") or []
        if sgs:
            return sgs[0]
    return None


def object_color(transform):
    """The object's Maya shader colour (RGB 0-1). Textures fall back to grey.

    If the toon viewport preview is on, the original shader is read instead.
    """
    sg = None
    if cmds.attributeQuery(PREVIEW_ORIG_ATTR, node=transform, exists=True):
        sg = cmds.getAttr(transform + "." + PREVIEW_ORIG_ATTR) or None
    sg = sg or shading_engine(transform)
    if not sg:
        return [0.8, 0.8, 0.8]
    shaders = cmds.listConnections(sg + ".surfaceShader") or []
    if not shaders:
        return [0.8, 0.8, 0.8]
    shader = shaders[0]
    kind = cmds.nodeType(shader)
    color_attr, weight_attr = COLOR_ATTRS.get(kind, ("color", None))
    if not cmds.objExists(shader + "." + color_attr.split("[")[0]):
        return [0.8, 0.8, 0.8]
    if cmds.listConnections(shader + "." + color_attr, source=True, destination=False):
        return [0.8, 0.8, 0.8]    # textured: no single colour to send
    rgb = list(cmds.getAttr(shader + "." + color_attr)[0])
    if kind in ("lambert", "blinn", "phong", "phongE"):
        weight = 1.0    # Maya's diffuse weight mostly darkens; keep the picked colour
    elif weight_attr and cmds.objExists(shader + "." + weight_attr):
        weight = cmds.getAttr(shader + "." + weight_attr)
        weight = 1.0 if weight <= 0 else min(1.0, weight / 0.8)
    else:
        weight = 1.0
    return [max(0.0, min(1.0, c * weight)) for c in rgb]


# ---------------------------------------------------------------- viewport preview
def _preview_shader(look_name, look, rgb):
    """A Maya rampShader that roughly mimics the look in Viewport 2.0.

    rampShader with 'Brightness' input and 'None' interpolation gives hard
    bands from the scene lights, like Blender's Shader to RGB + Constant ramp.
    """
    key = "%s_%02x%02x%02x" % (look_name, *[int(round(c * 255)) for c in rgb])
    shader = "toonPreview_" + key
    sg = shader + "SG"
    if cmds.objExists(sg):
        return sg
    shader = cmds.shadingNode("rampShader", asShader=True, name=shader)
    sg = cmds.sets(renderable=True, noSurfaceShader=True, empty=True, name=sg)
    cmds.connectAttr(shader + ".outColor", sg + ".surfaceShader")
    cmds.setAttr(shader + ".colorInput", 2)        # brightness
    base = rgb if look.get("base_color", "maya") == "maya" else look["base_color"]
    bands = look.get("bands", [[0.0, [1, 1, 1]]])
    for i, (pos, mult) in enumerate(bands):
        c = [b * m for b, m in zip(base, mult)]
        cmds.setAttr("%s.color[%d].color_Position" % (shader, i), pos)
        cmds.setAttr("%s.color[%d].color_Color" % (shader, i), *c, type="double3")
        cmds.setAttr("%s.color[%d].color_Interp" % (shader, i), 0)   # none = hard step
    cmds.setAttr(shader + ".diffuse", 1.0)
    cmds.setAttr(shader + ".specularity", 0.0)
    return sg


def preview_on(nodes=None):
    """Swap tagged meshes to toon preview shaders; remember the originals."""
    looks = load_looks()
    done = []
    for t in nodes or mesh_transforms():
        look_name = get_look(t)
        if not look_name or look_name not in looks:
            continue
        rgb = object_color(t)
        if not cmds.attributeQuery(PREVIEW_ORIG_ATTR, node=t, exists=True):
            orig = shading_engine(t) or "initialShadingGroup"
            cmds.addAttr(t, longName=PREVIEW_ORIG_ATTR, dataType="string")
            cmds.setAttr(t + "." + PREVIEW_ORIG_ATTR, orig, type="string")
        cmds.sets(t, edit=True, forceElement=_preview_shader(look_name, looks[look_name], rgb))
        done.append(t)
    return done


def preview_off(nodes=None):
    """Put the original shaders back and delete unused preview shaders."""
    done = []
    for t in nodes or mesh_transforms():
        if not cmds.attributeQuery(PREVIEW_ORIG_ATTR, node=t, exists=True):
            continue
        orig = cmds.getAttr(t + "." + PREVIEW_ORIG_ATTR)
        if orig and cmds.objExists(orig):
            cmds.sets(t, edit=True, forceElement=orig)
        cmds.deleteAttr(t + "." + PREVIEW_ORIG_ATTR)
        done.append(t)
    for sg in cmds.ls("toonPreview_*SG", type="shadingEngine") or []:
        if not cmds.sets(sg, query=True):
            shaders = cmds.listConnections(sg + ".surfaceShader") or []
            cmds.delete([sg] + shaders)
    return done
