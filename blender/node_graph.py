"""A Blender shader node tree <-> plain JSON, so Maya can show and edit the real graph.

dump_tree(tree) -> {"nodes": [...], "links": [...]}
build_tree(tree, graph)  rebuilds the tree from that dict (exact node types, settings,
                         input values, links, positions)

Each node in the JSON:
  name, type (bl_idname), label, location [x, y], width, mute
  props:   the node's own settings (operation, data_type, attribute_name, ...), each
           {"value": v, "type": "ENUM"|"BOOLEAN"|..., "items": [[id, label], ...] for enums}
  ramp:    for Color Ramp nodes: {"interpolation", "elements": [[pos, [r,g,b,a]], ...]}
  image:   for Image Texture nodes: the file path
  inputs / outputs: [{"id": identifier, "name", "type", "enabled", "value"?}]
Links: [from_node, from_socket_id, to_node, to_socket_id]. Socket identifiers are used
(not names) because a node can have several inputs with the same name (Mix: A, B).
"""
import bpy

_BASE = None
SKIP_PROPS = {"color_ramp", "image", "texture_mapping", "color_mapping", "image_user", "script",
              "node_tree", "object", "uv_map", "parent"}


def _base_props():
    global _BASE
    if _BASE is None:
        _BASE = set(p.identifier for p in bpy.types.ShaderNode.bl_rna.properties)
    return _BASE


def _value(sock):
    if not hasattr(sock, "default_value"):
        return None
    v = sock.default_value
    try:
        return [round(float(x), 6) for x in v]
    except TypeError:
        if isinstance(v, bool):
            return v
        if isinstance(v, (int, float)):
            return round(float(v), 6) if isinstance(v, float) else v
        return str(v)


def _sockets(socks):
    out = []
    for s in socks:
        if s.bl_idname == "NodeSocketVirtual":
            continue
        d = {"id": s.identifier, "name": s.name, "type": s.type, "enabled": bool(s.enabled)}
        val = _value(s)
        if val is not None and s.type != "SHADER":
            d["value"] = val
        out.append(d)
    return out


def dump_node(n):
    loc = getattr(n, "location_absolute", n.location)
    d = {"name": n.name, "type": n.bl_idname, "label": n.label, "title": n.bl_label,
         "location": [round(loc[0], 1), round(loc[1], 1)], "width": round(n.width, 1),
         "mute": bool(n.mute), "props": {}}
    if n.parent is not None:
        d["parent"] = n.parent.name
    if n.bl_idname == "NodeFrame":
        d["height"] = round(n.height, 1)
    if n.bl_idname == "ShaderNodeGroup":
        d["group"] = group_name(n.node_tree) if n.node_tree else ""
    for p in n.bl_rna.properties:
        pid = p.identifier
        if pid in _base_props() or pid in SKIP_PROPS or p.is_readonly or pid.startswith("bl_"):
            continue
        if p.type not in ("ENUM", "BOOLEAN", "INT", "FLOAT", "STRING") or getattr(p, "is_array", False):
            continue
        entry = {"type": p.type, "value": getattr(n, pid), "label": p.name}
        if p.type == "ENUM":
            entry["items"] = [[e.identifier, e.name] for e in p.enum_items]
        d["props"][pid] = entry
    if n.bl_idname == "ShaderNodeValToRGB":
        cr = n.color_ramp
        d["ramp"] = {"interpolation": cr.interpolation,
                     "elements": [[round(e.position, 4), [round(c, 5) for c in e.color]] for e in cr.elements]}
    if n.bl_idname == "ShaderNodeTexImage":
        d["image"] = bpy.path.abspath(n.image.filepath) if n.image else ""
    d["inputs"] = _sockets(n.inputs)
    d["outputs"] = _sockets(n.outputs)
    return d


IFACE_TYPES = {"VALUE": "NodeSocketFloat", "RGBA": "NodeSocketColor", "VECTOR": "NodeSocketVector",
               "SHADER": "NodeSocketShader", "INT": "NodeSocketInt", "BOOLEAN": "NodeSocketBool"}


def group_name(tree):
    """A group's name as the look knows it (Blender's datablock name is made unique per look)."""
    return tree.get("tb_name", tree.name)


