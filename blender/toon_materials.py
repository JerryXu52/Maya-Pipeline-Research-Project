"""Builds toon materials from a looks.json entry. Runs inside Blender (bpy).

The node tree for one look:

    Diffuse BSDF -> Shader to RGB -> Color Ramp (Constant)  = band multiplier
    base colour (Maya colour attribute or a fixed RGB)      x band multiplier
    + Glossy BSDF -> Shader to RGB -> > threshold           = hard specular
    + Layer Weight (facing) -> > threshold                  = rim
    -> Emission -> Material Output

Shader to RGB only exists in EEVEE: it turns the lit result into plain colour
so we can posterize it. Everything after it is ordinary maths, and Emission
outputs that colour exactly (the scene uses the Standard view transform).
"""
import bpy

COLOR_ATTR = "tb_color"   # per-object custom property written by render.py


def _vmath(nodes, op, x, y_loc):
    n = nodes.new("ShaderNodeVectorMath")
    n.operation = op
    n.location = (x, y_loc)
    return n


def _gt_mask(nodes, links, src_socket, threshold, x, y):
    """Float mask: 1 where src > threshold, else 0 (a hard toon edge)."""
    m = nodes.new("ShaderNodeMath")
    m.operation = "GREATER_THAN"
    m.inputs[1].default_value = threshold
    m.location = (x, y)
    links.new(src_socket, m.inputs[0])
    return m.outputs[0]


def _rgba(c):
    return (c[0], c[1], c[2], 1.0)


