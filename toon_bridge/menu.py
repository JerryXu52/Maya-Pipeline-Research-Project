"""The 'Toon Bridge' menu in Maya's main menu bar, and the actions behind it."""
import os
import webbrowser

import maya.cmds as cmds
import maya.mel as mel

from . import styles

MENU = "toonBridgeMenu"
REPO = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DEMOS = [
    ("Rooftop jump (presentation scene)", "presentation.ma"),
    ("Bean park (simple demo)", "toon_demo.ma"),
]
README = "https://github.com/JerryXu52/Maya-Pipeline-Research-Project#readme"


def open_panel():
    from . import ui
    p = ui.panel()
    try:
        if p is not None and p.isVisible():
            return p
    except RuntimeError:
        pass
    return ui.show()


def render(current_only):
    p = open_panel()
    return p.render(current_only=current_only)


def set_style(key):
    if key not in styles.STYLES:
        cmds.warning("Toon Bridge: unknown style '%s' (use %s)" % (key, ", ".join(styles.ORDER)))
        return
    open_panel().choose_style(key)


def open_demo(filename):
    path = os.path.join(REPO, "demo", filename)
    if cmds.file(query=True, modified=True):
        answer = cmds.confirmDialog(title="Toon Bridge", message="Open the demo scene? Unsaved changes will be lost.",
                                    button=["Open demo", "Cancel"], defaultButton="Cancel",
                                    cancelButton="Cancel", dismissString="Cancel")
        if answer != "Open demo":
            return
    cmds.file(path, open=True, force=True)
    open_panel()


def play_demo():
    """Open the presentation scene and click through the panel with captions (about 50 s)."""
    import importlib.util
    path = os.path.join(REPO, "demo", "autoplay_demo.py")
    spec = importlib.util.spec_from_file_location("toon_bridge_autoplay_demo", path)
    mod = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(mod)
    open_panel()
    return mod.run()


def build():
    remove()
    main = mel.eval("$tmp = $gMainWindow")
    cmds.menu(MENU, label="Toon Bridge", parent=main, tearOff=True)
    cmds.menuItem(label="Open Toon Bridge", annotation="The three-step panel: style, check, render",
                  command=lambda *_: open_panel(), image="render.png")
    cmds.menuItem(divider=True)
    cmds.menuItem(label="Render This Frame", command=lambda *_: render(True))
    cmds.menuItem(label="Render Shot", command=lambda *_: render(False))
    cmds.menuItem(divider=True, dividerLabel="Style")
    for key in styles.ORDER:
        cmds.menuItem(label=styles.STYLES[key]["label"], annotation=styles.STYLES[key]["blurb"],
                      command=lambda *_a, k=key: set_style(k))
    cmds.menuItem(divider=True)
    cmds.menuItem(label="Demo Scenes", subMenu=True, tearOff=False)
    for label, fn in DEMOS:
        cmds.menuItem(label=label, command=lambda *_a, f=fn: open_demo(f))
    cmds.setParent("..", menu=True)
    cmds.menuItem(label="Play Demo (auto, with captions)", command=lambda *_: play_demo())
    cmds.menuItem(divider=True)
    cmds.menuItem(label="Help (README)", command=lambda *_: webbrowser.open(README))
    return MENU


def remove():
    if cmds.menu(MENU, exists=True):
        cmds.deleteUI(MENU)
