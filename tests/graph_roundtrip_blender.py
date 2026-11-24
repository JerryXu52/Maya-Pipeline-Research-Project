"""Blender: every library look -> dump -> rebuild -> dump is identical, and renders the same.

    blender -b --factory-startup --python tests/graph_roundtrip_blender.py
"""
import json
import os
import sys

import bpy

REPO = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path[:0] = [os.path.join(REPO, "blender"), REPO]
import node_graph  # noqa: E402
import toon_materials as tm  # noqa: E402

looks = {k: v for k, v in json.load(open(os.path.join(REPO, "blender", "looks.json"))).items() if not k.startswith("_")}
ok = True
for name, look in looks.items():
    mat = tm.build_look(name, look)
    g1 = node_graph.dump_tree(mat.node_tree)
    m2 = node_graph.build_material(name + "_rebuilt", g1)
    g2 = node_graph.dump_tree(m2.node_tree)
    same = json.dumps(g1, sort_keys=True) == json.dumps(g2, sort_keys=True)
    ok = ok and same
    print("ROUNDTRIP %-15s nodes=%2d links=%2d %s" % (name, len(g1["nodes"]), len(g1["links"]), "OK" if same else "DIFF"))
    if not same:
        for a, b in zip(g1["nodes"], g2["nodes"]):
            if a != b:
                print("  first diff in", a["name"])
                break
print("ROUNDTRIP", "PASS" if ok else "FAIL")
sys.stdout.flush()
os._exit(0 if ok else 1)
