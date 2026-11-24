"""Build the presentation scene: a rooftop jump at dusk, staged for a live demo.

    mayapy demo/make_presentation_scene.py        -> demo/presentation.ma (+ demo/textures/*.png)

What is staged for the class demo (see docs/PRESENTATION_DEMO.md):
  * the hero has NO look yet       -> you assign one live (step 1)
  * two buildings share the name 'tower' in different groups,
    and the rooftop AC units have no look -> pre-flight finds both, Fix repairs them (step 3)
  * everything else already has a look, the camera follows the jump, the sun is low and warm
  * buildings use a tiled window texture -> shows texture support under the halftone
Units: cm, Y-up, 24 fps, frames 1-96.
"""
import os
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
REPO = os.path.dirname(HERE)
if REPO not in sys.path:
    sys.path.insert(0, REPO)
if HERE not in sys.path:
    sys.path.insert(0, HERE)

import maya.cmds as cmds  # noqa: E402

from toon_bridge import exporter, looks  # noqa: E402
import make_demo_scene as base  # noqa: E402

START, END = 1, 96
TEX_DIR = os.path.join(HERE, "textures")
HERO_PARTS = ["bean_body", "bean_head", "bean_eye_L", "bean_eye_R", "bean_scarf"]


# ---------------------------------------------------------------- textures
def make_window_textures():
    """Three 256 px tiles: a wall colour with one lit window. Tiled by the UVs."""
    from PySide6 import QtGui
    os.makedirs(TEX_DIR, exist_ok=True)
    variants = {
        "windows_violet": ((96, 62, 140), (255, 214, 92), (58, 36, 92)),
        "windows_teal": ((40, 120, 130), (255, 236, 150), (22, 70, 80)),
        "windows_brick": ((178, 78, 60), (255, 200, 110), (110, 44, 34)),
    }
    paths = {}
    for name, (wall, lit, frame) in variants.items():
        img = QtGui.QImage(256, 256, QtGui.QImage.Format_RGB32)
        img.fill(QtGui.QColor(*wall))
        p = QtGui.QPainter(img)
        p.fillRect(56, 52, 144, 150, QtGui.QColor(*frame))
        p.fillRect(66, 62, 124, 130, QtGui.QColor(*lit))
        p.fillRect(124, 62, 8, 130, QtGui.QColor(*frame))     # window cross
        p.fillRect(66, 122, 124, 8, QtGui.QColor(*frame))
        p.end()
        path = os.path.join(TEX_DIR, name + ".png")
        img.save(path)
        paths[name] = path
    return paths


def textured(name, path):
    sh = cmds.shadingNode("lambert", asShader=True, name=name)
    f = cmds.shadingNode("file", asTexture=True, name=name + "_file")
    cmds.setAttr(f + ".fileTextureName", path, type="string")
    cmds.connectAttr(f + ".outColor", sh + ".color")
    sg = cmds.sets(renderable=True, noSurfaceShader=True, empty=True, name=name + "SG")
    cmds.connectAttr(sh + ".outColor", sg + ".surfaceShader")
    return sg


def tile_uvs(mesh, cm_per_tile=90.0):
    """World-scaled planar UVs per face, so one window tile = cm_per_tile on every wall."""
    cmds.polyAutoProjection(mesh, layoutMethod=0, layout=0, scaleMode=0, percentageSpace=0,
                            optimize=0, planes=6, insertBeforeDeformers=False)
    cmds.polyEditUV(mesh + ".map[*]", pivotU=0, pivotV=0, scaleU=1.0 / cm_per_tile, scaleV=1.0 / cm_per_tile)
    cmds.delete(mesh, constructionHistory=True)


# ---------------------------------------------------------------- set
def building(name, x0, x1, z0, z1, top, sg, look="pop_comic"):
    w, d, h = x1 - x0, z1 - z0, top + 2000
    b = cmds.polyCube(name=name, width=w, height=h, depth=d)[0]
    cmds.move((x0 + x1) / 2.0, top - h / 2.0, (z0 + z1) / 2.0, b)
    cmds.makeIdentity(b, apply=True, translate=True)
    tile_uvs(b)
    base.paint(b, sg)
    if look:
        looks.assign(look, [b])
    return b


