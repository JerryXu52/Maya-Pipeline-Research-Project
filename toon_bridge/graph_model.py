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
                 "Vector": "#3c3c83", "Converter": "#246283", "Output": "#8a3434", "Group": "#3b6b5e",
                 "Layout": "#4a4a50", "Other": "#555560"}

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
    if node_type in ("NodeGroupInput", "NodeGroupOutput", "ShaderNodeGroup"):
        return "Group"
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
    for n in graph["nodes"]:              # deleting a frame keeps what was in it
        if n.get("parent") == name:
            n.pop("parent")


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


# ---------------------------------------------------------------- frames and reroutes
def children(graph, frame):
    return [n for n in graph["nodes"] if n.get("parent") == frame]


def join_in_frame(graph, names, label="Frame"):
    """Put nodes in a new frame (Blender: Ctrl+J). Returns the frame's name."""
    names = [n for n in names if node(graph, n) and node(graph, n)["type"] != "NodeFrame"] or []
    tmpl = copy.deepcopy(catalog()["nodes"]["NodeFrame"])
    tmpl.pop("category", None)
    tmpl["name"] = unique_name(graph, "Frame")
    tmpl["label"] = label
    xs = [node(graph, n)["location"][0] for n in names] or [0]
    ys = [node(graph, n)["location"][1] for n in names] or [0]
    tmpl["location"] = [min(xs) - 20, max(ys) + 40]
    graph["nodes"].insert(0, tmpl)              # frames first: drawn behind their nodes
    for n in names:
        node(graph, n)["parent"] = tmpl["name"]
    return tmpl["name"]


def remove_from_frame(graph, names):
    """Blender: Alt+P."""
    for n in names:
        nd = node(graph, n)
        if nd:
            nd.pop("parent", None)


def insert_reroute(graph, link, location):
    """Split a wire with a reroute dot. Returns the reroute's name."""
    a, ao, b, bi = link
    if link not in graph["links"]:
        return None
    tmpl = copy.deepcopy(catalog()["nodes"]["NodeReroute"])
    tmpl.pop("category", None)
    tmpl["name"] = unique_name(graph, "Reroute")
    tmpl["label"] = ""
    tmpl["location"] = [float(location[0]), float(location[1])]
    graph["nodes"].append(tmpl)
    graph["links"].remove(link)
    graph["links"].append([a, ao, tmpl["name"], "Input"])
    graph["links"].append([tmpl["name"], "Output", b, bi])
    return tmpl["name"]


# ---------------------------------------------------------------- node groups
IFACE_TYPES = {"VALUE": "NodeSocketFloat", "RGBA": "NodeSocketColor", "VECTOR": "NodeSocketVector",
               "SHADER": "NodeSocketShader", "INT": "NodeSocketInt", "BOOLEAN": "NodeSocketBool"}
SOCKET_OF_IFACE = {v: k for k, v in IFACE_TYPES.items()}


def _sock_type(graph, node_name, side, sid):
    s = socket(node(graph, node_name), side, sid) or {}
    return s.get("type", "VALUE")


def _unique_group_name(root, base):
    names = set((root.get("groups") or {}).keys())
    if base not in names:
        return base
    i = 1
    while "%s.%03d" % (base, i) in names:
        i += 1
    return "%s.%03d" % (base, i)


def _group_node(gname, group, location, name):
    ins = [e for e in group["interface"] if e["in_out"] == "INPUT"]
    outs = [e for e in group["interface"] if e["in_out"] == "OUTPUT"]
    return {"name": name, "type": "ShaderNodeGroup", "label": "", "title": "Group", "group": gname,
            "location": [float(location[0]), float(location[1])], "width": 160.0, "mute": False, "props": {},
            "inputs": [{"id": e["id"], "name": e["name"], "type": SOCKET_OF_IFACE.get(e["type"], "VALUE"),
                        "enabled": True} for e in ins],
            "outputs": [{"id": e["id"], "name": e["name"], "type": SOCKET_OF_IFACE.get(e["type"], "VALUE"),
                         "enabled": True} for e in outs]}


