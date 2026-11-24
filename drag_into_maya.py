"""Drag this file into a Maya viewport to install Toon Bridge as a plug-in.

What it does (once):
  * writes a module file (toonBridge.mod) into your Maya modules folder, so Maya
    finds the plug-in and its Python code in this repo on every start;
  * loads plug-ins/toonBridge.py now and ticks Auto load in the Plug-in Manager;
  * adds a 'Toon Bridge' menu to the main menu bar and opens the panel.
Nothing is copied: Maya runs the tool from this folder, so `git pull` updates it.
Uninstall: untick the plug-in in the Plug-in Manager and delete toonBridge.mod.
"""
import os
import sys

REPO = os.path.dirname(os.path.abspath(__file__))
PLUGIN = os.path.join(REPO, "plug-ins", "toonBridge.py")
OLD_MARK = "# toon_bridge path"


def _modules_dir():
    import maya.cmds as cmds
    d = os.path.join(cmds.internalVar(userAppDir=True), "modules")
    os.makedirs(d, exist_ok=True)
    return d


def _write_module():
    path = os.path.join(_modules_dir(), "toonBridge.mod")
    with open(path, "w") as f:
        f.write("+ ToonBridge 1.0 %s\n" % REPO)
        f.write("PYTHONPATH +:= .\n")       # so 'import toon_bridge' works
        f.write("MAYA_PLUG_IN_PATH +:= plug-ins\n")
    return path


def _remove_old_install():
    """Earlier versions added a userSetup.py line and a shelf button; tidy them up."""
    import maya.cmds as cmds
    us = os.path.join(cmds.internalVar(userScriptDir=True), "userSetup.py")
    if os.path.isfile(us):
        text = open(us).read()
        if OLD_MARK in text:
            with open(us, "w") as f:
                f.write("".join(l for l in text.splitlines(True) if OLD_MARK not in l))


def onMayaDroppedPythonFile(*_):
    import maya.cmds as cmds
    if REPO not in sys.path:
        sys.path.append(REPO)
    mod = _write_module()
    _remove_old_install()
    if not cmds.pluginInfo(PLUGIN, query=True, loaded=True):
        cmds.loadPlugin(PLUGIN)
    cmds.pluginInfo(PLUGIN, edit=True, autoload=True)
    cmds.toonBridge(open=True)
    cmds.inViewMessage(amg="Toon Bridge installed: see the <hl>Toon Bridge</hl> menu", pos="topCenter", fade=True)
    print("Toon Bridge installed. Module: %s. Plug-in loaded and set to auto load." % mod)
