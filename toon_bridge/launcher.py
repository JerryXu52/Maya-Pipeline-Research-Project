"""Find Blender and run blender/render.py on an exported shot.

Two ways to run it:
  run_blocking()  - for scripts and tests (mayapy); waits and returns the log
  BlenderJob      - for the UI; a QProcess, so Maya stays responsive while
                    Blender renders, with signals for progress and each frame
"""
import glob
import os
import shutil
import subprocess
import sys

REPO = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
RENDER_SCRIPT = os.path.join(REPO, "blender", "render.py")
OPTION_VAR = "toonBridgeBlenderPath"


def _candidates():
    if sys.platform == "darwin":
        yield "/Applications/Blender.app/Contents/MacOS/Blender"
        for p in sorted(glob.glob("/Applications/Blender*.app/Contents/MacOS/Blender"), reverse=True):
            yield p
    elif sys.platform.startswith("win"):
        for p in sorted(glob.glob(r"C:\Program Files\Blender Foundation\Blender*\blender.exe"), reverse=True):
            yield p
    which = shutil.which("blender")
    if which:
        yield which


def saved_path():
    try:
        import maya.cmds as cmds
        if cmds.optionVar(exists=OPTION_VAR):
            return cmds.optionVar(query=OPTION_VAR)
    except ImportError:
        pass
    return None


def save_path(path):
    import maya.cmds as cmds
    cmds.optionVar(stringValue=(OPTION_VAR, path))


def find_blender():
    """Env var TOON_BRIDGE_BLENDER, then the path saved in the UI, then defaults."""
    for p in [os.environ.get("TOON_BRIDGE_BLENDER"), saved_path(), *_candidates()]:
        if p and os.path.isfile(p):
            return p
    return None


def build_command(shot_json, frame=None, preview=False, blender=None):
    blender = blender or find_blender()
    if not blender:
        raise RuntimeError("Blender not found. Set its path in the Toon Bridge panel.")
    cmd = [blender, "-b", "--factory-startup", "--python", RENDER_SCRIPT, "--", shot_json]
    if frame is not None:
        cmd += ["--frame", str(int(frame))]
    if preview:
        cmd.append("--preview")
    return cmd


VIDEO_SCRIPT = os.path.join(REPO, "blender", "encode_video.py")
_versions = {}


def video_command(frames_dir, out_path, fps=24, blender=None):
    """Blender command that turns a PNG sequence into an MP4 (Blender ships FFmpeg)."""
    blender = blender or find_blender()
    if not blender:
        raise RuntimeError("Blender not found.")
    return [blender, "-b", "--factory-startup", "--python", VIDEO_SCRIPT, "--",
            frames_dir, out_path, str(int(round(fps)))]


PREVIEW_SCRIPT = os.path.join(REPO, "blender", "preview_look.py")


def preview_command(look_json, out_png, width=480, height=300, blender=None):
    """Blender command that renders a preview swatch of one (unsaved) look."""
    blender = blender or find_blender()
    if not blender:
        raise RuntimeError("Blender not found.")
    return [blender, "-b", "--factory-startup", "--python", PREVIEW_SCRIPT, "--",
            look_json, out_png, str(int(width)), str(int(height))]


def blender_version(path=None):
    """'5.3.0' for the given (or found) Blender, cached; None if it can't run."""
    path = path or find_blender()
    if not path:
        return None
    if path not in _versions:
        try:
            out = subprocess.run([path, "--version"], capture_output=True, text=True, timeout=20,
                                 env=_clean_env()).stdout
            first = out.strip().splitlines()[0] if out.strip() else ""
            _versions[path] = first.replace("Blender", "").strip() or None
        except (OSError, subprocess.SubprocessError):
            _versions[path] = None
    return _versions[path]


def _clean_env():
    """Maya sets PYTHONHOME/PYTHONPATH for its own Python 3.11; Blender must not inherit them."""
    env = dict(os.environ)
    for k in ("PYTHONHOME", "PYTHONPATH"):
        env.pop(k, None)
    return env


def run_blocking(cmd, echo=False):
    proc = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
                            text=True, env=_clean_env())
    lines = []
    for line in proc.stdout:
        lines.append(line.rstrip("\n"))
        if echo and line.startswith("TOONBRIDGE"):
            print(line.rstrip())
    proc.wait()
    return proc.returncode, lines


try:
    from PySide6 import QtCore
except ImportError:  # Maya 2024 and older
    from PySide2 import QtCore


class BlenderJob(QtCore.QObject):
    """Runs Blender in the background and reports TOONBRIDGE lines as signals."""

    progress = QtCore.Signal(int, int)        # done, total
    frame_done = QtCore.Signal(int, str)      # frame number, png path
    message = QtCore.Signal(str)              # any log line
    finished = QtCore.Signal(bool, str)       # ok, summary

    def __init__(self, cmd, parent=None):
        super().__init__(parent)
        self.cmd = cmd
        self.proc = QtCore.QProcess(self)
        env = QtCore.QProcessEnvironment.systemEnvironment()
        env.remove("PYTHONHOME")
        env.remove("PYTHONPATH")
        self.proc.setProcessEnvironment(env)
        self.proc.setProcessChannelMode(QtCore.QProcess.MergedChannels)
        self.proc.readyReadStandardOutput.connect(self._read)
        self.proc.finished.connect(self._done)
        self._buf = ""
        self.errors = []     # suspicious log lines, shown to the user
        self.fatal = []      # TOONBRIDGE ERROR lines from render.py
        self.frames = []

    def start(self):
        self.message.emit("$ " + " ".join('"%s"' % c if " " in c else c for c in self.cmd))
        self.proc.start(self.cmd[0], self.cmd[1:])

    def stop(self):
        if self.proc.state() != QtCore.QProcess.NotRunning:
            self.proc.kill()

    def running(self):
        return self.proc.state() != QtCore.QProcess.NotRunning

    def _read(self):
        self._buf += bytes(self.proc.readAllStandardOutput()).decode("utf-8", "replace")
        *lines, self._buf = self._buf.split("\n")
        for line in lines:
            self._line(line)

    def _line(self, line):
        if not line.startswith("TOONBRIDGE"):
            if "Error" in line or "Traceback" in line:
                self.errors.append(line)
                self.message.emit(line)
            return
        parts = line.split(" ", 2)
        tag = parts[1] if len(parts) > 1 else ""
        rest = parts[2] if len(parts) > 2 else ""
        if tag == "FRAME":
            f, i, n, path = rest.split(" ", 3)
            self.frames.append(path)
            self.progress.emit(int(i), int(n))
            self.frame_done.emit(int(f), path)
        elif tag == "TOTAL":
            self.progress.emit(0, int(rest))
        elif tag == "ERROR":
            self.fatal.append(rest)
        self.message.emit(line[len("TOONBRIDGE "):])

    def _done(self, code, _status=None):
        if self._buf:
            self._line(self._buf)
            self._buf = ""
        ok = code == 0 and not self.fatal
        summary = "%d frame(s) rendered" % len(self.frames) if ok else \
            "Blender failed (exit %s): %s" % (code, (self.fatal or self.errors or ["see log"])[-1])
        self.finished.emit(ok, summary)
