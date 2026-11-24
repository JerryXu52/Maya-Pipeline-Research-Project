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
    d = {"name": n.name, "type": n.bl_idname, "label": n.label, "title": n.bl_label,
         "location": [round(n.location.x, 1), round(n.location.y, 1)], "width": round(n.width, 1),
         "mute": bool(n.mute), "props": {}}
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


def dump_tree(tree):
    nodes = [dump_node(n) for n in tree.nodes]
    links = [[l.from_node.name, l.from_socket.identifier, l.to_node.name, l.to_socket.identifier]
             for l in tree.links if l.is_valid]
    return {"nodes": nodes, "links": links}


def _find(socks, ident):
    for s in socks:
        if s.identifier == ident:
            return s
    return None


def build_tree(tree, graph):
    """Rebuild `tree` from a dumped/edited graph. Unknown node types are skipped and reported."""
    tree.nodes.clear()
    made, problems = {}, []
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
        n.mute = bool(nd.get("mute", False))
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
        for sd, s in ([(sd, _find(n.inputs, sd["id"])) for sd in nd.get("inputs", [])] +
                      [(sd, _find(n.outputs, sd["id"])) for sd in nd.get("outputs", [])]):
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
    for a, ao, b, bi in graph.get("links", []):
        na, nb = made.get(a), made.get(b)
        so = _find(na.outputs, ao) if na else None
        si = _find(nb.inputs, bi) if nb else None
        if so is None or si is None:
            problems.append("link %s.%s -> %s.%s skipped" % (a, ao, b, bi))
            continue
        tree.links.new(so, si)
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
