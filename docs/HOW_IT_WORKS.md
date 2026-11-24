# How Toon Bridge works

A walk through every part, in the order the data flows. Each section says
**what** the code does and **why** it does it that way.

```
 MAYA (toon_bridge/)                          BLENDER, headless (blender/)
 ──────────────────────────────               ─────────────────────────────────
 ui.py        panel: looks, shot, pre-flight, render, result viewer
 looks.py     toonLook tag on each mesh  ─┐
 preflight.py checks before sending        │
 exporter.py  scene.abc  (geometry+anim) ──┼──►  render.py
              shot.json  (camera, lights,  │       1 import scene.abc (scale 0.01, Z-up)
                          looks, colours) ─┘       2 append looks from look_library.blend
 launcher.py  blender -b --python render.py        3 Solidify outlines
              (QProcess, reads progress)  ◄──      4 camera + lights from shot.json via convert.py
                                                   5 EEVEE render -> frames/toon.####.png
 convert.py   shared maths (Maya -> Blender), used by render.py and the tests
```

## 0. The plug-in and the panel (`plug-ins/toonBridge.py`, `toon_bridge/menu.py`, `toon_bridge/ui.py`)

* **Install:** `drag_into_maya.py` writes a Maya *module* file (`toonBridge.mod`) into the
  user's modules folder. It tells Maya to add this repo to Python's path and its
  `plug-ins/` folder to the plug-in path, so the plug-in shows up in the Plug-in Manager
  on every start. The installer also loads it now and ticks *Auto load*.
* **The plug-in** (Python API 2.0) registers one command, `toonBridge`
  (`-open`, `-renderFrame`, `-renderShot`, `-style`), and builds the **Toon Bridge** menu.
  Maya runs plug-in files without `__file__`, so it finds its repo with `MFnPlugin.loadPath()`.
  Unloading closes the panel and removes the menu.
* **The panel** has three steps. **Style** (`styles.py`): a style maps object *roles* to
  looks and sets the render options; roles come from object names (`head` → skin,
  `eye` → eyes, `ground/floor/roof` → ground). The style is saved on
  `defaultRenderGlobals.toonStyle`, the background on `.toonBackground`.
  **Check** reruns pre-flight after every change; **Fix all** applies fixes in one undo chunk,
  looping because a fix can uncover the next issue. **Render** runs the check, offers to fix,
  exports, and starts Blender with `QProcess`.
