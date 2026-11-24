"""Render a quick preview swatch of one look, for the Look Editor in Maya.

    blender -b --factory-startup --python blender/preview_look.py -- <look.json> <out.png> [width height]

<look.json> holds {"name": "...", "look": {...}} (the look being edited, unsaved).
A look with a full node graph renders that graph. About a second.
"""
import json
import os
import sys

import bpy

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path[:0] = [HERE, os.path.dirname(HERE)]
import node_graph  # noqa: E402
import preview_scene  # noqa: E402
import toon_materials as tm  # noqa: E402
from toon_bridge import lookdefs  # noqa: E402

argv = sys.argv[sys.argv.index("--") + 1:]
data = json.load(open(argv[0]))
out = os.path.abspath(argv[1])
W = int(argv[2]) if len(argv) > 2 else 480
H = int(argv[3]) if len(argv) > 3 else 300
name, look = data.get("name", "preview"), lookdefs.normalize(data["look"])

bpy.ops.wm.read_factory_settings(use_empty=True)
mat = node_graph.material_for(name, look)
omat = tm.build_outline(name, look)
preview_scene.render_swatch(mat, omat, look["outline"]["width_cm"], out, W, H, data.get("background", [0.94, 0.93, 0.9]))
print("TOONBRIDGE PREVIEW", out, flush=True)
