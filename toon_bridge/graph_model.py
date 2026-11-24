"""Editing a dumped Blender node graph (see blender/node_graph.py), as plain data.

Pure Python, so the rules are tested without Maya or Qt. The Maya node editor calls
these; Blender then rebuilds the graph and sends back its exact version.
"""
import copy
import json
import os

CATALOG_PATH = os.path.join(os.path.dirname(os.path.abspath(__file__)), "node_catalog.json")

# Blender's socket colours, so wires and sockets read the same as in Blender
SOCKET_COLORS = {"VALUE": "#a1a1a1", "RGBA": "#c7c729", "VECTOR": "#6363c7", "SHADER": "#63c763",
                 "INT": "#598c5c", "BOOLEAN": "#cca6d6", "STRING": "#70b2ff", "ROTATION": "#a663c7"}
HEADER_COLORS = {"Input": "#83314a", "Shader": "#2b652b", "Texture": "#79461d", "Color": "#6c6c24",
                 "Vector": "#3c3c83", "Converter": "#246283", "Output": "#8a3434", "Other": "#555560"}

_catalog = None


def catalog():
    global _catalog
    if _catalog is None:
        with open(CATALOG_PATH) as f:
            _catalog = json.load(f)
    return _catalog


def category(node_type):
    entry = catalog()["nodes"].get(node_type)
    if entry:
        return entry["category"]
    if "Output" in node_type:
        return "Output"
    if "Bsdf" in node_type or "Emission" in node_type or node_type.endswith("Shader"):
        return "Shader"
    if "Tex" in node_type and "TexCoord" not in node_type:
        return "Texture"
    return "Other"


def node(graph, name):
    for n in graph["nodes"]:
        if n["name"] == name:
            return n
    return None


def socket(node_dict, side, sid):
    for s in node_dict.get(side, []):
        if s["id"] == sid:
            return s
    return None


def unique_name(graph, base):
    names = {n["name"] for n in graph["nodes"]}
    if base not in names:
        return base
    i = 1
    while "%s.%03d" % (base, i) in names:
        i += 1
    return "%s.%03d" % (base, i)


def add_node(graph, node_type, location=(0, 0)):
    """Add a fresh node of a catalogued type. Returns its name."""
    tmpl = catalog()["nodes"].get(node_type)
    if tmpl is None:
        raise KeyError("no such node type in the catalogue: %s" % node_type)
    n = copy.deepcopy(tmpl)
    n.pop("category", None)
    n["name"] = unique_name(graph, tmpl["title"])
    n["label"] = ""
    n["location"] = [float(location[0]), float(location[1])]
    graph["nodes"].append(n)
    return n["name"]


def remove_node(graph, name):
    graph["nodes"] = [n for n in graph["nodes"] if n["name"] != name]
    graph["links"] = [l for l in graph["links"] if l[0] != name and l[2] != name]


def links_into(graph, to_node, to_sock):
    return [l for l in graph["links"] if l[2] == to_node and l[3] == to_sock]


def disconnect(graph, to_node, to_sock):
    """Remove the link into an input. Returns the removed link (or None)."""
    found = links_into(graph, to_node, to_sock)
    graph["links"] = [l for l in graph["links"] if not (l[2] == to_node and l[3] == to_sock)]
    return found[0] if found else None


def connect(graph, from_node, from_sock, to_node, to_sock):
    """Link an output to an input (an input takes one link: an old one is replaced)."""
    a, b = node(graph, from_node), node(graph, to_node)
    if a is None or b is None or from_node == to_node:
        return False
    if socket(a, "outputs", from_sock) is None or socket(b, "inputs", to_sock) is None:
        return False
    disconnect(graph, to_node, to_sock)
    graph["links"].append([from_node, from_sock, to_node, to_sock])
    return True


def set_input(graph, node_name, sock_id, value, side="inputs"):
    s = socket(node(graph, node_name), side, sock_id)
    if s is not None:
        s["value"] = value
    return s is not None


def set_prop(graph, node_name, prop, value):
    n = node(graph, node_name)
    if n and prop in n.get("props", {}):
        n["props"][prop]["value"] = value
        return True
    return False


def bounds(graph):
    xs = [n["location"][0] for n in graph["nodes"]] or [0]
    ys = [n["location"][1] for n in graph["nodes"]] or [0]
    return min(xs), min(ys), max(xs), max(ys)
