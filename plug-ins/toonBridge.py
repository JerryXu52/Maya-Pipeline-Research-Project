"""Toon Bridge Maya plug-in: a 'Toon Bridge' menu, the toonBridge command, the panel.

Load it once from Windows > Settings/Preferences > Plug-in Manager (tick
Auto load), or drag drag_into_maya.py into a viewport, which does that for you.

Command (MEL or Python):
    toonBridge -open;                     cmds.toonBridge(open=True)
    toonBridge -renderFrame;              cmds.toonBridge(renderFrame=True)
    toonBridge -renderShot;               cmds.toonBridge(renderShot=True)
    toonBridge -style "pop";              cmds.toonBridge(style="pop")      # pop | cel | manga | flat
"""
import os
import sys

import maya.api.OpenMaya as om
import maya.cmds as cmds

VERSION = "1.0.0"


def maya_useNewAPI():
    """Tell Maya this plug-in uses the Python API 2.0."""


class ToonBridgeCmd(om.MPxCommand):
    name = "toonBridge"
    flags = {  # short, long, type
        "open": ("-o", "-open", None),
        "renderFrame": ("-rf", "-renderFrame", None),
        "renderShot": ("-rs", "-renderShot", None),
        "style": ("-st", "-style", om.MSyntax.kString),
    }

    @staticmethod
    def creator():
        return ToonBridgeCmd()

    @classmethod
    def syntax(cls):
        s = om.MSyntax()
        for short, long, kind in cls.flags.values():
            if kind is None:
                s.addFlag(short, long)
            else:
                s.addFlag(short, long, kind)
        return s

    def doIt(self, args):
        db = om.MArgDatabase(self.syntax(), args)
        from toon_bridge import menu
        if db.isFlagSet("-st"):
            menu.set_style(db.flagArgumentString("-st", 0))
        if db.isFlagSet("-rf"):
            menu.render(current_only=True)
        elif db.isFlagSet("-rs"):
            menu.render(current_only=False)
        elif db.isFlagSet("-o") or not (db.isFlagSet("-st")):
            menu.open_panel()


def initializePlugin(obj):
    plugin = om.MFnPlugin(obj, "Jianrui Xu", VERSION, "Any")
    # Maya runs plug-in files without __file__: ask Maya where this one lives.
    repo = os.path.dirname(os.path.abspath(plugin.loadPath()))
    if repo not in sys.path:
        sys.path.insert(0, repo)
    plugin.registerCommand(ToonBridgeCmd.name, ToonBridgeCmd.creator, ToonBridgeCmd.syntax)
    if not cmds.about(batch=True):
        cmds.evalDeferred("from toon_bridge import menu; menu.build()", lowestPriority=True)


def uninitializePlugin(obj):
    plugin = om.MFnPlugin(obj)
    if not cmds.about(batch=True):
        try:
            from toon_bridge import menu, ui
            ui.close()
            menu.remove()
        except Exception as exc:  # never block unloading
            print("Toon Bridge: cleanup warning: %s" % exc)
    plugin.deregisterCommand(ToonBridgeCmd.name)