def build_look(name, look):
    """One EEVEE node tree for any look (see toon_bridge/lookdefs.py for the template).

    Every node gets a readable name and label (TB ...), so the tree is easy to
    follow when it is opened in Blender's node editor.
    """
    import math
    from toon_bridge import lookdefs
    lk = lookdefs.normalize(look)
    mat = bpy.data.materials.get(name) or bpy.data.materials.new(name)
    mat.use_nodes = True
    mat.use_fake_user = True
    nodes, links = mat.node_tree.nodes, mat.node_tree.links
    nodes.clear()

    def node(kind, label, x, y):
        n = nodes.new(kind)
        n.name = n.label = label
        n.location = (x, y)
        return n

    def mix(fac, a, b, label, x, y):
        m = node("ShaderNodeMix", label, x, y)
        m.data_type = "RGBA"
        links.new(fac, m.inputs["Factor"])
        if isinstance(a, (list, tuple)):
            m.inputs[6].default_value = _rgba(a)
        else:
            links.new(a, m.inputs[6])
        if isinstance(b, (list, tuple)):
            m.inputs[7].default_value = _rgba(b)
        else:
            links.new(b, m.inputs[7])
        return m.outputs[2]

    def screen_xy():
        """Window coordinates, aspect-corrected (render.py sets TB Aspect)."""
        tc = node("ShaderNodeTexCoord", "TB Screen", -1500, -500)
        sep = node("ShaderNodeSeparateXYZ", "TB Screen XYZ", -1300, -500)
        links.new(tc.outputs["Window"], sep.inputs[0])
        asp = node("ShaderNodeValue", "TB_Aspect", -1500, -720)
        asp.outputs[0].default_value = 16.0 / 9.0
        x = _math(nodes, links, "MULTIPLY", sep.outputs["X"], asp.outputs[0], (-1100, -500))
        return x, sep.outputs["Y"]

    def rotated(x, y, angle_deg, freq, xloc, yloc):
        a = math.radians(angle_deg)
        ca, sa = math.cos(a), math.sin(a)
        u = _math(nodes, links, "ADD", _math(nodes, links, "MULTIPLY", x, ca * freq, (xloc, yloc)),
                  _math(nodes, links, "MULTIPLY", y, sa * freq, (xloc, yloc - 60)), (xloc + 180, yloc))
        v = _math(nodes, links, "ADD", _math(nodes, links, "MULTIPLY", x, -sa * freq, (xloc, yloc - 140)),
                  _math(nodes, links, "MULTIPLY", y, ca * freq, (xloc, yloc - 200)), (xloc + 180, yloc - 140))
        return u, v

    out = node("ShaderNodeOutputMaterial", "TB Output", 2600, 0)
    emit = node("ShaderNodeEmission", "TB Emission", 2400, 0)
    links.new(emit.outputs[0], out.inputs["Surface"])

    # light value L
    diff = node("ShaderNodeBsdfDiffuse", "TB Light", -1500, 300)
    diff.inputs["Color"].default_value = (1, 1, 1, 1)
    s2 = node("ShaderNodeShaderToRGB", "TB Shader to RGB", -1300, 300)
    links.new(diff.outputs[0], s2.inputs[0])
    bw = node("ShaderNodeRGBToBW", "TB Light value", -1100, 300)
    links.new(s2.outputs["Color"], bw.inputs[0])
    L = bw.outputs[0]

    # bands
    ramp = node("ShaderNodeValToRGB", "TB Bands", -800, 300)
    cr = ramp.color_ramp
    cr.interpolation = "CONSTANT"
    bands = lk["bands"]
    while len(cr.elements) > 1:
        cr.elements.remove(cr.elements[-1])
    cr.elements[0].position = bands[0][0]
    cr.elements[0].color = _rgba(bands[0][1])
    for pos, col in bands[1:]:
        e = cr.elements.new(pos)
        e.color = _rgba(col)
    links.new(L, ramp.inputs["Fac"])

    # base colour x bands
    if lk["base_color"] == "maya":
        base = node("ShaderNodeAttribute", "TB Base colour", -800, 560)
        base.attribute_type = "OBJECT"
        base.attribute_name = COLOR_ATTR
        base_sock = base.outputs["Color"]
    else:
        base = node("ShaderNodeRGB", "TB Base colour", -800, 560)
        base.outputs[0].default_value = _rgba(lk["base_color"])
        base_sock = base.outputs[0]
    mul = node("ShaderNodeVectorMath", "TB Base x Bands", -500, 400)
    mul.operation = "MULTIPLY"
    links.new(base_sock, mul.inputs[0])
    links.new(ramp.outputs["Color"], mul.inputs[1])

    sat = node("ShaderNodeHueSaturation", "TB Saturation", -300, 400)
    sat.inputs["Saturation"].default_value = lk["saturation"]
    links.new(mul.outputs[0], sat.inputs["Color"])
    result = sat.outputs[0]

    sp = lk["specular"]
    if sp.get("enabled"):
        gl = node("ShaderNodeBsdfGlossy", "TB Specular light", -800, 0)
        gl.inputs["Roughness"].default_value = sp["roughness"]
        s3 = node("ShaderNodeShaderToRGB", "TB Specular to RGB", -600, 0)
        links.new(gl.outputs[0], s3.inputs[0])
        mask = _gt_mask(nodes, links, s3.outputs["Color"], sp["threshold"], -400, 0)
        sc = node("ShaderNodeVectorMath", "TB Specular colour", -200, 0)
        sc.operation = "MULTIPLY"
        sc.inputs[0].default_value = sp["color"]
        links.new(mask, sc.inputs[1])
        add = node("ShaderNodeVectorMath", "TB Specular", 100, 300)
        add.operation = "ADD"
        links.new(result, add.inputs[0])
        links.new(sc.outputs[0], add.inputs[1])
        result = add.outputs[0]

    ht, hc = lk["halftone"], lk["hatching"]
    if ht.get("enabled") or hc.get("enabled"):
        x, y = screen_xy()
    if ht.get("enabled"):
        u, v = rotated(x, y, ht.get("angle", 45.0), ht["per_screen"], -900, -300)
        fu = _math(nodes, links, "SUBTRACT", _math(nodes, links, "FRACT", u, None, (-500, -300)), 0.5, (-300, -300))
        fv = _math(nodes, links, "SUBTRACT", _math(nodes, links, "FRACT", v, None, (-500, -440)), 0.5, (-300, -440))
        dist = _math(nodes, links, "SQRT", _math(nodes, links, "ADD",
                     _math(nodes, links, "MULTIPLY", fu, fu, (-100, -300)),
                     _math(nodes, links, "MULTIPLY", fv, fv, (-100, -440)), (100, -360)), None, (300, -360))
        lo = max(ht["below"], 1e-4)
        t = _math(nodes, links, "MAXIMUM", _math(nodes, links, "DIVIDE",
                  _math(nodes, links, "SUBTRACT", lo, L, (-500, -160)), lo, (-300, -160)), 0.0, (-100, -160))
        radius = _math(nodes, links, "MULTIPLY", t, ht["max_dot"], (100, -160))
        dots = _math(nodes, links, "LESS_THAN", dist, radius, (500, -200))
        if ht.get("color"):
            dot_col = list(ht["color"])
        else:
            dm = node("ShaderNodeVectorMath", "TB Dot colour", 500, 100)
            dm.operation = "SCALE"
            links.new(result, dm.inputs[0])
            dm.inputs["Scale"].default_value = ht.get("darken", 0.35)
            dot_col = dm.outputs[0]
        result = mix(dots, result, dot_col, "TB Halftone", 800, 300)
    if hc.get("enabled"):
        u, _v = rotated(x, y, hc.get("angle", -45.0), hc["per_screen"], -900, -800)
        stripe = _math(nodes, links, "LESS_THAN", _math(nodes, links, "FRACT", u, None, (-500, -800)),
                       hc["width"], (-300, -800))
        deep = _math(nodes, links, "LESS_THAN", L, hc["below"], (-300, -940))
        hatch = _math(nodes, links, "MULTIPLY", stripe, deep, (500, -800))
        result = mix(hatch, result, list(hc["color"]), "TB Hatching", 1100, 300)

    rim = lk["rim"]
    if rim.get("enabled"):
        lw = node("ShaderNodeLayerWeight", "TB Rim facing", 1100, -300)
        lw.inputs["Blend"].default_value = 0.5 if rim.get("mode", "add") == "add" else 0.45
        edge = _gt_mask(nodes, links, lw.outputs["Facing"], rim["threshold"], 1300, -300)
        if rim.get("mode", "add") == "add":
            rc = node("ShaderNodeVectorMath", "TB Rim colour", 1500, -300)
            rc.operation = "MULTIPLY"
            rc.inputs[0].default_value = rim["color"]
            links.new(edge, rc.inputs[1])
            add = node("ShaderNodeVectorMath", "TB Rim light", 1800, 300)
            add.operation = "ADD"
            links.new(result, add.inputs[0])
            links.new(rc.outputs[0], add.inputs[1])
            result = add.outputs[0]
        else:
            result = mix(edge, result, list(rim["color"]), "TB Rim light", 1800, 300)

    links.new(result, emit.inputs["Color"])
    return mat