def _dump_level(tree, groups):
    nodes = []
    for n in tree.nodes:
        nodes.append(dump_node(n))
        if n.bl_idname == "ShaderNodeGroup" and n.node_tree is not None:
            gname = group_name(n.node_tree)
            if gname not in groups:
                groups[gname] = None          # placeholder: stops loops on recursive groups
                groups[gname] = dump_group(n.node_tree, groups)
    links = [[l.from_node.name, l.from_socket.identifier, l.to_node.name, l.to_socket.identifier]
             for l in tree.links if l.is_valid]
    return nodes, links


def dump_group(gtree, groups):
    iface = []
    items = [it for it in gtree.interface.items_tree if it.item_type == "SOCKET"]
    items.sort(key=lambda it: it.in_out != "INPUT")          # inputs first, then outputs
    for it in items:
        e = {"id": it.identifier, "name": it.name, "in_out": it.in_out, "type": it.socket_type}
        if hasattr(it, "default_value"):
            dv = it.default_value
            try:
                e["value"] = [round(float(x), 6) for x in dv]
            except TypeError:
                e["value"] = round(float(dv), 6) if isinstance(dv, float) else dv
        iface.append(e)
    nodes, links = _dump_level(gtree, groups)
    return {"interface": iface, "nodes": nodes, "links": links}


def dump_tree(tree):
    groups = {}
    nodes, links = _dump_level(tree, groups)
    out = {"nodes": nodes, "links": links}
    if groups:
        out["groups"] = groups
    return out


def _find(socks, ident):
    for s in socks:
        if s.identifier == ident:
            return s
    return None


def _build_groups(groups, prefix, problems):
    """Pass 1: every group datablock and its interface. Returns (trees, id maps)."""
    trees, idmaps = {}, {}
    for gname, gd in (groups or {}).items():
        if not gd:
            continue
        real = "%s%s" % (prefix, gname)
        g = bpy.data.node_groups.get(real) or bpy.data.node_groups.new(real, "ShaderNodeTree")
        g["tb_name"] = gname
        g.interface.clear()
        idmap = {}
        for e in gd.get("interface", []):
            stype = e.get("type", "NodeSocketFloat")
            if not stype.startswith("NodeSocket"):
                stype = IFACE_TYPES.get(stype, "NodeSocketFloat")
            try:
                it = g.interface.new_socket(name=e.get("name", "Value"), in_out=e.get("in_out", "INPUT"),
                                            socket_type=stype)
            except (TypeError, RuntimeError) as exc:
                problems.append("group %s socket %s: %s" % (gname, e.get("name"), exc))
                continue
            if "value" in e and hasattr(it, "default_value"):
                try:
                    it.default_value = e["value"] if not isinstance(e["value"], list) else \
                        (list(e["value"]) + list(it.default_value)[len(e["value"]):])[:len(it.default_value)]
                except (TypeError, ValueError):
                    pass
            idmap[e["id"]] = it.identifier
        trees[gname], idmaps[gname] = g, idmap
    return trees, idmaps