* **Result:** a `timeChanged` scriptJob makes the player follow the Maya timeline.
  *Show in viewport* creates an image plane on the render camera with *Use Image Sequence*
  on, placed just past the near clip, so the toon frames are scrubbed in the viewport.
  *Export MP4* runs `blender/encode_video.py` (image strip in Blender's Video Sequencer → H.264).
* The style-card pictures are rendered by Blender (`blender/style_thumbs.py`) from the real looks.

## 0b. The Look Editor (`toon_bridge/look_editor.py`, `toon_bridge/lookdefs.py`)

* **One template for every look** (`lookdefs.py`, pure Python): Light → Shader to RGB →
  L (how lit) → Bands (Constant Color Ramp) × Base Colour → Saturation → Specular →
  Halftone → Hatching → Rim → Emission, plus an Outline on the object. Optional nodes have
  `enabled`. `normalize()` fills in defaults and converts the older cel / pop formats;
  `compact()` writes only what's switched on, so `looks.json` stays readable.
* **One builder** (`build_look` in `blender/toon_materials.py`) turns any look into that
  node tree, with every node named `TB …` so it reads well in Blender. It replaced the two
  separate cel and pop builders; the look sheet before and after differs by 39.6 dB PSNR
  (visually identical).
* **Renders build materials from the look data** (`materials_for` in `render.py`), so a
  saved edit is used on the next render with no rebuild. A look with
  `"source": "blend"` uses the material hand-edited in `look_library.blend` instead.
* **The editor** draws the graph with `QGraphicsView` (nodes are items; wires are painted
  in `drawBackground`, because Qt deleted separate wire items once Maya re-parented the
  window). Clicking a node fills the inspector; edits go into the look dict and start a
  350 ms timer, so a preview renders when you stop dragging. A newer edit during a render
  queues one more render.
* **Preview:** *Swatch* runs `blender/preview_look.py` (sphere, ring, neutral floor) in
  about 0.7 s. *This frame* writes the unsaved looks to a temp file, exports the current
  frame with `looks_file` set in `shot.json`, and renders it like a normal render. It runs
  the scene check first, because Alembic cannot export duplicate names.

## 0c. The full node graph (`blender/node_graph.py`, `toon_bridge/graph_editor.py`)

* **Node tree ↔ JSON** (`node_graph.py`, runs in Blender): `dump_tree` writes every node
  (type, name, label, position, width, mute), its own settings (found as the node's RNA
  properties minus the common `ShaderNode` ones, so it works for any node type, with enum
  choices included), Color Ramp stops, image path, and every socket (identifier, type,
  enabled, value). Links use socket *identifiers*, because a Mix node has several inputs
  named "A". `build_tree` rebuilds it: enum settings first (they decide which sockets exist),
  then values (Value and RGB nodes keep theirs on the *output*), then links. Every library
  look round-trips to identical JSON (`tests/graph_roundtrip_blender.py`).
* **Sync** (`graph_sync.py`): after each change Maya sends the look, Blender rebuilds it,
  dumps it again and renders the preview swatch, in one run (~0.75 s). Maya replaces its
  copy with Blender's version only if no newer edit happened meanwhile (a version counter),
  so Blender has the final word on which sockets exist.
* **Maya side**: `graph_model.py` holds the editing rules as plain data (tested without Qt);
  `graph_editor.py` draws Blender-style nodes (outputs, settings, inputs; socket colours from
  Blender), paints wires in `drawBackground`, and handles dragging wires, the add-node menu
  (from `node_catalog.json`, generated by Blender), undo/redo, zoom and pan. The inspector
  builds a field for every setting and unlinked input of the selected node.
* **Rendering**: a look with a `graph` is built by `node_graph.material_for` from that graph;
  otherwise by the template builder.
* **Node groups** live in `graph["groups"]` as `{interface, nodes, links}`; a group node
  names its group. Blender builds every group datablock and interface first, then their
  insides, then the material. Blender names group sockets itself (`Socket_0`, …), so ids
  coming from Maya are mapped. Datablocks are named per look internally (`<material>::<group>`)
  so two looks can each have a "NodeGroup"; the dump reports the look's own name.
  `graph_model.make_group` turns crossing wires into group sockets; `ungroup` is its inverse
  (tested: group then ungroup restores the exact wiring).
* **Frames** are nodes others point to with `parent`; positions are absolute
  (`location_absolute`), so moving in and out of frames never shifts a node. **Reroutes** are
  `NodeReroute` nodes with sockets `Input` / `Output`.
* **On-node editing**: a press on a value field starts a scrub (0.01 per pixel, Shift for
  0.001); a press without movement opens a line edit over the field. Typed maths goes through
  a tiny `ast` calculator (numbers and + − × ÷ only, never `eval`).
* **Layout**: Blender's template graph comes with overlapping positions, so the first time it
  is shown `graph_model.auto_layout` puts nodes in columns by distance from the output,
  ordered by where their wires go, spaced by each node's drawn height.

## 1. Tagging looks (`toon_bridge/looks.py`)

* A look is a string attribute `toonLook` on the mesh's **transform**.
  A string survives save/reload and references, and it is easy to query.
* `mesh_transforms()` finds visible, non-intermediate meshes. Intermediate
  shapes are the "orig" meshes skinning leaves behind, so they are skipped.
* `object_color()` reads the colour of the Maya shader (Lambert/Blinn/
  standardSurface/aiStandardSurface/openPBR). The `toon_auto`, `cel_hard`,
  etc. looks keep this colour, so an artist does not have to recolour anything.
  Textured shaders fall back to grey: a toon look uses one flat colour.
* `object_texture()` finds the colour map feeding the shader colour (through
  colour-correct/composite nodes). If the shader type is unknown (an Arnold
  shader without Arnold installed), it searches everything upstream and picks
  the map whose name looks like a colour map (diffuse/base/albedo), skipping
  normal/gloss/mask maps. In Blender, `textured_copy()` swaps the look's
  "Maya colour" node for an Image Texture; pop looks posterize it (Vector Math > Snap).
* **Viewport preview**: `preview_on()` swaps each tagged mesh to a Maya
  `rampShader` (input = Brightness, interpolation = None). That is Maya's
  nearest thing to Shader to RGB + a Constant ramp, so the viewport shows the
  bands roughly. The original shading group is stored in `toonOrigSG`, and
  `preview_off()` puts it back. The exporter reads the colour from the original
  shader even while the preview is on.

## 2. Pre-flight (`toon_bridge/preflight.py`)

This is Idea 2 from the proposal, kept to what the bridge needs. Each check
returns `Result(status, summary, nodes, fix)`:

| Check | Why the bridge needs it | Fix |
|---|---|---|
| Blender found | nothing works without it | set path in panel |
| Render camera | persp is usually a mistake | - |
| Unique object names | looks are re-applied in Blender **by name** | rename with suffix (skips referenced nodes) |
| Looks assigned | unknown look = error; untagged = uses toon_auto | tag as toon_auto |
| No negative scale | mirrored meshes flip normals, so the inverted-hull outline turns inside out | select only (freezing a rig is not safe) |
| Key light | Blender needs a sun; Arnold lights are not converted | add a directional light |
| Flat colours | textures are not sent | - |

Fixes are wrapped in one undo chunk in the UI, so one Ctrl+Z undoes a fix.

## 3. Export (`toon_bridge/exporter.py`)

Two files go into the shot folder:

* **`scene.abc`**: `AbcExport -worldSpace -uvWrite -writeVisibility -stripNamespaces`.
  Alembic stores the **evaluated** mesh on every frame, so skinned, blendshaped
  or deformed meshes come across exactly, without Blender knowing about the rig.
  `alembic_roots()` drops a mesh whose ancestor is already exported, so it is
  not written twice.
* **`shot.json`**: raw Maya values for everything that has to be converted
  exactly: the camera's world matrix and focal length on each frame, film back
  in inches, film fit, clip planes, each light's matrix/intensity/colour per
  frame, each object's look and colour, render resolution, fps and settings.
  Values are sampled with `getAttr(..., time=f)`, so the timeline never moves.

**Why not let Alembic or USD carry the camera and lights?** The proposal named
lighting as the riskiest part. Keeping the camera and lights as raw numbers
means the conversion lives in one small, tested file (`convert.py`) instead of
inside two importers I can't see into.

## 4. The conversion (`toon_bridge/convert.py`)

Pure Python (no `maya`, no `bpy`), so Maya, Blender and the unit tests all use the same code.

* **Axes**: Maya is Y-up, Blender Z-up. Rotate the world +90° about X:
  `(x, y, z) -> (x, -z, y)`. This is the same rotation Blender's Alembic
  importer applies to meshes, so the camera and lights line up with the geometry.
* **Units**: centimetres to metres (×0.01). The Alembic import also uses `scale=0.01`.
* **Matrices**: Maya stores row vectors (rows 0-2 = axes, row 3 =
  translation); Blender's `mathutils.Matrix` uses columns. `matrix()` converts
  each axis and the translation, then transposes. Cameras and lights look down
  local −Z in both programs, so local axes need no change.
* **Film back**: Maya apertures are inches (×25.4 = mm). Maya has four film
  fits and Blender two. Fill and Overscan become Horizontal or Vertical by
  comparing the film aspect with the image aspect.
* **Sun strength = π × intensity.** A Maya Lambert lit head-on by intensity
  *I* returns colour × *I*. Blender's diffuse BSDF returns colour × strength / π.
  `tests/light_match_blender.py` renders this in EEVEE: 0.500 vs 0.500, 0.400 vs 0.400, 0.600 vs 0.600.
* Point/spot power is approximate (Maya's "no decay" has no physical equivalent),
  and pre-flight warns about it.

## 5. The looks (`blender/looks.json`, `toon_materials.py`, `build_library.py`)

A look is data in `looks.json` (bands, base colour, specular, rim, outline).
`build_library.py` turns each into an EEVEE node tree and saves
`look_library.blend`, plus a look sheet image.

```
Diffuse BSDF ─► Shader to RGB ─► Color Ramp (Constant) ─┐   band multiplier
base colour (Attribute "tb_color" or RGB) ──────────────×┤
Glossy ─► Shader to RGB ─► > threshold ─► × spec colour ─+┤   hard highlight
Layer Weight (Facing) ─► > threshold ─► × rim colour ────+┤   rim
                                                          └─► Emission ─► Output
```

* **Shader to RGB** (EEVEE only) turns lighting into plain colour so it can be
  posterized. This is why the renderer has to be EEVEE.
* **Constant Color Ramp** = hard steps (cel bands). The stop colours *multiply*
  the base colour, so one look works for every object colour.
* **Maya colour per object**: `render.py` writes the colour into a custom
  property `tb_color`, and an *Attribute* node (type Object) reads it. One
  material serves every object.
* **Emission output + Standard view transform**: the colours you pick are the
  colours you get (Filmic/AgX would shift them).
* **Artists can edit looks in Blender**: open `look_library.blend`, change the
  node trees, save. `render.py` *appends* materials from that file by name.
  Re-running `build_library.py` resets them from `looks.json`.

### Pop-art comic looks (`build_pop_look`, `type: "pop"` in looks.json)

```
Diffuse ─► Shader to RGB ─► RGB to BW = L (light value)
Window coords × aspect ─► rotate 45° ─► fract − 0.5 ─► distance d to cell centre
dot radius r = max(0, (dots_below − L) / dots_below) × max_dot      dots  = d < r
(x − y) × hatch freq ─► fract < width   AND   L < hatch_below         hatch
colour = base × (shadow tint | white by L) ─► saturation ─► mix dots ─► mix hatch ─► Emission
```
Window coordinates make the pattern screen-space, like a printed page; render.py
sets the `TB_Aspect` value node to width/height so dots stay round. After each
frame, `misregister()` shifts the red and blue channels with numpy, and
`on_twos` copies every other frame instead of rendering it.

### Outlines: inverted hull (`add_outline`)

A Solidify modifier makes a slightly bigger shell with flipped normals,
using the outline material with backface culling. From the camera you only
see the part of the shell that sticks out past the silhouette, which is the ink line.
Thickness is in local units; Alembic objects have scale 0.01, so the width is divided by the object's scale.

Two problems found while testing, and their fixes:

1. **Grainy band edges.** EEVEE's ray-traced GI, horizon scan and soft-shadow
   jitter add noise that Shader to RGB then posterizes into speckles. They are
   turned off in `setup_render()`, and lights get hard shadows in `toon_light()`.
2. **Blocky patches on the lit side.** The outline shell cast a shadow onto the
   object inside it. The outline material now returns *Transparent* to shadow
   rays (Light Path → Is Shadow Ray), so the shell is invisible to shadows.

### 2D ink lines: Freestyle (`setup_ink_lines`, the default)

The hull is a 3D shell, so its line thins out with distance and never draws
inside the silhouette, which still reads as 3D. Freestyle finds edges in the
rendered view and draws strokes with a **constant pixel width**: a thick
outer line (silhouette, contour, borders) and a thin inner line (creases
sharper than 50°). The panel's *Line style* picks ink, hull, or both.
`DeformBaker` hands Freestyle a plain mesh of the current pose for each deforming
(skinned) Alembic object on every frame.

## 6. Rendering (`blender/render.py`)

Runs with `blender -b --factory-startup --python render.py -- shot.json [--frame N] [--preview]`.
It reads `shot.json`, imports the Alembic, appends only the looks it needs,
assigns them by object name (missing names are reported), builds the camera
and lights with one keyframe per frame, sets up EEVEE and a world, and saves
`toon_shot.blend` for inspection. Then it renders frame by frame, printing
`TOONBRIDGE FRAME <f> <i> <n> <path>` after each one.

The world uses **Light Path → Is Camera Ray**: the camera sees the backdrop
colour, while lighting only gets the small ambient fill (from Maya ambient lights),
so a bright backdrop doesn't wash out the shadow bands.

## 7. Launching (`toon_bridge/launcher.py`)

* `find_blender()`: env var `TOON_BRIDGE_BLENDER`, then the path saved in the
  panel (a Maya optionVar), then the standard install locations.
* **Maya's `PYTHONHOME`/`PYTHONPATH` are removed** before starting Blender.
  Otherwise Blender's own Python could load Maya's Python 3.11 libraries.
* `BlenderJob` wraps **QProcess**: Blender runs while Maya stays responsive.
  Output is read line by line; `TOONBRIDGE` lines become progress/frame
  signals, and a non-zero exit or `TOONBRIDGE ERROR` marks the job failed.
* `run_blocking()` is the same thing for scripts and tests.

## 8. The panel (`toon_bridge/ui.py`)

A dockable PySide6 window (`MayaQWidgetDockableMixin`) with five sections
that follow the order of work: **Looks → Shot → Pre-flight → Render → Result**.
"Render Current Frame" exports only that frame into `current_frame/` and
loads the result into Maya's Render View. "Render Shot" fills the flipbook as
frames arrive. "Open .blend in Blender" opens the exact scene that was rendered.

## 9. Verification (`tests/`)

| Test | Runs in | What it proves |
|---|---|---|
| `test_convert.py` | any Python | axis, units, matrix layout, film fit, sun formula |
| `light_match_blender.py` | Blender | sun strength = π × intensity gives Maya's brightness (exact to 3 decimals) |
| `camera_match.py` | mayapy | same frame in Maya Software vs Blender: 99.20% of pixels agree on foreground/background |
| `ui_smoke.py` | mayapy | the real panel: assign, preview, pre-flight, Render Current Frame via QProcess, viewer (13/13) |
| `run_end_to_end.py` | mayapy | build demo → pre-flight → export → Blender → every frame exists, right size, not blank |
