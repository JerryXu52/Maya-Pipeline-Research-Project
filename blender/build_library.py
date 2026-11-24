"""Build look_library.blend from looks.json (and optionally a look sheet image).

    blender -b --python blender/build_library.py -- [--sheet docs/images/look_sheet.png]

The .blend contains one material per look plus a small preview stage (a row
of test shapes, a sun and a camera). Artists can open it in Blender, tweak the
node trees, and save: render.py appends materials from this file by name, so
hand edits are used in every render from Maya.
"""
import json
import math
import os
import sys

import bpy

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path[:0] = [HERE, os.path.dirname(HERE)]
import toon_materials as tm  # noqa: E402

argv = sys.argv[sys.argv.index("--") + 1:] if "--" in sys.argv else []
sheet = argv[argv.index("--sheet") + 1] if "--sheet" in argv else None

with open(os.path.join(HERE, "looks.json")) as f:
    looks = {k: v for k, v in json.load(f).items() if not k.startswith("_")}

bpy.ops.wm.read_factory_settings(use_empty=True)
scene = bpy.context.scene

PREVIEW_COLORS = [(0.95, 0.15, 0.25), (1, 1, 1), (0.98, 0.85, 0.25), (0.95, 0.45, 0.35), (1, 1, 1), (0.35, 0.6, 0.95), (0.75, 0.78, 0.85),
                  (0.45, 0.75, 0.4), (0.98, 0.8, 0.3), (1, 1, 1)]

spacing = 2.6
n = len(looks)
for i, (name, look) in enumerate(looks.items()):
    mat = tm.build_look(name, look)
    omat = tm.build_outline(name, look)
    x = (i - (n - 1) / 2) * spacing
    bpy.ops.mesh.primitive_uv_sphere_add(radius=0.8, location=(x, 0, 0.8), segments=48, ring_count=24)
    sph = bpy.context.object
    bpy.ops.mesh.primitive_torus_add(location=(x, 0, 2.45), major_radius=0.5, minor_radius=0.18,
                                     rotation=(math.radians(70), 0, 0))
    tor = bpy.context.object
    for ob in (sph, tor):
        bpy.ops.object.select_all(action="DESELECT")
        ob.select_set(True)
        bpy.context.view_layer.objects.active = ob
        bpy.ops.object.shade_smooth()
        ob.name = "preview_" + name
        ob[tm.COLOR_ATTR] = PREVIEW_COLORS[i % len(PREVIEW_COLORS)]
        ob.data.materials.append(mat)
        from toon_bridge import lookdefs
        o = lookdefs.normalize(look)["outline"]
        tm.add_outline(ob, omat, (o.get("width_cm", 0) if o.get("enabled") else 0) * 0.01 * 2)

bpy.ops.mesh.primitive_plane_add(size=60, location=(0, 0, 0))
ground = bpy.context.object
ground.name = "preview_ground"
ground[tm.COLOR_ATTR] = (0.85, 0.82, 0.75)
ground.data.materials.append(bpy.data.materials["painted_ground"])

bpy.ops.object.light_add(type="SUN", rotation=(math.radians(50), math.radians(10), math.radians(-35)))
sun = bpy.context.object
sun.data.energy = math.pi
tm.toon_light(sun.data)

# pull the camera back so every look fits across the frame
dist = max(24.0, n * spacing * 40.0 / 36.0 + 3.0)
bpy.ops.object.camera_add(location=(0, -dist, 4.2), rotation=(math.radians(85), 0, 0))
cam = bpy.context.object
cam.data.lens = 40
scene.camera = cam

tm.setup_render(scene, 2400, 620, samples=32)
tm.set_aspect(2400 / 620.0)
tm.setup_world(scene, background=(0.93, 0.92, 0.88), ambient=(0.05, 0.05, 0.06))

out_blend = os.path.join(HERE, "look_library.blend")
bpy.ops.wm.save_as_mainfile(filepath=out_blend)
print("TOONBRIDGE saved", out_blend)

if sheet:
    scene.render.filepath = os.path.abspath(sheet)
    bpy.ops.render.render(write_still=True)
    print("TOONBRIDGE sheet", sheet)