def build_city(tex):
    sg_v, sg_t, sg_b = (textured("wall_violet", tex["windows_violet"]),
                        textured("wall_teal", tex["windows_teal"]),
                        textured("wall_brick", tex["windows_brick"]))
    # the two rooftops the hero jumps between (a 130 cm gap)
    roof_a = building("roofA_building", -620, -20, -260, 220, 0, sg_b)
    roof_b = building("roofB_building", 110, 760, -300, 200, -30, sg_t)
    # roof slabs (flat colour, so the halftone shadows read clearly)
    slab = base.lambert("roof_mat", (0.62, 0.58, 0.70))
    for name, (x0, x1, z0, z1, y) in {"roofA_top": (-630, -10, -270, 230, 0),
                                      "roofB_top": (100, 770, -310, 210, -30)}.items():
        t = cmds.polyCube(name=name, width=x1 - x0, height=8, depth=z1 - z0)[0]
        cmds.move((x0 + x1) / 2.0, y + 4, (z0 + z1) / 2.0, t)
        base.paint(t, slab)
        looks.assign("pop_ground", [t])

    # skyline behind, in two groups; one name repeats on purpose (pre-flight demo)
    near, far = [], []
    specs = [(-1500, -1250, 380, sg_v), (-1180, -980, 620, sg_t), (-900, -700, 300, sg_b),
             (-620, -380, 900, sg_v), (-300, -120, 520, sg_b), (-40, 220, 1100, sg_t),
             (300, 520, 640, sg_v), (600, 820, 420, sg_b), (900, 1160, 820, sg_t),
             (1240, 1500, 480, sg_v)]
    for i, (x0, x1, top, sg) in enumerate(specs):
        z0 = -900 - (i % 3) * 260
        b = building("tower" if i in (3, 8) else "tower_%d" % i, x0, x1, z0 - 300, z0, top, sg)
        (near if i % 2 == 0 else far).append(b)
    cmds.group(near, name="skyline_near")
    cmds.group(far, name="skyline_far")
    # Maya renamed the second 'tower' to 'tower1' while both were top level;
    # now they sit in different groups, so the clash Maya allows can be made
    clash = cmds.ls("tower1", long=True)
    if clash:
        cmds.rename(clash[0], "tower")

    # rooftop props: water tank + antenna (tagged) and AC units (left untagged on purpose)
    metal = base.lambert("tank_mat", (0.45, 0.75, 0.95))
    tank = cmds.polyCylinder(name="water_tank", radius=60, height=110, subdivisionsX=32)[0]
    cmds.move(-480, 120, -120, tank)
    legs = cmds.polyCube(name="tank_stand", width=110, height=60, depth=110)[0]
    cmds.move(-480, 38, -120, legs)
    roof_cone = cmds.polyCone(name="tank_roof", radius=66, height=40, subdivisionsX=32)[0]
    cmds.move(-480, 195, -120, roof_cone)
    base.paint([tank, roof_cone], metal)
    base.paint(legs, base.lambert("stand_mat", (0.35, 0.30, 0.40)))
    looks.assign("pop_comic", [tank, roof_cone, legs])
    ant = cmds.polyCylinder(name="antenna", radius=3, height=260, subdivisionsX=8)[0]
    cmds.move(620, 100, -200, ant)
    base.paint(ant, base.lambert("antenna_mat", (0.9, 0.9, 0.95)))
    looks.assign("pop_comic", [ant])
    ac = base.lambert("ac_mat", (0.82, 0.84, 0.88))
    for i, (x, z) in enumerate([(-260, -160), (-190, -160), (420, -180)]):
        a = cmds.polyCube(name="ac_unit%d" % i, width=56, height=44, depth=56)[0]
        cmds.move(x, 30 + (-30 if x > 0 else 0), z, a)       # resting on the slab
        base.paint(a, ac)            # no look: pre-flight warns, Fix tags it
    return roof_a, roof_b


