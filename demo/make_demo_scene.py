"""Build the Toon Bridge demo shot in Maya and save it as demo/toon_demo.ma.

Run inside Maya:      import make_demo_scene; make_demo_scene.build(save=True)
or headless:          mayapy demo/make_demo_scene.py

The shot is made to exercise the bridge:
  * every look in the library is used at least once
  * a skinned character that bends and hops (deforming Alembic, not just transforms)
  * a moving camera with a focal-length change (camera keys per frame)
  * a key light that sweeps during the shot (toon bands must move with it)
Scene units are Maya's default centimetres, Y-up, 24 fps.
"""
import os
import sys

import maya.cmds as cmds

HERE = os.path.dirname(os.path.abspath(__file__))
REPO = os.path.dirname(HERE)
if REPO not in sys.path:
    sys.path.insert(0, REPO)

from toon_bridge import looks  # noqa: E402

START, END = 1, 72


def lambert(name, rgb):
    sh = cmds.shadingNode("lambert", asShader=True, name=name)
    cmds.setAttr(sh + ".color", *rgb, type="double3")
    cmds.setAttr(sh + ".diffuse", 1.0)
    sg = cmds.sets(renderable=True, noSurfaceShader=True, empty=True, name=name + "SG")
    cmds.connectAttr(sh + ".outColor", sg + ".surfaceShader")
    return sg


def paint(obj, sg):
    cmds.sets(obj, edit=True, forceElement=sg)


def key(obj, attr, pairs):
    for t, v in pairs:
        cmds.setKeyframe(obj, attribute=attr, time=t, value=v)


def build_character():
    """A bean-shaped buddy: skinned body that bends, head, eyes, scarf."""
    body = cmds.polyCylinder(name="bean_body", radius=18, height=32, subdivisionsX=32,
                             subdivisionsY=12, subdivisionsZ=4, roundCap=True)[0]
    cmds.move(0, 25, 0, body)
    cmds.makeIdentity(body, apply=True, translate=True)
    cmds.polySmooth(body, divisions=1)
    cmds.delete(body, constructionHistory=True)
    # rest the rounded bottom ON the ground: geometry buried below the ground
    # confuses Freestyle's hidden-line test (ghost line, missing silhouette)
    min_y = cmds.exactWorldBoundingBox(body)[1]
    cmds.move(0, -min_y + 0.5, 0, body, relative=True)
    cmds.makeIdentity(body, apply=True, translate=True)

    cmds.select(clear=True)
    j0 = cmds.joint(name="bean_root_jnt", position=(0, 0, 0))
    j1 = cmds.joint(name="bean_mid_jnt", position=(0, 22, 0))
    j2 = cmds.joint(name="bean_top_jnt", position=(0, 44, 0))
    j3 = cmds.joint(name="bean_end_jnt", position=(0, 62, 0))
    cmds.skinCluster([j0, j1, j2, j3], body, toSelectedBones=True, maximumInfluences=2, name="bean_skin")

    head = cmds.polySphere(name="bean_head", radius=16, subdivisionsX=40, subdivisionsY=30)[0]
    cmds.move(0, 66, 0, head)
    eye_l = cmds.polySphere(name="bean_eye_L", radius=2.6)[0]
    eye_r = cmds.polySphere(name="bean_eye_R", radius=2.6)[0]
    cmds.move(5.5, 69, 14.2, eye_l)
    cmds.move(-5.5, 69, 14.2, eye_r)
    cmds.scale(1, 1.5, 0.6, eye_l, eye_r)
    scarf = cmds.polyTorus(name="bean_scarf", radius=17, sectionRadius=4.2,
                           subdivisionsX=40, subdivisionsY=16)[0]
    cmds.move(0, 50, 0, scarf)
    for g in (head, eye_l, eye_r, scarf):
        cmds.parent(g, j2)

    rig = cmds.group(j0, name="bean_rig")
    geo = cmds.group(body, name="bean_geo")
    char = cmds.group(rig, geo, name="bean_GRP")

    paint(body, lambert("bean_body_mat", (0.98, 0.62, 0.30)))
    paint(head, lambert("bean_head_mat", (1.0, 0.85, 0.72)))
    paint([eye_l, eye_r], lambert("bean_eye_mat", (0.08, 0.07, 0.12)))
    paint(scarf, lambert("bean_scarf_mat", (0.85, 0.16, 0.22)))
    looks.assign("cel_2d", [body])
    looks.assign("anime_skin", [head])
    looks.assign("flat_ink", [eye_l, eye_r])
    looks.assign("cel_hard", [scarf])

    # hop forward twice, squash on landing, bend into each jump
    key(j0, "translateZ", [(1, -60), (24, -25), (48, 10), (72, 30)])
    key(j0, "translateY", [(1, 0), (10, 0), (17, 22), (24, 0), (34, 0), (41, 26), (48, 0), (72, 0)])
    key(j1, "rotateX", [(1, 0), (8, -18), (14, 12), (24, -8), (30, 0), (38, -20), (44, 14), (52, 0), (72, 0)])
    key(j2, "rotateX", [(1, 0), (8, -14), (14, 10), (24, -6), (30, 0), (38, -16), (44, 12), (52, 0), (60, 6), (72, 0)])
    key(j2, "rotateY", [(48, 0), (60, 25), (72, -10)])
    return char


