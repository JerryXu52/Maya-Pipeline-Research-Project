# Live demo script: `demo/presentation.ma`

A rooftop jump at dusk, staged so each step of the panel has something to show.
About 2 minutes, all inside Maya. (To rebuild the scene file: `mayapy demo/make_presentation_scene.py`.)

![Presentation scene, rendered](images/presentation_scene.gif)

## What is staged in the scene

| Staged | So that you can show |
|---|---|
| The hero (`bean_body`, `bean_head`, eyes, scarf) has **no look** | one click of a style card gives it looks (step 1) |
| Two skyline buildings are both named **`tower`** (in `skyline_near` and `skyline_far`) | pre-flight's red error and its one-click **Fix** (step 3) |
| The three rooftop **AC units** have no look | the style click covers them too |
| Buildings use a **tiled window texture** | textures coming through, posterized under the halftone |
| Camera `shotCam` follows the jump; the sun is low and warm; the sky colour is saved in the scene | the camera and light conversion, the Background swatch |
| Render the shot once before class (optional) | the panel shows that last render as soon as the scene opens |

## Before class

1. In Maya: *Toon Bridge → Demo Scenes → Rooftop jump* (opens `demo/presentation.ma`; the panel opens too).
2. Optional, so the full shot can play instantly: in step 3 pick **Playback** and press **Render** (about a minute),
   then reopen the demo scene so the planted problems are back. The panel shows the last render automatically.

## Live, step by step

| # | Do | Say |
|---|---|---|
| 1 | In **1 Choose a style**, click **Pop-Art Comic**. The list fills in: the head gets *Pop-art skin*, the eyes *Flat 2D*, the roofs *Pop-art ground*. | "One click gives every object a look; it guesses skin, eyes and ground from object names. I can change any row." |
| 2 | Change one row's look in the list, then tick **Preview looks in the viewport** and untick it. | "Looks are stored on the objects. The viewport preview is a rough Maya version." |
| 3 | Look at **2 Check the scene**: red, *2 meshes share a name*. Click **Select** (both towers light up), then **Fix all**. It turns green. | "Blender re-applies looks by name, so two buildings called tower would get mixed up. The check catches it and fixes it." |
| 4 | In **3 Render**, keep *This frame* and press **Render frame 40**. The frame appears in **Result** in about 2 seconds. | "Maya exports, Blender renders in the background, the frame comes back. Maya stays usable." |
| 5 | Press **Play**, or scrub the Maya timeline (the result follows it). Click **Show in viewport** and look through `shotCam`. | "The comic frames sit on the camera, so I can scrub them right in the Maya viewport." |
| 6 | (Optional) **Export MP4…**, **Open in Blender**. | "Video export uses Blender's own encoder; Open in Blender shows the exact scene it rendered." |

If something breaks: play `docs/video/toon_bridge_demo.mp4` or show the GIF above.