# ---------------------------------------------------------------- hero + camera
def build_hero():
    char = base.build_character()                      # the skinned bean rig from the demo
    paint = base.paint
    paint("bean_body", base.lambert("hero_suit_mat", (0.92, 0.10, 0.18)))
    paint("bean_scarf", base.lambert("hero_scarf_mat", (0.10, 0.25, 0.85)))
    paint("bean_head", base.lambert("hero_mask_mat", (0.95, 0.12, 0.20)))
    paint(["bean_eye_L", "bean_eye_R"], base.lambert("hero_lens_mat", (0.98, 0.98, 1.0)))
    looks.clear(["bean_body", "bean_head", "bean_eye_L", "bean_eye_R", "bean_scarf"])

    j0, j1, j2 = "bean_root_jnt", "bean_mid_jnt", "bean_top_jnt"
    cmds.cutKey([j0, j1, j2], clear=True)
    for a in ("translateX", "translateY", "translateZ"):
        cmds.setAttr(j0 + "." + a, 0)
    # run, crouch, leap the gap, land with a squash, straighten
    base.key(j0, "translateX", [(1, -420), (24, -150), (30, -110), (50, 160), (56, 230), (96, 380)])
    # roof A slab top = 8, roof B slab top = -22: feet rest ON the slab (buried feet confuse Freestyle)
    base.key(j0, "translateY", [(1, 8), (24, 8), (30, 8), (40, 160), (50, -2), (56, -22), (96, -22)])
    base.key(j0, "rotateY", [(1, 90), (96, 90)])
    base.key(j1, "rotateX", [(1, 0), (12, 6), (24, -4), (28, 22), (36, -24), (46, -10), (52, 26), (62, -6), (72, 0), (96, 0)])
    base.key(j2, "rotateX", [(1, 0), (28, 16), (36, -20), (52, 18), (64, -4), (72, 0), (96, 0)])
    base.key(j2, "rotateY", [(60, 0), (76, -55), (96, -55)])   # turns to camera after landing
    return char


def build_camera():
    target = cmds.spaceLocator(name="camTarget")[0]
    cmds.pointConstraint("bean_root_jnt", target, offset=(0, 55, 0))
    cmds.setAttr(target + ".visibility", 0)
    cam = cmds.camera(name="shotCam", focalLength=28, horizontalFilmAperture=1.417, verticalFilmAperture=0.945)[0]
    cam = cmds.rename(cam, "shotCam")
    shape = cmds.listRelatives(cam, shapes=True)[0]
    cmds.setAttr(shape + ".filmFit", 1)
    cmds.setAttr(shape + ".farClipPlane", 100000)
    base.key(cam, "translateX", [(1, -400), (40, -40), (70, 220), (96, 330)])
    base.key(cam, "translateY", [(1, 50), (40, 30), (96, 40)])
    base.key(cam, "translateZ", [(1, 330), (40, 400), (96, 290)])
    cmds.aimConstraint(target, cam, aimVector=(0, 0, -1), upVector=(0, 1, 0), worldUpType="scene")
    base.key(shape, "focalLength", [(1, 30), (60, 30), (96, 42)])
    return cam


def build_lights():
    sun = cmds.directionalLight(name="duskSunShape", intensity=1.1, rgb=(1.0, 0.86, 0.72))
    t = cmds.rename(cmds.listRelatives(sun, parent=True)[0], "duskSun")
    cmds.setAttr(t + ".rotateOrder", 2)
    base.key(t, "rotateX", [(1, -30), (96, -24)])
    base.key(t, "rotateY", [(1, -65), (96, -35)])
    amb = cmds.ambientLight(name="skyFillShape", intensity=0.08, rgb=(0.6, 0.5, 0.95))
    cmds.rename(cmds.listRelatives(amb, parent=True)[0], "skyFill")


def build(save=False):
    cmds.file(new=True, force=True)
    cmds.currentUnit(linear="cm", time="film")
    cmds.playbackOptions(minTime=START, maxTime=END, animationStartTime=START, animationEndTime=END)
    cmds.setAttr("defaultResolution.width", 1280)
    cmds.setAttr("defaultResolution.height", 720)
    cmds.setAttr("defaultResolution.deviceAspectRatio", 1280.0 / 720.0)
    tex = make_window_textures()
    build_city(tex)
    build_hero()
    cam = build_camera()
    build_lights()
    exporter.set_scene_background([1.0, 0.66, 0.50])      # dusk sky
    cmds.setAttr("perspShape.renderable", 0)
    cmds.setAttr(cmds.listRelatives(cam, shapes=True)[0] + ".renderable", 1)
    cmds.currentTime(36)
    if save:
        path = os.path.join(HERE, "presentation.ma")
        cmds.file(rename=path)
        cmds.file(save=True, type="mayaAscii", force=True)
        print("saved", path)
    return cam


def stage_for_render():
    """What you do live in class, done in code (for pre-rendering and tests)."""
    from toon_bridge import preflight
    looks.assign("pop_comic", ["bean_body", "bean_scarf"])
    looks.assign("pop_skin", ["bean_head"])
    looks.assign("flat_ink", ["bean_eye_L", "bean_eye_R"])
    for _ in range(2):
        for r in preflight.run_all(camera="shotCam"):
            if r.fix and r.status != "ok":
                r.fix()


if __name__ == "__main__":
    import maya.standalone
    maya.standalone.initialize()
    build(save=True)
    sys.stdout.flush()
    os._exit(0)
