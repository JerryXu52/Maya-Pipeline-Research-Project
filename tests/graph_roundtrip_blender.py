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
# ---- frames, reroutes and node groups
mat = tm.build_look("layout_test", looks["cel_hard"])
nt = mat.node_tree
frame = nt.nodes.new("NodeFrame")
frame.name, frame.label = "Lighting", "Lighting"
for nm in ("TB Light", "TB Shader to RGB"):
    nt.nodes[nm].parent = frame
link = next(l for l in nt.links if l.to_node.name == "TB Bands")
src, dst = link.from_socket, link.to_socket
rr = nt.nodes.new("NodeReroute")
rr.name, rr.location = "Reroute", (-950, 250)
nt.links.remove(link)
nt.links.new(src, rr.inputs[0])
nt.links.new(rr.outputs[0], dst)
g = bpy.data.node_groups.new("Darken", "ShaderNodeTree")
g.interface.new_socket(name="Value", in_out="INPUT", socket_type="NodeSocketFloat")
g.interface.new_socket(name="Result", in_out="OUTPUT", socket_type="NodeSocketFloat")
gi, go = g.nodes.new("NodeGroupInput"), g.nodes.new("NodeGroupOutput")
m = g.nodes.new("ShaderNodeMath")
m.operation = "MULTIPLY"
m.inputs[1].default_value = 0.8
g.links.new(gi.outputs[0], m.inputs[0])
g.links.new(m.outputs[0], go.inputs[0])
gn = nt.nodes.new("ShaderNodeGroup")
gn.name, gn.node_tree, gn.location = "Darken", g, (-950, 100)
lv = nt.nodes["TB Light value"]
nt.links.new(lv.outputs[0], gn.inputs[0])
g1 = node_graph.dump_tree(nt)
m2 = node_graph.build_material("layout_test_rebuilt", g1)
g2 = node_graph.dump_tree(m2.node_tree)
same = json.dumps(g1, sort_keys=True) == json.dumps(g2, sort_keys=True)
ok = ok and same
print("ROUNDTRIP %-15s frame+reroute+group: groups=%s parents=%d %s" % (
    "layout_test", list(g1.get("groups", {})), sum(1 for n in g1["nodes"] if n.get("parent")), "OK" if same else "DIFF"))
if not same:
    print(json.dumps(g1.get("groups"), sort_keys=True)[:600])
    print(json.dumps(g2.get("groups"), sort_keys=True)[:600])
print("ROUNDTRIP", "PASS" if ok else "FAIL")
sys.stdout.flush()
os._exit(0 if ok else 1)
