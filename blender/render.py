"""Render a shot exported from Maya with toon looks in EEVEE.

    blender -b --factory-startup --python blender/render.py -- <shot.json> [--frame N] [--preview]

Steps:
  1. import the Alembic cache Maya wrote (geometry + animation)
  2. append each look's material from look_library.blend and assign it by
     object name (names come from shot.json, written by toon_bridge/exporter.py)
  3. add inverted-hull outlines
  4. rebuild camera and lights from shot.json, one key per frame, using the
     conversion in toon_bridge/convert.py
  5. render each frame to PNG, printing TOONBRIDGE lines Maya reads for progress

The finished scene is also saved next to the frames as toon_shot.blend, so it
can be opened in Blender to inspect or tweak.
"""
import json
import math
import os
import sys
import time

import bpy
from mathutils import Matrix

HERE = os.path.dirname(os.path.abspath(__file__))
REPO = os.path.dirname(HERE)
sys.path.insert(0, HERE)
sys.path.insert(0, REPO)
import toon_materials as tm  # noqa: E402
from toon_bridge import convert  # noqa: E402

LIBRARY = os.path.join(HERE, "look_library.blend")
LOOKS_JSON = os.path.join(HERE, "looks.json")
DEFAULT_LOOK = "toon_auto"


def say(*parts):
    """Progress line for Maya (it scans stdout for the TOONBRIDGE prefix)."""
    print("TOONBRIDGE", *parts, flush=True)


def parse_args():
    argv = sys.argv[sys.argv.index("--") + 1:] if "--" in sys.argv else []
    if not argv:
        raise SystemExit("usage: render.py -- shot.json [--frame N] [--preview]")
    args = {"shot": os.path.abspath(argv[0]), "frame": None, "preview": "--preview" in argv,
            "no_render": "--no-render" in argv}
    if "--frame" in argv:
        args["frame"] = int(argv[argv.index("--frame") + 1])
    return args


def load_looks():
    with open(LOOKS_JSON) as f:
        return {k: v for k, v in json.load(f).items() if not k.startswith("_")}


def append_materials(names):
    """Append look materials (and their __outline partners) from the library."""
    wanted = set()
    for n in names:
        wanted.update([n, n + "__outline"])
    with bpy.data.libraries.load(LIBRARY, link=False) as (src, dst):
        dst.materials = [m for m in src.materials if m in wanted]
    return {m.name: m for m in dst.materials if m is not None}


def import_geometry(shot, shot_dir):
    abc = os.path.join(shot_dir, shot["alembic"])
    before = set(bpy.data.objects)
    # Alembic is Y-up; Blender's importer turns it Z-up. scale=0.01: cm -> m.
    bpy.ops.wm.alembic_import(filepath=abc, scale=convert.CM_TO_M, set_frame_range=False)
    return [o for o in bpy.data.objects if o not in before]


def apply_looks(shot, imported, looks, outlines_on, hull=True):
    by_name = {o["name"]: o for o in shot["objects"]}
    used = {by_name.get(ob.name, {}).get("look", DEFAULT_LOOK) for ob in imported if ob.type == "MESH"}
    used = {u if u in looks else DEFAULT_LOOK for u in used}
    mats = append_materials(used)
    scale = shot.get("settings", {}).get("outline_scale", 1.0)
    report = []
    for ob in imported:
        if ob.type != "MESH":
            continue
        info = by_name.get(ob.name, {})
        look = info.get("look", DEFAULT_LOOK)
        if look not in looks:
            say("WARN unknown look", look, "on", ob.name, "-> using", DEFAULT_LOOK)
            look = DEFAULT_LOOK
        ob[tm.COLOR_ATTR] = info.get("color", [0.8, 0.8, 0.8])
        ob.data.materials.clear()
        ob.data.materials.append(mats[look])
        # one material for every face (Alembic face sets would add more slots)
        for poly in ob.data.polygons:
            poly.material_index = 0
        width = looks[look].get("outline", {}).get("width_cm", 0) * convert.CM_TO_M * scale
        if outlines_on and hull and width > 0:
            tm.add_outline(ob, mats.get(look + "__outline"), width)
        report.append((ob.name, look))
    for name, look in sorted(report):
        say("LOOK", name, look)
    missing = set(by_name) - {n for n, _ in report}
    for name in sorted(missing):
        say("WARN not found in Alembic:", name)


