"""Render the style-card thumbnails shown in the Maya panel (toon_bridge/icons/style_*.png).

    blender -b --factory-startup --python blender/style_thumbs.py

Each card is the same little scene (a character, a ring, the ground) rendered
with that style's looks, lines and print effects, so the card shows exactly
what the style does.
"""
import json
import math
import os
import sys

import bpy

HERE = os.path.dirname(os.path.abspath(__file__))
REPO = os.path.dirname(HERE)
sys.path[:0] = [HERE, REPO]
import toon_materials as tm  # noqa: E402
from toon_bridge import styles  # noqa: E402

LIB = os.path.join(HERE, "look_library.blend")
W, H = 360, 220


def append(names):
    with bpy.data.libraries.load(LIB, link=False) as (src, dst):
        dst.materials = [m for m in src.materials if m in names or m.replace("__outline", "") in names]
    return {m.name: m for m in dst.materials if m}


def obj(kind, name, loc, scale=(1, 1, 1), **kw):
    getattr(bpy.ops.mesh, "primitive_%s_add" % kind)(location=loc, **kw)
    o = bpy.context.object
    o.name = name
    o.scale = scale
    if kind != "plane":
        bpy.ops.object.shade_smooth()
    return o


for key in styles.ORDER:
    st = styles.STYLES[key]
    roles = st["roles"]
    bpy.ops.wm.read_factory_settings(use_empty=True)
    sc = bpy.context.scene
    mats = append(set(roles.values()))
    body = obj("uv_sphere", "body", (0, 0, 0.95), (0.62, 0.62, 0.95), segments=48, ring_count=24)
    head = obj("uv_sphere", "head", (0, 0, 2.15), (0.5, 0.5, 0.5), segments=48, ring_count=24)
    eye_l = obj("uv_sphere", "eye_l", (0.19, -0.45, 2.22), (0.07, 0.04, 0.11))
    eye_r = obj("uv_sphere", "eye_r", (-0.19, -0.45, 2.22), (0.07, 0.04, 0.11))
    ring = obj("torus", "ring", (1.55, 0.6, 1.4), (1, 1, 1), major_radius=0.55, minor_radius=0.16,
               rotation=(math.radians(70), 0, math.radians(30)))
    ground = obj("plane", "ground", (0, 0, 0), size=40)
    colors = {body: (0.92, 0.12, 0.2), head: (1.0, 0.8, 0.66), eye_l: (0.05, 0.05, 0.1),
              eye_r: (0.05, 0.05, 0.1), ring: (0.3, 0.55, 0.98), ground: (0.98, 0.85, 0.3)}
    role = {body: "default", head: "skin", eye_l: "eyes", eye_r: "eyes", ring: "default", ground: "ground"}
    for o, c in colors.items():
        o[tm.COLOR_ATTR] = c
        o.data.materials.append(mats[roles[role[o]]])
    bpy.ops.object.light_add(type="SUN", rotation=(math.radians(55), math.radians(15), math.radians(-40)))
    sun = bpy.context.object
    sun.data.energy = math.pi
    tm.toon_light(sun.data)
    bpy.ops.object.camera_add(location=(1.2, -7.2, 2.0), rotation=(math.radians(84), 0, math.radians(9)))
    sc.camera = bpy.context.object
    sc.camera.data.lens = 42
    tm.setup_render(sc, W, H, samples=16)
    tm.set_aspect(W / float(H))
    tm.setup_world(sc, st["background"], (0.05, 0.05, 0.06))
    tm.setup_ink_lines(sc, bpy.context.view_layer, outer_px=2.2, inner_px=1.1)
    out = os.path.join(REPO, "toon_bridge", "icons", "style_%s.png" % key)
    sc.render.filepath = out
    bpy.ops.render.render(write_still=True)
    if st["settings"].get("misregister_px"):
        tm.misregister(out, 2)
    print("TOONBRIDGE THUMB", out, flush=True)