def build_set():
    ground = cmds.polyPlane(name="ground", width=20000, height=20000, subdivisionsX=120, subdivisionsY=120)[0]
    paint(ground, lambert("ground_mat", (0.72, 0.80, 0.55)))
    looks.assign("ground_2d", [ground])

    sg_leaf = lambert("leaf_mat", (0.30, 0.62, 0.35))
    sg_trunk = lambert("trunk_mat", (0.48, 0.32, 0.22))
    trees = []
    for i, (x, z, s) in enumerate([(-120, -80, 1.0), (-170, 40, 0.8), (140, -130, 1.2), (190, 10, 0.9)]):
        trunk = cmds.polyCylinder(name="tree%d_trunk" % i, radius=6 * s, height=40 * s, subdivisionsX=12)[0]
        cmds.move(x, 20 * s, z, trunk)
        crown = cmds.polyCone(name="tree%d_crown" % i, radius=38 * s, height=90 * s, subdivisionsX=24)[0]
        cmds.move(x, 40 * s + 45 * s, z, crown)
        paint(trunk, sg_trunk)
        paint(crown, sg_leaf)
        looks.assign("cel_2d", [trunk, crown])
        trees.append(cmds.group(trunk, crown, name="tree%d_GRP" % i))

    rocks = []
    sg_rock = lambert("rock_mat", (0.62, 0.60, 0.66))
    for i, (x, z, s) in enumerate([(70, -30, 14), (-60, 60, 10), (95, 70, 8)]):
        r = cmds.polyPlatonicSolid(name="rock%d" % i, solidType=1, radius=s)[0]
        cmds.move(x, s * 0.6, z, r)
        cmds.rotate(20 * i, 37 * i, 0, r)
        paint(r, sg_rock)
        rocks.append(r)
    looks.assign("cel_2d", rocks)

    # floating drone: cel metal ball with an orbiting ring
    drone = cmds.polySphere(name="drone_body", radius=12, subdivisionsX=40, subdivisionsY=30)[0]
    ring = cmds.polyTorus(name="drone_ring", radius=19, sectionRadius=1.8, subdivisionsX=48, subdivisionsY=12)[0]
    paint([drone, ring], lambert("drone_mat", (0.55, 0.70, 0.95)))
    looks.assign("cel_metal", [drone, ring])
    dgrp = cmds.group(drone, ring, name="drone_GRP")
    cmds.move(-55, 95, -10, dgrp)
    key(dgrp, "translateY", [(1, 95), (36, 110), (72, 95)])
    key(ring, "rotateX", [(1, 70), (72, 70)])
    key(ring, "rotateY", [(1, 0), (72, 360)])
    key(dgrp, "translateX", [(1, -55), (72, -20)])

    # a manga-ink signpost
    post = cmds.polyCube(name="sign_post", width=5, height=70, depth=5)[0]
    cmds.move(55, 35, 90, post)
    board = cmds.polyCube(name="sign_board", width=50, height=24, depth=4)[0]
    cmds.move(55, 66, 92, board)
    cmds.rotate(0, -20, 0, board)
    paint([post, board], lambert("sign_mat", (0.9, 0.9, 0.9)))
    looks.assign("manga_ink", [post, board])
    return ground


def build_camera_and_lights():
    cam, shape = cmds.camera(name="shotCam", focalLength=30, horizontalFilmAperture=1.417,
                             verticalFilmAperture=0.945)
    cam = cmds.rename(cam, "shotCam")
    shape = cmds.listRelatives(cam, shapes=True)[0]
    cmds.setAttr(shape + ".filmFit", 1)
    cmds.setAttr(shape + ".farClipPlane", 100000)
    # slow arc around the character, then a push in
    key(cam, "translateX", [(1, -230), (40, -120), (72, 40)])
    key(cam, "translateY", [(1, 110), (72, 85)])
    key(cam, "translateZ", [(1, 260), (40, 300), (72, 280)])
    key(cam, "rotateX", [(1, -12), (72, -8)])
    key(cam, "rotateY", [(1, -38), (40, -18), (72, 6)])
    key(shape, "focalLength", [(1, 30), (50, 30), (72, 40)])

    sun = cmds.directionalLight(name="keyLightShape", intensity=1.0, rgb=(1.0, 0.96, 0.90))
    sun_t = cmds.listRelatives(sun, parent=True)[0]
    sun_t = cmds.rename(sun_t, "keyLight")
    cmds.setAttr(sun_t + ".rotateOrder", 2)
    key(sun_t, "rotateX", [(1, -42), (72, -34)])
    key(sun_t, "rotateY", [(1, -50), (72, 25)])      # the sun sweeps across the shot
    amb = cmds.ambientLight(name="fillAmbientShape", intensity=0.06, rgb=(0.55, 0.6, 0.9))
    cmds.rename(cmds.listRelatives(amb, parent=True)[0], "fillAmbient")
    return cam


def build(save=False):
    cmds.file(new=True, force=True)
    cmds.currentUnit(linear="cm", time="film")
    cmds.playbackOptions(minTime=START, maxTime=END, animationStartTime=START, animationEndTime=END)
    cmds.setAttr("defaultResolution.width", 1280)
    cmds.setAttr("defaultResolution.height", 720)
    cmds.setAttr("defaultResolution.deviceAspectRatio", 1280.0 / 720.0)
    build_character()
    build_set()
    cam = build_camera_and_lights()
    cmds.setAttr("perspShape.renderable", 0)
    cmds.setAttr(cmds.listRelatives(cam, shapes=True)[0] + ".renderable", 1)
    cmds.currentTime(START)
    if save:
        path = os.path.join(HERE, "toon_demo.ma")
        cmds.file(rename=path)
        cmds.file(save=True, type="mayaAscii", force=True)
        print("saved", path)
    return cam


if __name__ == "__main__":
    import maya.standalone
    maya.standalone.initialize()
    build(save=True)
    sys.stdout.flush()
    os._exit(0)
