"""Pre-render the presentation shot so the flipbook plays instantly in class.

Two ways to run it:

  Terminal:   mayapy demo/prerender_presentation.py [--frames 1,40,96]
  Maya:       paste this file into the Script Editor (Python tab) and run it,
              or:  import prerender_presentation; prerender_presentation.launch()

Inside Maya it does NOT touch your open scene: it starts a separate background
mayapy that builds demo/presentation.ma in memory, does the live-demo steps in
code (assign the hero's looks, run pre-flight fixes), and renders into the
folder the panel uses for that scene: demo/toon_bridge/presentation/frames/.
Maya stays usable; the Script Editor says when it is done (about a minute).
In class, press 'Load Shot Frames' to show the frames.
"""
import os
import subprocess
import sys


def _repo():
    try:
        return os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    except NameError:          # pasted into the Script Editor: no __file__
        try:
            import toon_bridge     # on the path once drag_into_maya.py was installed
        except ImportError:
            raise RuntimeError("Maya doesn't know where the Toon Bridge repo is yet: "
                               "drag drag_into_maya.py into a Maya viewport first, then run this again.")
        return os.path.dirname(os.path.dirname(os.path.abspath(toon_bridge.__file__)))


def _in_maya_gui():
    """True inside interactive Maya (not mayapy, not batch)."""
    try:
        import maya.cmds as cmds
        return not cmds.about(batch=True)
    except Exception:          # mayapy before initialize, or plain Python
        return False


_job = {}


def launch(frames=None):
    """From interactive Maya: run the pre-render in a background mayapy."""
    import maya.cmds as cmds
    repo = _repo()
    script = os.path.join(repo, "demo", "prerender_presentation.py")
    exe = "mayapy.exe" if sys.platform.startswith("win") else "mayapy"
    mayapy = os.path.join(os.environ.get("MAYA_LOCATION", ""), "bin", exe)
    if not os.path.isfile(mayapy):
        raise RuntimeError("mayapy not found at %s" % mayapy)
    log_dir = os.path.join(repo, "demo", "toon_bridge")
    os.makedirs(log_dir, exist_ok=True)
    log_path = os.path.join(log_dir, "prerender.log")
    cmd = [mayapy, script] + (["--frames", ",".join(str(f) for f in frames)] if frames else [])
    log = open(log_path, "w")
    proc = subprocess.Popen(cmd, stdout=log, stderr=subprocess.STDOUT, stdin=subprocess.DEVNULL)
    _job.update(proc=proc, log=log, log_path=log_path)
    print("[Toon Bridge] Pre-render started in the background (about a minute). Log: %s" % log_path)
    cmds.inViewMessage(amg="Toon Bridge: pre-rendering the presentation shot in the background",
                       pos="topCenter", fade=True)

    try:
        from PySide6 import QtCore
    except ImportError:
        from PySide2 import QtCore
    timer = QtCore.QTimer()
    _job["timer"] = timer

    def check():
        if proc.poll() is None:
            return
        timer.stop()
        log.close()
        text = open(log_path).read()
        frames_dir = os.path.join(repo, "demo", "toon_bridge", "presentation", "frames")
        n = len([f for f in os.listdir(frames_dir) if f.endswith(".png")]) if os.path.isdir(frames_dir) else 0
        ok = proc.returncode == 0 and "FRAMES" in text
        msg = ("Pre-render done: %d frames in %s" % (n, frames_dir)) if ok else \
            ("Pre-render failed (exit %s), see %s" % (proc.returncode, log_path))
        print("[Toon Bridge] " + msg)
        cmds.inViewMessage(amg="Toon Bridge: " + msg, pos="topCenter", fade=True)

    timer.timeout.connect(check)
    timer.start(2000)
    return proc


def main():
    """Command line (mayapy): build, stage and render. Never run this inside interactive Maya."""
    repo = _repo()
    here = os.path.join(repo, "demo")
    sys.path[:0] = [repo, here]
    from PySide6 import QtWidgets
    app = QtWidgets.QApplication(["prerender"])  # noqa: F841  (before Maya, for Qt images)
    import maya.standalone
    maya.standalone.initialize()

    import make_presentation_scene as ps
    from toon_bridge import exporter, launcher, preflight

    cam = ps.build(save=False)
    for r in preflight.run_all(camera=cam):
        print("BEFORE %-5s %s: %s" % (r.status, r.title, r.summary), flush=True)
    ps.stage_for_render()
    for r in preflight.run_all(camera=cam):
        print("AFTER  %-5s %s: %s" % (r.status, r.title, r.summary), flush=True)
    shot_dir = os.path.join(here, "toon_bridge", "presentation")
    shot = exporter.export_shot(cam, ps.START, ps.END, shot_dir,
                                settings={"misregister_px": 3, "on_twos": True})
    frames = None
    if "--frames" in sys.argv:
        frames = [int(f) for f in sys.argv[sys.argv.index("--frames") + 1].split(",")]
    for f in frames or [None]:
        code, lines = launcher.run_blocking(launcher.build_command(shot, frame=f))
        print("blender exit", code, [l for l in lines if "WARN" in l or "ERROR" in l][:10], flush=True)
    print("FRAMES", os.path.join(shot_dir, "frames"), flush=True)
    sys.stdout.flush()
    os._exit(0)       # mayapy only: skips Maya's slow shutdown


if __name__ == "__main__":
    if _in_maya_gui():
        launch()          # pasted or run in the Script Editor: background job, Maya untouched
    else:
        main()
