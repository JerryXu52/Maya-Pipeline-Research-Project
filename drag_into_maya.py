"""Drag this file into a Maya viewport to install Toon Bridge.

It adds this repo to Maya's Python path (now and on every start, through a
small line in userSetup.py) and puts a "Toon" button on the current shelf.
Nothing is copied: the tool runs from this folder, so `git pull` updates it.
"""
import os
import sys

REPO = os.path.dirname(os.path.abspath(__file__))
MARK = "# toon_bridge path"


def _add_user_setup():
    import maya.cmds as cmds
    scripts = cmds.internalVar(userScriptDir=True)
    path = os.path.join(scripts, "userSetup.py")
    line = "import sys; sys.path.append(%r)  %s\n" % (REPO, MARK)
    text = open(path).read() if os.path.isfile(path) else ""
    if MARK in text:
        text = "".join(l for l in text.splitlines(True) if MARK not in l)
    with open(path, "w") as f:
        f.write(text + line)
    return path


def _add_shelf_button():
    import maya.cmds as cmds
    import maya.mel as mel
    shelf_top = mel.eval("$tmp = $gShelfTopLevel")
    shelf = cmds.tabLayout(shelf_top, query=True, selectTab=True)
    for b in cmds.shelfLayout(shelf, query=True, childArray=True) or []:
        if cmds.shelfButton(b, query=True, exists=True) and \
                cmds.shelfButton(b, query=True, label=True) == "ToonBridge":
            cmds.deleteUI(b)
    cmds.shelfButton(parent=shelf, label="ToonBridge", imageOverlayLabel="Toon",
                     image="render.png", annotation="Toon Bridge: render with Blender EEVEE",
                     sourceType="python",
                     command="import toon_bridge.ui as tb; tb.show()")
    return shelf


def onMayaDroppedPythonFile(*_):
    if REPO not in sys.path:
        sys.path.append(REPO)
    us = _add_user_setup()
    shelf = _add_shelf_button()
    import toon_bridge.ui as tb
    tb.show()
    print("Toon Bridge installed: path added to %s, button on shelf '%s'." % (us, shelf))