def build_outline(name, look):
    """Inverted-hull outline material: a black-ish shell seen only from inside.

    render.py adds a Solidify modifier with flipped normals that uses this
    material. Backface culling hides the shell's front faces, so only the rim
    of the shell sticking out past the silhouette is visible = the ink line.
    """
    from toon_bridge import lookdefs
    o = lookdefs.normalize(look)["outline"]
    if not o.get("enabled"):
        return None
    mname = name + "__outline"
    mat = bpy.data.materials.get(mname) or bpy.data.materials.new(mname)
    mat.use_nodes = True
    mat.use_fake_user = True
    mat.use_backface_culling = True
    nodes, links = mat.node_tree.nodes, mat.node_tree.links
    nodes.clear()
    # The shell must not cast shadows, or it shadows the object it wraps
    # (blocky self-shadowing on the lit side). Shadow rays see it as fully
    # transparent; camera rays see the ink colour.
    mat.use_backface_culling_shadow = True
    mat.use_transparent_shadow = True
    em = nodes.new("ShaderNodeEmission")
    em.inputs["Color"].default_value = (*o.get("color", [0, 0, 0]), 1)
    tr = nodes.new("ShaderNodeBsdfTransparent")
    lp = nodes.new("ShaderNodeLightPath")
    lp.location = (-200, 200)
    mix = nodes.new("ShaderNodeMixShader")
    mix.location = (200, 0)
    links.new(lp.outputs["Is Shadow Ray"], mix.inputs[0])
    links.new(em.outputs[0], mix.inputs[1])
    links.new(tr.outputs[0], mix.inputs[2])
    out = nodes.new("ShaderNodeOutputMaterial")
    out.location = (400, 0)
    links.new(mix.outputs[0], out.inputs["Surface"])
    return mat


