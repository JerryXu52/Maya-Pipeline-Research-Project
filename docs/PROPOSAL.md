# Research Project Proposal: Two Ideas

**Jianrui (Jerry) Xu · Nov 2026**
*Category: Connect things. Tools that improve a CG workflow, in Maya and across programs.*

I have two ideas, and I'd like feedback on which one to pursue. They can also be combined (see the end).

- **Idea 1: Maya–Blender Toon Bridge.** Render cel-shaded looks authored in Blender directly from Maya.
- **Idea 2: Maya Scene Pre-flight.** A scene hygiene checker with one-click fixes.

---

## Idea 1: Maya–Blender Toon Bridge

**The project in one sentence.**
A Python bridge that lets Maya artists assign cel-shaded (3D-to-2D) looks built in Blender's node editor and render the shot through Blender EEVEE in one click.

**Why this one.**
Toon shading in Maya/Arnold is rigid. `aiToon` is hard to layer and doesn't preview as toon in the viewport. In Blender, the same look is a few nodes (Shader to RGB → Constant Color Ramp). That node only exists in EEVEE, so the look can't be *translated* to Arnold. Instead, Blender becomes Maya's stylized renderer. Existing bridges (mLender, Universal Bridge) only move geometry, and Flair is a separate paid renderer. None of them let you pick a Blender look from inside Maya and get frames back. Afterward I'll be able to drive two applications from Python, move scene data between them reliably, and build stylized looks in Blender's node system.

**What I'll show.**
The tool (Maya Look panel + headless Blender scripts + a toon look library) and a short cel-shaded animated shot made with it.

**The three weeks.**
- **Nov 10:** Static frame round trip. Mesh + camera + one directional light → Blender, toon material applied by name, frame shown back in Maya.
- **Nov 17:** Animated shots via Alembic/USD; Look panel lists the library's looks; light conversion (direction, color, intensity).
- **Nov 23:** Outlines (Line Art / inverted hull), fast "preview current frame" button, demo shot.

**The smallest version that still counts.**
One button that renders the current frame in Blender with my toon materials and shows it in Maya.

**The riskiest part.**
Matching the lighting. Toon bands depend entirely on light direction, so Maya's Y-up/cm, film back and Arnold light units must convert exactly to Blender's Z-up/m, sensor size and watts. Second risk: whether shading-group names survive the Alembic/USD export so looks can be re-applied by name. Fallback: a JSON mapping written alongside the export.

```
MAYA                                       BLENDER (headless: blender -b)
─────────────────────────────────          ──────────────────────────────────
Look panel: tag objects with a        ──►  look_library.blend
  look from the library                      (Shader-to-RGB toon materials,
Export: Alembic/USD geometry,                outline setups) + looks.json
  camera, lights.json, shot.json      ──►  render.py: import cache → swap
                                             materials by look name → rebuild
                                             lights/camera → EEVEE render
Frames shown in image plane /         ◄──  PNG/EXR frame sequence
  Render View
```

---

## Idea 2: Maya Scene Pre-flight

**The project in one sentence.**
A Maya tool that scans a scene for hygiene problems (missing textures, unknown nodes, bad transforms, bad geometry, wrong render settings) and fixes them with one click before the scene is shared, exported or rendered.

**Why this one.**
Maya's built-in *Optimize Scene Size* is blunt. It deletes unknown nodes without saying which plugin is missing, and it skips referenced nodes. Good validators exist only inside full studio pipelines like AYON/Pyblish, which students and freelancers don't have. Afterward I'll understand how studio pipelines validate work, and I'll have a reusable checker framework that I can add new checks to.

**What I'll show.**
The tool (a traffic-light check panel with Fix buttons) and a before/after demo on a messy scene, including a scene from my own past projects.

**The three weeks.**
- **Nov 10:** Check framework + 6 core checks with a pass/fail report UI.
- **Nov 17:** One-click Fix for each check; select-the-problem buttons; more checks.
- **Nov 23:** Shot presets (units, fps, frame range, resolution); batch-check a folder of scenes and write an HTML report.

**The smallest version that still counts.**
A panel that runs the core checks on any scene and reports exactly which nodes fail.

**The riskiest part.**
Fixes that are safe. Auto-fixing must never break a scene (e.g. freezing transforms on rigged or referenced objects), so each fix needs to detect when it should *not* run.

| Planned check | Why it matters | Auto-fix |
|---|---|---|
| Unknown nodes / missing plugins | Bloat; reports *which* plugin is missing | Report, then remove |
| Missing or absolute texture paths | Breaks on another machine | Repath relative to project |
| Unfrozen / negative-scale transforms | Flipped normals, wrong lighting after export | Freeze (skip rigged/referenced) |
| Non-manifold / lamina / zero-area faces | Export and render artifacts | Select for manual fix |
| Duplicate / non-unique names | Breaks scripts and name-based matching | Rename with suffix |
| Scene units, fps, frame range, resolution | Scale and timing mismatches | Set to shot preset |
| Unused nodes, empty groups, construction history | Scene hygiene | Delete |

---

## Combining them

The two ideas connect naturally. Pre-flight can run as an automatic **gate before "Send to Blender"**, with extra checks the bridge needs (every object has a look assigned, names are unique, transforms are frozen). If the bridge's lighting match turns out to be too hard, Pre-flight still stands on its own as a finished tool for Nov 24.

**My question:** Should I pick one, or combine them with Pre-flight as the low-risk core and the Bridge as the main research goal?

## Tech

- Maya 2026 (Python 3, `maya.cmds`, PySide UI), MayaUSD / Alembic export
- Blender 4.x/5.x run headless (`blender -b --python`), EEVEE, Line Art

## References

- [Arnold Toon shader docs](https://help.autodesk.com/cloudhelp/ENU/AR-Maya/files/am-Arnold_for_Maya_User_Guide/shaders/surface/arnold_for_maya_surface_am_Toon_html.html) · [Toon shading with EEVEE](https://github.com/TehMerow/Tutorials/wiki/Toon-Shading-with-Eevee)
- Existing bridges: [mLender](https://github.com/mena-works/mLender) · [Universal Bridge: Maya](https://superhivemarket.com/products/maya-bridge) · Stylized Maya renderer: [Flair](https://80.lv/articles/flair-an-overview-of-a-node-based-engine-for-stylized-3d-art/)
- [Maya Optimize Scene Size docs](https://help.autodesk.com/cloudhelp/2026/ENU/Maya-Basics/files/GUID-6798B37D-0FF0-4ED3-A151-5CC648BB8CED.htm) · [AYON validators](https://docs.ayon.dev/ayon-3dsmax/latest/autoapi/client/ayon_max/plugins/publish/validate_rendersettings.html) · [Ynput pipeline report](https://ynput.io/the-state-of-animation-vfx-pipelines-report/)
