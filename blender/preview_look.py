"""Render a quick preview swatch of one look, for the Look Editor in Maya.

    blender -b --factory-startup --python blender/preview_look.py -- <look.json> <out.png> [width height]

<look.json> holds {"name": "...", "look": {...}} (the look being edited, unsaved).
A sphere, a ring and the ground all wear the look (Maya-colour looks get a red
sphere, a blue ring and a yellow ground), lit by one hard sun, with the look's
own outline. About a second.
"""
import json
import math
import os
import sys

import bpy

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path[:0] = [HERE, os.path.dirname(HERE)]
import toon_materials as tm  # noqa: E402
from toon_bridge import lookdefs  # noqa: E402

argv = sys.argv[sys.argv.index("--") + 1:]
data = json.load(open(argv[0]))
out = os.path.abspath(argv[1])
W = int(argv[2]) if len(argv) > 2 else 480
H = int(argv[3]) if len(argv) > 3 else 300
name, look = data.get("name", "preview"), lookdefs.normalize(data["look"])

bpy.ops.wm.read_factory_settings(use_empty=True)
sc = bpy.context.scene
mat = tm.build_look(name, look)
omat = tm.build_outline(name, look)


# the floor gets a neutral two-tone look, so only the objects show the edited look
floor_mat = tm.build_look("preview_floor", {"base_color": [0.93, 0.9, 0.84],
                                            "bands": [[0.0, [0.72, 0.7, 0.8]], [0.3, [1, 1, 1]]]})


def add(kind, loc, color, **kw):
    getattr(bpy.ops.mesh, "primitive_%s_add" % kind)(location=loc, **kw)
    o = bpy.context.object
    if kind != "plane":
        bpy.ops.object.shade_smooth()
    o[tm.COLOR_ATTR] = color
    o.data.materials.append(floor_mat if kind == "plane" else mat)
    if omat and kind != "plane":
        tm.add_outline(o, omat, look["outline"]["width_cm"] * 0.01 * 2.5)
    return o


add("uv_sphere", (0, 0, 1), (0.92, 0.14, 0.22), radius=0.9, segments=64, ring_count=32)
add("torus", (1.9, 0.9, 1.25), (0.3, 0.55, 0.98), major_radius=0.62, minor_radius=0.2,
    rotation=(math.radians(68), 0, math.radians(25)))
add("plane", (0, 0, 0), (0.98, 0.85, 0.3), size=40)
bpy.ops.object.light_add(type="SUN", rotation=(math.radians(52), math.radians(12), math.radians(-38)))
sun = bpy.context.object
sun.data.energy = math.pi
tm.toon_light(sun.data)
bpy.ops.object.camera_add(location=(0.9, -7.6, 2.6), rotation=(math.radians(80), 0, math.radians(7)))
sc.camera = bpy.context.object
sc.camera.data.lens = 50
tm.setup_render(sc, W, H, samples=8)
tm.set_aspect(W / float(H))
tm.setup_world(sc, data.get("background", [0.94, 0.93, 0.9]), (0.05, 0.05, 0.06))
sc.render.filepath = out
bpy.ops.render.render(write_still=True)
print("TOONBRIDGE PREVIEW", out, flush=True)