def key_matrix(ob, rows, frame):
    ob.matrix_world = Matrix(rows)
    ob.keyframe_insert("location", frame=frame)
    ob.keyframe_insert("rotation_euler", frame=frame)


def build_camera(shot):
    c = shot["camera"]
    w, h = shot["resolution"]
    data = bpy.data.cameras.new(c["name"])
    cam = bpy.data.objects.new(c["name"], data)
    bpy.context.scene.collection.objects.link(cam)
    fit, sw, sh = convert.sensor(c["h_aperture"], c["v_aperture"], c["film_fit"], w, h)
    data.sensor_fit = fit
    data.sensor_width = sw
    data.sensor_height = sh
    data.clip_start, data.clip_end = convert.clip(c["near"], c["far"])
    for f, v in sorted(c["frames"].items(), key=lambda kv: int(kv[0])):
        key_matrix(cam, convert.matrix(v["matrix"]), int(f))
        data.lens = v["focal"]
        data.keyframe_insert("lens", frame=int(f))
    bpy.context.scene.camera = cam
    return cam


def build_lights(shot):
    ambient = [0.0, 0.0, 0.0]
    made = []
    for L in shot["lights"]:
        if L["type"] == "ambient":
            first = next(iter(L["frames"].values()))
            ambient = [a + c * first["intensity"] for a, c in zip(ambient, L["color"])]
            continue
        kind = {"directional": "SUN", "point": "POINT", "spot": "SPOT", "area": "AREA"}.get(L["type"])
        if kind is None:
            say("WARN skipped light", L["name"], L["type"])
            continue
        data = bpy.data.lights.new(L["name"], kind)
        data.color = L["color"]
        tm.toon_light(data)
        if kind == "SPOT":
            data.spot_size = math.radians(min(L.get("cone_deg", 40) + 2 * max(L.get("penumbra_deg", 0), 0), 180))
            data.spot_blend = 0.0
        ob = bpy.data.objects.new(L["name"], data)
        bpy.context.scene.collection.objects.link(ob)
        for f, v in sorted(L["frames"].items(), key=lambda kv: int(kv[0])):
            key_matrix(ob, convert.matrix(v["matrix"]), int(f))
            if kind == "SUN":
                data.energy = convert.sun_strength(v["intensity"])
            else:
                data.energy = convert.point_power(v["intensity"], L.get("decay", 0))
            data.keyframe_insert("energy", frame=int(f))
        made.append(ob)
        say("LIGHT", L["name"], kind)
    if not made:
        say("WARN no lights in shot: adding a default sun")
        data = bpy.data.lights.new("default_sun", "SUN")
        data.energy = math.pi
        tm.toon_light(data)
        ob = bpy.data.objects.new("default_sun", data)
        ob.rotation_euler = (math.radians(50), math.radians(10), math.radians(-35))
        bpy.context.scene.collection.objects.link(ob)
    return ambient