def _build_level(tree, graph, trees, idmaps, here, problems):
    """Nodes, settings, values, parents and links of one level (the material or a group)."""
    tree.nodes.clear()
    made = {}

    def sid(nd, ident):
        t = nd["type"]
        if t == "ShaderNodeGroup":
            return idmaps.get(nd.get("group"), {}).get(ident, ident)
        if t in ("NodeGroupInput", "NodeGroupOutput") and here is not None:
            return idmaps.get(here, {}).get(ident, ident)
        return ident

    by_name = {nd["name"]: nd for nd in graph.get("nodes", [])}
    for nd in graph.get("nodes", []):
        try:
            n = tree.nodes.new(nd["type"])
        except RuntimeError:
            problems.append("unknown node type %s" % nd["type"])
            continue
        n.name = nd["name"]
        made[nd["name"]] = n
        n.label = nd.get("label", "")
        n.location = nd.get("location", [0, 0])
        if nd.get("width"):
            n.width = nd["width"]
        if nd.get("height") and nd["type"] == "NodeFrame":
            n.height = nd["height"]
        n.mute = bool(nd.get("mute", False))
        if nd["type"] == "ShaderNodeGroup":
            if nd.get("group") in trees:
                n.node_tree = trees[nd["group"]]
            else:
                problems.append("group %s not found" % nd.get("group"))
        props = nd.get("props", {})
        # enums first: data_type / operation decide which sockets exist
        for pid in sorted(props, key=lambda k: props[k].get("type") != "ENUM"):
            try:
                setattr(n, pid, props[pid]["value"])
            except (AttributeError, TypeError, ValueError) as exc:
                problems.append("%s.%s: %s" % (nd["name"], pid, exc))
        if "ramp" in nd and n.bl_idname == "ShaderNodeValToRGB":
            cr = n.color_ramp
            cr.interpolation = nd["ramp"].get("interpolation", "LINEAR")
            els = sorted(nd["ramp"]["elements"], key=lambda e: e[0]) or [[0, [0, 0, 0, 1]]]
            while len(cr.elements) > 1:
                cr.elements.remove(cr.elements[-1])
            cr.elements[0].position = els[0][0]
            cr.elements[0].color = (list(els[0][1]) + [1.0])[:4]
            for pos, col in els[1:]:
                e = cr.elements.new(pos)
                e.color = (list(col) + [1.0])[:4]
        if nd.get("image") and n.bl_idname == "ShaderNodeTexImage":
            try:
                n.image = bpy.data.images.load(nd["image"], check_existing=True)
            except RuntimeError:
                problems.append("image not found: %s" % nd["image"])
        # inputs, and outputs too: Value and RGB nodes keep their number / colour on the output
        for sd, s in ([(sd, _find(n.inputs, sid(nd, sd["id"]))) for sd in nd.get("inputs", [])] +
                      [(sd, _find(n.outputs, sid(nd, sd["id"]))) for sd in nd.get("outputs", [])]):
            if s is None or "value" not in sd or not hasattr(s, "default_value"):
                continue
            try:
                v = sd["value"]
                cur = s.default_value
                if hasattr(cur, "__len__") and not isinstance(cur, str):
                    v = (list(v) + list(cur)[len(v):])[:len(cur)]
                s.default_value = v
            except (TypeError, ValueError, AttributeError) as exc:
                problems.append("%s.%s: %s" % (nd["name"], sd["id"], exc))
    # frames: parent after every node exists, then put each node back where it was drawn
    for nd in graph.get("nodes", []):
        n = made.get(nd["name"])
        if n is None:
            continue
        if nd.get("parent") in made:
            n.parent = made[nd["parent"]]
        if hasattr(n, "location_absolute"):
            n.location_absolute = nd.get("location", [0, 0])
    for a, ao, b, bi in graph.get("links", []):
        na, nb = made.get(a), made.get(b)
        so = _find(na.outputs, sid(by_name[a], ao)) if na else None
        si = _find(nb.inputs, sid(by_name[b], bi)) if nb else None
        if so is None or si is None:
            problems.append("link %s.%s -> %s.%s skipped" % (a, ao, b, bi))
            continue
        tree.links.new(so, si)


def build_tree(tree, graph, prefix=None):
    """Rebuild `tree` (and its node groups) from a dumped/edited graph.

    Groups are created first (pass 1: datablock + interface), then their insides, then
    the main tree. Blender names group sockets itself, so ids from Maya are mapped.
    """
    problems = []
    prefix = prefix if prefix is not None else "%s::" % (tree.id_data.name if tree.id_data else "tb")
    trees, idmaps = _build_groups(graph.get("groups"), prefix, problems)
    for gname, gd in (graph.get("groups") or {}).items():
        if gd and gname in trees:
            _build_level(trees[gname], gd, trees, idmaps, gname, problems)
    _build_level(tree, graph, trees, idmaps, None, problems)
    return problems


def build_material(name, graph):
    mat = bpy.data.materials.get(name) or bpy.data.materials.new(name)
    mat.use_nodes = True
    mat.use_fake_user = True
    problems = build_tree(mat.node_tree, graph)
    for p in problems:
        print("TOONBRIDGE WARN graph", name, p, flush=True)
    return mat


def material_for(name, look):
    """The material a look renders with.

    A look with a saved full node graph ("graph", edited in Maya's node editor) is
    rebuilt from that graph; otherwise the template builder makes it from its settings.
    """
    import toon_materials as tm
    if look.get("graph"):
        return build_material(name, look["graph"])
    return tm.build_look(name, look)