def make_group(root, graph, names, gname="NodeGroup"):
    """Blender's Ctrl+G: move nodes into a new node group; wires that cross become group sockets.

    `root` is the look's whole graph (it owns "groups"); `graph` is the level being edited.
    Returns the new group node's name, or None.
    """
    inside = set(n for n in names if node(graph, n) and node(graph, n)["type"] not in
                 ("NodeGroupInput", "NodeGroupOutput", "ShaderNodeOutputMaterial", "NodeFrame"))
    if not inside:
        return None
    gname = _unique_group_name(root, gname)
    iface, links_in, links_out, outer, inner = [], {}, {}, [], []
    counter = [0]

    def new_id():
        counter[0] += 1
        return "Socket_%d" % (counter[0] - 1)

    for l in graph["links"]:
        a, ao, b, bi = l
        if a in inside and b in inside:
            inner.append(list(l))
        elif b in inside:                       # wire coming in: one group input per source socket
            key = (a, ao)
            if key not in links_in:
                sid = new_id()
                links_in[key] = sid
                iface.append({"id": sid, "name": (socket(node(graph, b), "inputs", bi) or {}).get("name", "Value"),
                              "in_out": "INPUT", "type": IFACE_TYPES.get(_sock_type(graph, a, "outputs", ao),
                                                                          "NodeSocketFloat")})
            inner.append(["Group Input", links_in[key], b, bi])
        elif a in inside:                       # wire going out: one group output per source socket
            key = (a, ao)
            if key not in links_out:
                links_out[key] = None
            outer.append(l)
        else:
            outer.append(list(l))
    for key in links_out:
        sid = new_id()
        links_out[key] = sid
        iface.append({"id": sid, "name": (socket(node(graph, key[0]), "outputs", key[1]) or {}).get("name", "Value"),
                      "in_out": "OUTPUT", "type": IFACE_TYPES.get(_sock_type(graph, key[0], "outputs", key[1]),
                                                                   "NodeSocketFloat")})
        inner.append([key[0], key[1], "Group Output", sid])
    moved = [copy.deepcopy(n) for n in graph["nodes"] if n["name"] in inside]
    for n in moved:
        if n.get("parent") not in inside:
            n.pop("parent", None)
    xs = [n["location"][0] for n in moved]
    ys = [n["location"][1] for n in moved]
    cx, cy = sum(xs) / len(xs), sum(ys) / len(ys)
    gi = copy.deepcopy(catalog()["nodes"]["NodeGroupInput"])
    go = copy.deepcopy(catalog()["nodes"]["NodeGroupOutput"])
    for io, side, x in ((gi, "outputs", min(xs) - 260), (go, "inputs", max(xs) + 260)):
        io.pop("category", None)
        io["name"] = "Group Input" if io is gi else "Group Output"
        io["location"] = [x, cy]
        io[side] = [{"id": e["id"], "name": e["name"], "type": SOCKET_OF_IFACE.get(e["type"], "VALUE"),
                     "enabled": True} for e in iface if e["in_out"] == ("INPUT" if io is gi else "OUTPUT")]
        io["inputs" if side == "outputs" else "outputs"] = []
    group = {"interface": iface, "nodes": [gi] + moved + [go], "links": inner}
    root.setdefault("groups", {})[gname] = group
    gnode_name = unique_name(graph, gname)
    graph["nodes"] = [n for n in graph["nodes"] if n["name"] not in inside]
    graph["nodes"].append(_group_node(gname, group, (cx, cy), gnode_name))
    new_links = []
    for l in outer:
        a, ao, b, bi = l
        if a in inside:
            new_links.append([gnode_name, links_out[(a, ao)], b, bi])
        else:
            new_links.append(list(l))
    for (a, ao), sid in links_in.items():
        new_links.append([a, ao, gnode_name, sid])
    graph["links"] = new_links
    return gnode_name


def add_group_node(root, graph, gname, location=(0, 0)):
    group = root.get("groups", {}).get(gname)
    if not group:
        return None
    name = unique_name(graph, gname)
    graph["nodes"].append(_group_node(gname, group, location, name))
    return name