class DeformBaker(object):
    """Give Freestyle a plain mesh for every deforming Alembic object.

    Deforming meshes (skinned, blendshapes) are read by a Mesh Sequence Cache
    modifier. EEVEE shades them correctly, but Freestyle drew their lines from
    stale geometry (a ghost outline from another pose). So on each frame we
    evaluate the cache into an ordinary mesh, swap it in, and switch the cache
    off. Objects that only move (no cache modifier) are left alone.
    """

    def __init__(self, scene):
        self.scene = scene
        self.items = []
        for ob in scene.objects:
            if ob.type != "MESH":
                continue
            cache = next((m for m in ob.modifiers if m.type == "MESH_SEQUENCE_CACHE"), None)
            if cache:
                self.items.append((ob, cache, ob.data))
        if self.items:
            say("DEFORMING", len(self.items), "object(s) baked per frame for ink lines")

    def bake(self):
        for ob, cache, source in self.items:
            # evaluate the original cache-driven mesh, without outlines
            old = ob.data
            ob.data = source
            cache.show_viewport = True
            cache.show_render = True
            hull = [m for m in ob.modifiers if m.type == "SOLIDIFY"]
            for m in hull:
                m.show_viewport = False
            dg = bpy.context.evaluated_depsgraph_get()
            dg.update()
            baked = bpy.data.meshes.new_from_object(ob.evaluated_get(dg), preserve_all_data_layers=True,
                                                    depsgraph=dg)
            ob.data = baked
            cache.show_viewport = False
            cache.show_render = False
            for m in hull:
                m.show_viewport = True
            if old is not source:
                bpy.data.meshes.remove(old)
        bpy.context.view_layer.update()


def main():
    args = parse_args()
    t0 = time.time()
    with open(args["shot"]) as f:
        shot = json.load(f)
    shot_dir = os.path.dirname(args["shot"])
    st = shot.get("settings", {})
    looks = load_looks()

    bpy.ops.wm.read_factory_settings(use_empty=True)
    scene = bpy.context.scene
    scene.render.fps = int(round(shot.get("fps", 24)))

    imported = import_geometry(shot, shot_dir)
    say("IMPORTED", len(imported), "objects")
    line_mode = st.get("line_mode", "ink")       # ink | hull | both
    apply_looks(shot, imported, looks, st.get("outlines", True), hull=line_mode in ("hull", "both"))
    build_camera(shot)
    ambient = build_lights(shot)
    if not any(ambient):
        ambient = st.get("ambient", [0.04, 0.04, 0.05])

    w, h = shot["resolution"]
    samples = 4 if args["preview"] else st.get("samples", 16)
    tm.setup_render(scene, w, h, samples=samples, transparent=st.get("transparent", False))
    if args["preview"]:
        scene.render.resolution_percentage = 50
    tm.setup_world(scene, st.get("background", [0.92, 0.91, 0.87]), ambient)
    if st.get("outlines", True) and line_mode in ("ink", "both"):
        px = st.get("line_px", 2.6) * st.get("outline_scale", 1.0)
        tm.setup_ink_lines(scene, bpy.context.view_layer, color=st.get("line_color", [0.07, 0.05, 0.09]),
                           outer_px=px, inner_px=px * 0.5)
        say("LINES ink", px)

    if args["frame"] is not None:
        frames = [args["frame"]]
    else:
        frames = list(range(shot["frame_start"], shot["frame_end"] + 1))
    scene.frame_start, scene.frame_end = shot["frame_start"], shot["frame_end"]

    bpy.ops.wm.save_as_mainfile(filepath=os.path.join(shot_dir, "toon_shot.blend"))
    say("SETUP", "%.1fs" % (time.time() - t0))
    if args["no_render"]:
        return

    pattern = os.path.join(shot_dir, shot.get("output", "frames/toon.####.png"))
    os.makedirs(os.path.dirname(pattern), exist_ok=True)
    say("TOTAL", len(frames))
    baker = DeformBaker(scene) if scene.render.use_freestyle else None
    for i, f in enumerate(frames):
        scene.frame_set(f)
        if baker:
            baker.bake()
        path = pattern.replace("####", "%04d" % f)
        scene.render.filepath = path
        bpy.ops.render.render(write_still=True)
        say("FRAME", f, i + 1, len(frames), path)
    say("DONE", "%.1fs" % (time.time() - t0))


if __name__ == "__main__":
    try:
        main()
    except Exception as exc:  # make failures visible to Maya, then exit non-zero
        import traceback
        traceback.print_exc()
        say("ERROR", exc)
        sys.stdout.flush()
        os._exit(1)
