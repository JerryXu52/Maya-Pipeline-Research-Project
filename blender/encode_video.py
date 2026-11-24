"""Turn a rendered PNG sequence into an MP4 with Blender's own video encoder.

    blender -b --factory-startup --python blender/encode_video.py -- <frames_dir> <out.mp4> [fps]

Blender ships FFmpeg, so nothing else has to be installed: the frames go into
the Video Sequencer as one image strip and are rendered as H.264.
"""
import os
import sys

import bpy

argv = sys.argv[sys.argv.index("--") + 1:]
frames_dir, out = os.path.abspath(argv[0]), os.path.abspath(argv[1])
fps = int(argv[2]) if len(argv) > 2 else 24
files = sorted(f for f in os.listdir(frames_dir) if f.lower().endswith(".png"))
if not files:
    print("TOONBRIDGE ERROR no frames in", frames_dir, flush=True)
    sys.exit(1)

bpy.ops.wm.read_factory_settings(use_empty=True)
sc = bpy.context.scene
first = bpy.data.images.load(os.path.join(frames_dir, files[0]))
w, h = first.size
sc.render.resolution_x, sc.render.resolution_y = w - w % 2, h - h % 2   # H.264 needs even sizes
sc.render.resolution_percentage = 100
sc.render.fps = fps
sc.frame_start, sc.frame_end = 1, len(files)
se = sc.sequence_editor_create()
strip = se.strips.new_image(name="frames", filepath=os.path.join(frames_dir, files[0]), channel=1, frame_start=1)
for f in files[1:]:
    strip.elements.append(f)
ims = sc.render.image_settings
ims.media_type = "VIDEO"
ims.file_format = "FFMPEG"
sc.render.ffmpeg.format = "MPEG4"
sc.render.ffmpeg.codec = "H264"
sc.render.ffmpeg.constant_rate_factor = "HIGH"
sc.view_settings.view_transform = "Standard"
sc.render.filepath = out
sc.render.use_file_extension = False
bpy.ops.render.render(animation=True)
print("TOONBRIDGE VIDEO", out, len(files), flush=True)