def add_outline(obj, outline_mat, width_m):
    """Inverted hull: Solidify shell with flipped normals, using the outline material.

    Solidify thickness is in the object's local units. Alembic meshes come in
    with object scale 0.01 (cm -> m), so convert the world width back to local.
    """
    if outline_mat is None:
        return
    scale = max(obj.matrix_world.to_scale().x, 1e-6)
    obj.data.materials.append(outline_mat)
    mod = obj.modifiers.new("ToonOutline", "SOLIDIFY")
    mod.thickness = width_m / scale
    mod.offset = 1.0                 # grow outwards from the surface
    mod.use_flip_normals = True      # the shell faces inwards
    mod.use_even_offset = True
    mod.use_rim = False
    mod.material_offset = len(obj.data.materials) - 1
    mod.material_offset_rim = len(obj.data.materials) - 1


def setup_render(scene, width, height, samples=16, transparent=False):
    """EEVEE + Standard view transform so emission colours come out exactly."""
    scene.render.engine = "BLENDER_EEVEE"
    scene.render.resolution_x = int(width)
    scene.render.resolution_y = int(height)
    scene.render.resolution_percentage = 100
    scene.render.film_transparent = transparent
    scene.render.image_settings.file_format = "PNG"
    scene.render.image_settings.color_mode = "RGBA" if transparent else "RGB"
    scene.view_settings.view_transform = "Standard"
    scene.view_settings.look = "None"
    ee = scene.eevee
    ee.taa_render_samples = samples
    # Toon bands come from Shader to RGB, which sees every lighting sample.
    # Stochastic effects (ray-traced GI, horizon scan, soft-shadow rays) make
    # the band edges grainy, so turn them off: a clean, hard light is the goal.
    ee.use_raytracing = False
    ee.use_fast_gi = False
    ee.shadow_ray_count = 1
    ee.shadow_resolution_scale = 1.0


def toon_light(light_data):
    """Hard, crisp shadow settings for a toon key light."""
    light_data.use_shadow = True
    light_data.use_shadow_jitter = False
    light_data.shadow_filter_radius = 0.5
    light_data.shadow_maximum_resolution = 0.001
    if light_data.type == "SUN":
        light_data.angle = 0.0
    else:
        light_data.shadow_soft_size = 0.0


def setup_world(scene, background, ambient):
    """Camera sees `background`; lighting gets a small `ambient` fill.

    The Light Path node separates the two, so the backdrop colour does not
    brighten the shadow bands.
    """
    world = bpy.data.worlds.get("ToonWorld") or bpy.data.worlds.new("ToonWorld")
    scene.world = world
    world.use_nodes = True
    nodes, links = world.node_tree.nodes, world.node_tree.links
    nodes.clear()
    lp = nodes.new("ShaderNodeLightPath")
    bg_cam = nodes.new("ShaderNodeBackground")
    bg_cam.inputs["Color"].default_value = (*background, 1)
    bg_amb = nodes.new("ShaderNodeBackground")
    bg_amb.inputs["Color"].default_value = (*ambient, 1)
    mix = nodes.new("ShaderNodeMixShader")
    out = nodes.new("ShaderNodeOutputWorld")
    links.new(lp.outputs["Is Camera Ray"], mix.inputs[0])
    links.new(bg_amb.outputs[0], mix.inputs[1])
    links.new(bg_cam.outputs[0], mix.inputs[2])
    links.new(mix.outputs[0], out.inputs["Surface"])


