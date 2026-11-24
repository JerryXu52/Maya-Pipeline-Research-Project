"""The little scene the Look Editor previews a look on (sphere, ring, neutral floor)."""
import math

import bpy

import toon_materials as tm


def render_swatch(mat, outline_mat, outline_width_cm, out, W=480, H=300, background=(0.94, 0.93, 0.9)):
    sc = bpy.context.scene
    floor = tm.build_look("preview_floor", {"base_color": [0.93, 0.9, 0.84],
                                             "bands": [[0.0, [0.72, 0.7, 0.8]], [0.3, [1, 1, 1]]]})

    def add(kind, loc, color, **kw):
        getattr(bpy.ops.mesh, "primitive_%s_add" % kind)(location=loc, **kw)
        o = bpy.context.object
        if kind != "plane":
            bpy.ops.object.shade_smooth()
        o[tm.COLOR_ATTR] = color
        o.data.materials.append(floor if kind == "plane" else mat)
        if outline_mat and kind != "plane":
            tm.add_outline(o, outline_mat, outline_width_cm * 0.01 * 2.5)
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
    tm.setup_world(sc, background, (0.05, 0.05, 0.06))
    sc.render.filepath = out
    bpy.ops.render.render(write_still=True)
