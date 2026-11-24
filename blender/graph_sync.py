"""One round trip for Maya's node editor: rebuild a look's graph, send the exact result back,
and render its preview swatch.

    blender -b --factory-startup --python blender/graph_sync.py -- <request.json> <response.json> [<preview.png> W H]

request:  {"name", "look"}  a look with or without "graph" (without: the template graph is made)
response: {"graph": exact dump after Blender rebuilt it, "problems": [...]}
The rebuilt dump is what makes Maya's view exact: sockets that Blender shows or hides
after a setting changes (a Mix node switched to Float) come back as Blender has them.
"""
import json
import os
import sys

import bpy

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path[:0] = [HERE, os.path.dirname(HERE)]
import node_graph  # noqa: E402
import toon_materials as tm  # noqa: E402
from toon_bridge import lookdefs  # noqa: E402

argv = sys.argv[sys.argv.index("--") + 1:]
req = json.load(open(argv[0]))
name, look = req.get("name", "look"), lookdefs.normalize(req["look"])
bpy.ops.wm.read_factory_settings(use_empty=True)
problems = []
if look.get("graph"):
    mat = bpy.data.materials.new(name)
    mat.use_nodes = True
    problems = node_graph.build_tree(mat.node_tree, look["graph"])
else:
    mat = tm.build_look(name, look)
graph = node_graph.dump_tree(mat.node_tree)
with open(argv[1], "w") as f:
    json.dump({"graph": graph, "problems": problems}, f)
print("TOONBRIDGE GRAPH", len(graph["nodes"]), "nodes", len(graph["links"]), "links", flush=True)
if len(argv) > 2:
    import preview_scene
    W = int(argv[3]) if len(argv) > 3 else 360
    H = int(argv[4]) if len(argv) > 4 else 236
    preview_scene.render_swatch(mat, tm.build_outline(name, look), look["outline"]["width_cm"],
                                os.path.abspath(argv[2]), W, H)
    print("TOONBRIDGE PREVIEW", argv[2], flush=True)