def setup_ink_lines(scene, view_layer, color=(0.07, 0.05, 0.09), outer_px=2.6, inner_px=1.3,
                    crease_deg=50.0):
    """2D ink lines with Freestyle: constant width on screen, like a hand-drawn line.

    The inverted hull is a 3D shell, so its line gets thinner with distance
    and never draws inside the silhouette. Freestyle finds edges in the image
    instead and draws strokes of a fixed pixel width:
      outer line : silhouettes, external contour, open borders  (thick)
      inner line : creases sharper than `crease_deg`            (thin)
    """
    import math
    r = scene.render
    r.use_freestyle = True
    r.line_thickness_mode = "ABSOLUTE"
    r.line_thickness = 1.0
    fs = view_layer.freestyle_settings
    fs.mode = "EDITOR"
    fs.crease_angle = math.radians(crease_deg)
    fs.use_smoothness = True
    fs.use_culling = False
    while len(fs.linesets):
        fs.linesets.remove(fs.linesets[0])

    def lineset(name, px, **edges):
        ls = fs.linesets.new(name)
        ls.select_by_visibility = True
        ls.visibility = "VISIBLE"
        ls.select_by_edge_types = True
        for attr in ("select_silhouette", "select_border", "select_crease", "select_contour",
                     "select_external_contour", "select_material_boundary", "select_ridge_valley",
                     "select_suggestive_contour", "select_edge_mark"):
            setattr(ls, attr, edges.get(attr, False))
        st = ls.linestyle
        st.name = "Toon_" + name
        st.color = color
        st.thickness = px * scene.render.resolution_percentage / 100.0
        st.thickness_position = "CENTER"
        st.caps = "ROUND"
        st.use_chaining = True
        return ls

    lineset("outer", outer_px, select_silhouette=True, select_external_contour=True,
            select_border=True, select_contour=True)
    lineset("inner", inner_px, select_crease=True, select_material_boundary=True)


# ---------------------------------------------------------------- pop art / comic halftone
def _math(nodes, links, op, a, b=None, loc=(0, 0)):
    n = nodes.new("ShaderNodeMath")
    n.operation = op
    n.location = loc
    for i, v in enumerate((a, b)):
        if v is None:
            continue
        if isinstance(v, (int, float)):
            n.inputs[i].default_value = v
        else:
            links.new(v, n.inputs[i])
    return n.outputs[0]


def set_aspect(aspect):
    for m in bpy.data.materials:
        if m.node_tree and "TB_Aspect" in m.node_tree.nodes:
            m.node_tree.nodes["TB_Aspect"].outputs[0].default_value = aspect


def misregister(path, px):
    """Offset red right/down and blue left/up by `px`: the off-register look of cheap print."""
    import numpy as np
    img = bpy.data.images.load(path, check_existing=False)
    w, h = img.size
    a = np.empty(w * h * 4, dtype=np.float32)
    img.pixels.foreach_get(a)
    a = a.reshape(h, w, 4)
    out = a.copy()
    out[:, :, 0] = np.roll(np.roll(a[:, :, 0], px, axis=1), -px, axis=0)
    out[:, :, 2] = np.roll(np.roll(a[:, :, 2], -px, axis=1), px, axis=0)
    img.pixels.foreach_set(out.ravel())
    img.filepath_raw = path
    img.file_format = "PNG"
    img.save()
    bpy.data.images.remove(img)
