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


def build_look(name, look):
    if look.get("type") == "pop":
        return build_pop_look(name, look)
    mat = bpy.data.materials.get(name) or bpy.data.materials.new(name)
    mat.use_nodes = True
    mat.use_fake_user = True
    nt = mat.node_tree
    nodes, links = nt.nodes, nt.links
    nodes.clear()

    out = nodes.new("ShaderNodeOutputMaterial")
    out.location = (1400, 0)
    emit = nodes.new("ShaderNodeEmission")
    emit.location = (1200, 0)
    links.new(emit.outputs[0], out.inputs["Surface"])

    # 1) light value -> bands
    diff = nodes.new("ShaderNodeBsdfDiffuse")
    diff.location = (-600, 200)
    diff.inputs["Color"].default_value = (1, 1, 1, 1)
    s2rgb = nodes.new("ShaderNodeShaderToRGB")
    s2rgb.location = (-400, 200)
    links.new(diff.outputs[0], s2rgb.inputs[0])
    ramp = nodes.new("ShaderNodeValToRGB")
    ramp.location = (-200, 200)
    ramp.label = "Toon bands"
    cr = ramp.color_ramp
    cr.interpolation = "CONSTANT"
    bands = look.get("bands", [[0.0, [1, 1, 1]]])
    while len(cr.elements) > 1:
        cr.elements.remove(cr.elements[-1])
    cr.elements[0].position = bands[0][0]
    cr.elements[0].color = (*bands[0][1], 1)
    for pos, col in bands[1:]:
        e = cr.elements.new(pos)
        e.color = (*col, 1)
    links.new(s2rgb.outputs["Color"], ramp.inputs["Fac"])

    # 2) base colour
    if look.get("base_color", "maya") == "maya":
        base = nodes.new("ShaderNodeAttribute")
        base.attribute_type = "OBJECT"
        base.attribute_name = COLOR_ATTR
        base.label = "Maya colour"
        base_socket = base.outputs["Color"]
    else:
        base = nodes.new("ShaderNodeRGB")
        base.outputs[0].default_value = (*look["base_color"], 1)
        base.label = "Base colour"
        base_socket = base.outputs[0]
    base.location = (-200, 450)

    mul = _vmath(nodes, "MULTIPLY", 100, 300)
    links.new(base_socket, mul.inputs[0])
    links.new(ramp.outputs["Color"], mul.inputs[1])
    result = mul.outputs[0]
    x = 300

    # 3) hard specular highlight
    spec = look.get("specular")
    if spec:
        gl = nodes.new("ShaderNodeBsdfGlossy")
        gl.location = (-600, -150)
        gl.inputs["Roughness"].default_value = spec.get("roughness", 0.3)
        s2 = nodes.new("ShaderNodeShaderToRGB")
        s2.location = (-400, -150)
        links.new(gl.outputs[0], s2.inputs[0])
        mask = _gt_mask(nodes, links, s2.outputs["Color"], spec.get("threshold", 0.5), -200, -150)
        sc = _vmath(nodes, "MULTIPLY", x, -150)
        sc.inputs[0].default_value = spec.get("color", [1, 1, 1])
        links.new(mask, sc.inputs[1])
        add = _vmath(nodes, "ADD", x + 200, 150)
        links.new(result, add.inputs[0])
        links.new(sc.outputs[0], add.inputs[1])
        result = add.outputs[0]
        x += 400

    # 4) rim light (silhouette edge, view dependent)
    rim = look.get("rim")
    if rim:
        lw = nodes.new("ShaderNodeLayerWeight")
        lw.location = (-400, -400)
        lw.inputs["Blend"].default_value = 0.5
        mask = _gt_mask(nodes, links, lw.outputs["Facing"], rim.get("threshold", 0.7), -200, -400)
        rc = _vmath(nodes, "MULTIPLY", x, -400)
        rc.inputs[0].default_value = rim.get("color", [0.3, 0.3, 0.3])
        links.new(mask, rc.inputs[1])
        add = _vmath(nodes, "ADD", x + 200, 100)
        links.new(result, add.inputs[0])
        links.new(rc.outputs[0], add.inputs[1])
        result = add.outputs[0]

    links.new(result, emit.inputs["Color"])
    return mat


