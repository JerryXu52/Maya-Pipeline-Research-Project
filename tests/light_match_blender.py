"""Light-unit check, run in Blender:  blender -b --factory-startup --python tests/light_match_blender.py

A Maya Lambert (diffuse 1) lit head-on by a directional light of intensity I
renders colour * I. This builds the same setup in EEVEE with a plain Diffuse
BSDF and the sun strength from convert.sun_strength(I), renders it with the
Standard view transform and checks the pixel value matches colour * I.
"""
import math
import os
import sys

import bpy

REPO = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, REPO)
from toon_bridge import convert  # noqa: E402

ok = True
for intensity, albedo in [(1.0, 0.5), (0.5, 0.8), (1.5, 0.4)]:
    bpy.ops.wm.read_factory_settings(use_empty=True)
    sc = bpy.context.scene
    sc.render.engine = "BLENDER_EEVEE"
    sc.render.resolution_x = sc.render.resolution_y = 32
    sc.view_settings.view_transform = "Standard"
    sc.render.image_settings.file_format = "OPEN_EXR"      # linear values
    sc.eevee.use_raytracing = False
    sc.eevee.use_fast_gi = False
    world = bpy.data.worlds.new("w")
    world.use_nodes = True
    world.node_tree.nodes["Background"].inputs["Strength"].default_value = 0.0
    sc.world = world

    bpy.ops.mesh.primitive_plane_add(size=10)          # faces +Z
    mat = bpy.data.materials.new("m")
    mat.use_nodes = True
    bsdf = mat.node_tree.nodes["Principled BSDF"]
    mat.node_tree.nodes.remove(bsdf)
    d = mat.node_tree.nodes.new("ShaderNodeBsdfDiffuse")
    d.inputs["Color"].default_value = (albedo, albedo, albedo, 1)
    mat.node_tree.links.new(d.outputs[0], mat.node_tree.nodes["Material Output"].inputs["Surface"])
    bpy.context.object.data.materials.append(mat)

    bpy.ops.object.light_add(type="SUN")                # points down -Z = head-on
    bpy.context.object.data.energy = convert.sun_strength(intensity)
    bpy.context.object.data.use_shadow = False
    bpy.ops.object.camera_add(location=(0, 0, 5))
    sc.camera = bpy.context.object

    path = os.path.join(bpy.app.tempdir, "light_%s.exr" % intensity)
    sc.render.filepath = path
    bpy.ops.render.render(write_still=True)
    img = bpy.data.images.load(path)
    px = img.pixels[:]
    mid = (16 * 32 + 16) * 4
    got = px[mid]
    want = albedo * intensity
    good = abs(got - want) < 0.03 * max(want, 0.1)
    ok = ok and good
    print("LIGHTMATCH intensity %.2f albedo %.2f: Maya %.3f  Blender %.3f  %s"
          % (intensity, albedo, want, got, "OK" if good else "MISMATCH"))
print("LIGHTMATCH", "PASS" if ok else "FAIL")
sys.stdout.flush()
os._exit(0 if ok else 1)
