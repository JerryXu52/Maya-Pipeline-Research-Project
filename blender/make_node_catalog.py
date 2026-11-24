"""Write toon_bridge/node_catalog.json: the shader nodes Maya's node editor can add.

    blender -b --factory-startup --python blender/make_node_catalog.py

Each entry is a real dump of a fresh node from this Blender, so Maya knows its
sockets, settings and choices without asking Blender again.
"""
import json
import os
import sys

import bpy

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path[:0] = [HERE]
import node_graph  # noqa: E402

MENU = [
    ("Input", ["ShaderNodeValue", "ShaderNodeRGB", "ShaderNodeAttribute", "ShaderNodeTexCoord",
               "ShaderNodeLayerWeight", "ShaderNodeFresnel", "ShaderNodeLightPath", "ShaderNodeObjectInfo",
               "ShaderNodeNewGeometry", "ShaderNodeCameraData"]),
    ("Shader", ["ShaderNodeBsdfDiffuse", "ShaderNodeBsdfGlossy", "ShaderNodeBsdfPrincipled",
                "ShaderNodeEmission", "ShaderNodeBsdfTransparent", "ShaderNodeMixShader", "ShaderNodeAddShader"]),
    ("Texture", ["ShaderNodeTexNoise", "ShaderNodeTexVoronoi", "ShaderNodeTexWave", "ShaderNodeTexChecker",
                 "ShaderNodeTexGradient", "ShaderNodeTexMagic", "ShaderNodeTexImage"]),
    ("Color", ["ShaderNodeMix", "ShaderNodeHueSaturation", "ShaderNodeInvert", "ShaderNodeGamma",
               "ShaderNodeBrightContrast", "ShaderNodeRGBCurve"]),
    ("Converter", ["ShaderNodeMath", "ShaderNodeVectorMath", "ShaderNodeValToRGB", "ShaderNodeMapRange",
                   "ShaderNodeClamp", "ShaderNodeRGBToBW", "ShaderNodeShaderToRGB", "ShaderNodeSeparateXYZ",
                   "ShaderNodeCombineXYZ", "ShaderNodeSeparateColor", "ShaderNodeCombineColor"]),
    ("Vector", ["ShaderNodeMapping", "ShaderNodeVectorRotate", "ShaderNodeNormalMap", "ShaderNodeBump"]),
    ("Layout", ["NodeFrame", "NodeReroute"]),
]
HIDDEN = ["ShaderNodeGroup", "NodeGroupInput", "NodeGroupOutput"]   # made by Group / Ungroup

bpy.ops.wm.read_factory_settings(use_empty=True)
mat = bpy.data.materials.new("catalog")
mat.use_nodes = True
nt = mat.node_tree
nt.nodes.clear()
catalog = {"menu": [], "nodes": {}}
for cat, types in MENU:
    entries = []
    for t in types:
        try:
            n = nt.nodes.new(t)
        except RuntimeError:
            continue
        d = node_graph.dump_node(n)
        d["category"] = cat
        catalog["nodes"][t] = d
        entries.append([t, n.bl_label])
    catalog["menu"].append([cat, entries])
for t in HIDDEN:
    n = nt.nodes.new(t)
    d = node_graph.dump_node(n)
    d["category"] = "Group"
    catalog["nodes"][t] = d
out = os.path.join(os.path.dirname(HERE), "toon_bridge", "node_catalog.json")
with open(out, "w") as f:
    json.dump(catalog, f, indent=0)
print("TOONBRIDGE CATALOG", len(catalog["nodes"]), "node types ->", out)