def build_outline(name, look):
    """Inverted-hull outline material: a black-ish shell seen only from inside.

    render.py adds a Solidify modifier with flipped normals that uses this
    material. Backface culling hides the shell's front faces, so only the rim
    of the shell sticking out past the silhouette is visible = the ink line.
    """
    o = look.get("outline")
    if not o:
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


def build_pop_look(name, look):
    """Comic-book pop art: flat colour, halftone dots and hatching in the shadows.

    Everything is in SCREEN space (Texture Coordinate > Window), like a printed
    page: the dots stay the same size on screen while the object moves.

      light L   = Shader to RGB of a white diffuse (0 = dark, 1 = lit)
      dots      = 45-degree grid; dot radius grows as L gets darker
      hatching  = diagonal lines where L is below `hatch_below`
      colour    = base (posterized lit/shadow) -> ink dots -> ink hatching
    The node 'TB_Aspect' is set by render.py to width/height so dots are round.
    """
    mat = bpy.data.materials.get(name) or bpy.data.materials.new(name)
    mat.use_nodes = True
    mat.use_fake_user = True
    nodes, links = mat.node_tree.nodes, mat.node_tree.links
    nodes.clear()
    out = nodes.new("ShaderNodeOutputMaterial")
    out.location = (1800, 0)
    emit = nodes.new("ShaderNodeEmission")
    emit.location = (1600, 0)
    links.new(emit.outputs[0], out.inputs["Surface"])

    # light value
    diff = nodes.new("ShaderNodeBsdfDiffuse")
    diff.location = (-1200, 400)
    s2 = nodes.new("ShaderNodeShaderToRGB")
    s2.location = (-1000, 400)
    links.new(diff.outputs[0], s2.inputs[0])
    bw = nodes.new("ShaderNodeRGBToBW")
    bw.location = (-800, 400)
    links.new(s2.outputs["Color"], bw.inputs[0])
    L = bw.outputs[0]

    # screen coordinates, aspect-corrected, rotated 45 degrees
    tc = nodes.new("ShaderNodeTexCoord")
    tc.location = (-1400, -200)
    sep = nodes.new("ShaderNodeSeparateXYZ")
    sep.location = (-1200, -200)
    links.new(tc.outputs["Window"], sep.inputs[0])
    aspect = nodes.new("ShaderNodeValue")
    aspect.name = aspect.label = "TB_Aspect"
    aspect.outputs[0].default_value = 16.0 / 9.0
    aspect.location = (-1400, -450)
    x = _math(nodes, links, "MULTIPLY", sep.outputs["X"], aspect.outputs[0], (-1000, -200))
    y = sep.outputs["Y"]
    freq = look.get("dots_per_screen", 70.0)
    u = _math(nodes, links, "MULTIPLY", _math(nodes, links, "ADD", x, y, (-800, -150)), 0.7071 * freq, (-600, -150))
    v = _math(nodes, links, "MULTIPLY", _math(nodes, links, "SUBTRACT", y, x, (-800, -350)), 0.7071 * freq, (-600, -350))
    fu = _math(nodes, links, "SUBTRACT", _math(nodes, links, "FRACT", u, None, (-400, -150)), 0.5, (-200, -150))
    fv = _math(nodes, links, "SUBTRACT", _math(nodes, links, "FRACT", v, None, (-400, -350)), 0.5, (-200, -350))
    dist = _math(nodes, links, "SQRT", _math(nodes, links, "ADD",
                 _math(nodes, links, "MULTIPLY", fu, fu, (0, -150)),
                 _math(nodes, links, "MULTIPLY", fv, fv, (0, -350)), (200, -250)), None, (400, -250))

    # dot radius: 0 where lit (L >= dots_below), up to 0.72 (dots merge) where dark
    lo = look.get("dots_below", 0.75)
    t = _math(nodes, links, "DIVIDE", _math(nodes, links, "SUBTRACT", lo, L, (-600, 150)), lo, (-400, 150))
    t = _math(nodes, links, "MAXIMUM", t, 0.0, (-200, 150))
    radius = _math(nodes, links, "MULTIPLY", t, look.get("max_dot", 0.62), (0, 150))
    dots = _math(nodes, links, "LESS_THAN", dist, radius, (600, 0))

    # diagonal hatching in the deepest shadow
    hatch_f = look.get("hatch_per_screen", 110.0)
    hu = _math(nodes, links, "MULTIPLY", _math(nodes, links, "SUBTRACT", x, y, (-800, -600)), 0.7071 * hatch_f, (-600, -600))
    stripe = _math(nodes, links, "LESS_THAN", _math(nodes, links, "FRACT", hu, None, (-400, -600)),
                   look.get("hatch_width", 0.28), (-200, -600))
    deep = _math(nodes, links, "LESS_THAN", L, look.get("hatch_below", 0.18), (0, -600))
    hatch = _math(nodes, links, "MULTIPLY", stripe, deep, (600, -400))

    # base colour, posterized into lit / shadow
    if look.get("base_color", "maya") == "maya":
        base = nodes.new("ShaderNodeAttribute")
        base.attribute_type = "OBJECT"
        base.attribute_name = COLOR_ATTR
        base_sock = base.outputs["Color"]
    else:
        base = nodes.new("ShaderNodeRGB")
        base.outputs[0].default_value = (*look["base_color"], 1)
        base_sock = base.outputs[0]
    base.location = (200, 500)
    shade = nodes.new("ShaderNodeValToRGB")
    shade.location = (200, 300)
    shade.color_ramp.interpolation = "CONSTANT"
    shade.color_ramp.elements[0].position = 0.0
    shade.color_ramp.elements[0].color = (*look.get("shadow_mult", [0.78, 0.74, 0.92]), 1)
    shade.color_ramp.elements[1].position = look.get("lit_above", 0.45)
    shade.color_ramp.elements[1].color = (1, 1, 1, 1)
    links.new(L, shade.inputs["Fac"])
    col = nodes.new("ShaderNodeVectorMath")
    col.operation = "MULTIPLY"
    col.location = (600, 400)
    links.new(base_sock, col.inputs[0])
    links.new(shade.outputs["Color"], col.inputs[1])
    # saturate: push away from grey for the printed-ink punch
    sat = nodes.new("ShaderNodeHueSaturation")
    sat.location = (800, 400)
    sat.inputs["Saturation"].default_value = look.get("saturation", 1.35)
    links.new(col.outputs[0], sat.inputs["Color"])

    ink_dot = look.get("dot_color")          # None = darker version of the base
    if ink_dot:
        dot_col = nodes.new("ShaderNodeRGB")
        dot_col.outputs[0].default_value = (*ink_dot, 1)
        dot_sock = dot_col.outputs[0]
        dot_col.location = (800, 150)
    else:
        dm = nodes.new("ShaderNodeVectorMath")
        dm.operation = "SCALE"
        dm.location = (800, 150)
        links.new(sat.outputs[0], dm.inputs[0])
        dm.inputs["Scale"].default_value = 0.35
        dot_sock = dm.outputs[0]
    mix_d = nodes.new("ShaderNodeMix")
    mix_d.data_type = "RGBA"
    mix_d.location = (1100, 300)
    links.new(dots, mix_d.inputs["Factor"])
    links.new(sat.outputs[0], mix_d.inputs[6])
    links.new(dot_sock, mix_d.inputs[7])
    hatch_col = look.get("hatch_color", [0.06, 0.04, 0.12])
    mix_h = nodes.new("ShaderNodeMix")
    mix_h.data_type = "RGBA"
    mix_h.location = (1350, 300)
    links.new(hatch, mix_h.inputs["Factor"])
    links.new(mix_d.outputs[2], mix_h.inputs[6])
    mix_h.inputs[7].default_value = (*hatch_col, 1)
    links.new(mix_h.outputs[2], emit.inputs["Color"])
    return mat


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