def ungroup(root, graph, gnode_name):
    """Blender's Ctrl+Alt+G: put a group's nodes back in place of the group node."""
    gn = node(graph, gnode_name)
    if not gn or gn["type"] != "ShaderNodeGroup":
        return []
    group = root.get("groups", {}).get(gn.get("group"))
    if not group:
        return []
    io = {n["name"] for n in group["nodes"] if n["type"] in ("NodeGroupInput", "NodeGroupOutput")}
    inner = [n for n in group["nodes"] if n["name"] not in io]
    xs = [n["location"][0] for n in inner] or [0]
    ys = [n["location"][1] for n in inner] or [0]
    dx, dy = gn["location"][0] - sum(xs) / len(xs), gn["location"][1] - sum(ys) / len(ys)
    rename = {}
    for n in inner:
        c = copy.deepcopy(n)
        c["name"] = unique_name(graph, n["name"])
        rename[n["name"]] = c["name"]
        c["location"] = [n["location"][0] + dx, n["location"][1] + dy]
        graph["nodes"].append(c)
    for c in graph["nodes"]:
        if c["name"] in rename.values() and c.get("parent") in rename:
            c["parent"] = rename[c["parent"]]
    feeds = {l[3]: (l[0], l[1]) for l in graph["links"] if l[2] == gnode_name}      # group input id -> source
    takes = [l for l in graph["links"] if l[0] == gnode_name]                       # group output id -> targets
    gi_name = next((n["name"] for n in group["nodes"] if n["type"] == "NodeGroupInput"), None)
    go_name = next((n["name"] for n in group["nodes"] if n["type"] == "NodeGroupOutput"), None)
    new_links = [l for l in graph["links"] if l[0] != gnode_name and l[2] != gnode_name]
    for a, ao, b, bi in group["links"]:
        if a == gi_name and b in rename:
            if ao in feeds:
                new_links.append([feeds[ao][0], feeds[ao][1], rename[b], bi])
        elif b == go_name and a in rename:
            for l in takes:
                if l[1] == bi:
                    new_links.append([rename[a], ao, l[2], l[3]])
        elif a in rename and b in rename:
            new_links.append([rename[a], ao, rename[b], bi])
    graph["links"] = new_links
    graph["nodes"] = [n for n in graph["nodes"] if n["name"] != gnode_name]
    if not any(n.get("group") == gn["group"] for lvl in _levels(root) for n in lvl["nodes"]):
        root["groups"].pop(gn["group"], None)
        if not root["groups"]:
            root.pop("groups")
    return list(rename.values())


def _levels(root):
    yield root
    for g in (root.get("groups") or {}).values():
        if g:
            yield g


# ---------------------------------------------------------------- tidy layout
def node_height(n):
    """About how tall the node editor draws a node (header + one row per visible line)."""
    if n["type"] == "NodeReroute":
        return 20
    rows = sum(1 for s in n.get("outputs", []) if s.get("enabled", True))
    rows += sum(1 for p in n.get("props", {}).values() if p.get("type") == "ENUM")
    rows += sum(1 for s in n.get("inputs", []) if s.get("enabled", True))
    rows += 1 if ("ramp" in n or n["type"] in ("ShaderNodeTexImage", "ShaderNodeAttribute", "ShaderNodeGroup")) else 0
    return 24 + 20 * rows + 8


def auto_layout(graph, col_gap=60, row_gap=30):
    """Arrange nodes in columns by distance from the output, no overlaps (like Node Arrange).

    Columns run right to left from the material/group output; inside a column nodes are
    ordered by where their targets sit, which keeps wires from crossing much. Frames are
    left alone (they follow their nodes).
    """
    nodes = [n for n in graph["nodes"] if n["type"] != "NodeFrame"]
    if not nodes:
        return
    outs = {}
    for a, _ao, b, _bi in graph["links"]:
        outs.setdefault(a, set()).add(b)
    depth = {}

    def d(name, seen=()):
        if name in depth:
            return depth[name]
        if name in seen:
            return 0
        nxt = outs.get(name, set())
        depth[name] = 0 if not nxt else 1 + max(d(m, seen + (name,)) for m in nxt)
        return depth[name]

    for n in nodes:
        d(n["name"])
    by_col = {}
    for n in nodes:
        by_col.setdefault(depth[n["name"]], []).append(n)
    widths = {c: max(float(n.get("width", 140)) for n in ns) for c, ns in by_col.items()}
    x, col_x = 0.0, {}
    for c in sorted(by_col):
        col_x[c] = x - widths[c]
        x = col_x[c] - col_gap
    placed = {}
    for c in sorted(by_col):
        col = by_col[c]

        def target_y(n):
            ys = [placed[t] for t in outs.get(n["name"], ()) if t in placed]
            return sum(ys) / len(ys) if ys else 0.0
        col.sort(key=target_y, reverse=True)
        total = sum(node_height(n) for n in col) + row_gap * (len(col) - 1)
        y = total / 2.0
        for n in col:
            n["location"] = [round(col_x[c], 1), round(y, 1)]
            placed[n["name"]] = y - node_height(n) / 2.0
            y -= node_height(n) + row_gap
