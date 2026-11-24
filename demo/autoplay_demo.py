"""Auto-play the Toon Bridge demo inside Maya, with captions (about 50 s).

    from toon_bridge import menu; menu.play_demo()       # or Toon Bridge > Play Demo

Opens demo/presentation.ma, then clicks through the real panel step by step:
style card -> check + Fix all -> Render -> result player -> frames on the
camera in the viewport while the timeline plays. Every click is the same one a
user makes; captions appear at the top of the viewport. Useful for screen
recordings and as a backup during a live presentation.
"""
import os

import maya.cmds as cmds
import maya.mel as mel

try:
    from PySide6 import QtCore, QtWidgets
except ImportError:
    from PySide2 import QtCore, QtWidgets

REPO = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SCENE = os.path.join(REPO, "demo", "presentation.ma")
_timers = []


def caption(text, seconds=3.6):
    cmds.inViewMessage(amg="<span style='font-size:20px'>%s</span>" % text, pos="topCenter",
                       fade=True, fadeInTime=250, fadeStayTime=int(seconds * 1000), fadeOutTime=300)


def _model_panel():
    panels = [p for p in (cmds.getPanel(visiblePanels=True) or []) if cmds.getPanel(typeOf=p) == "modelPanel"]
    return panels[0] if panels else None


def _scroll_to(panel, widget):
    area = panel.findChild(QtWidgets.QScrollArea)
    if area:
        area.ensureWidgetVisible(widget, 0, 12)


def run(single_view=True):
    from toon_bridge import ui
    cmds.file(SCENE, open=True, force=True)
    if single_view:
        try:
            mel.eval('setNamedPanelLayout "Single Perspective View"')     # a MEL procedure
        except RuntimeError:
            pass
    mp = _model_panel()
    if mp:
        cmds.lookThru(mp, "shotCam")
        cmds.modelEditor(mp, edit=True, displayAppearance="smoothShaded", grid=False, headsUpDisplay=False)
    cmds.currentTime(40)
    p = ui.panel() or ui.show()
    p.refresh()
    p.range_group.button(0).setChecked(True)
    p.ip_btn.setChecked(False)
    _scroll_to(p, p.style_card)

    def step_style():
        caption("<b>1 · Choose a style</b> — one click gives every object a look")
        QtCore.QTimer.singleShot(1600, p.style_buttons["pop"].click)

    def step_names():
        caption("Looks are guessed from names: head → skin, eyes → flat, roofs → ground")
        p.obj_filter.setText("bean")
        QtCore.QTimer.singleShot(3200, lambda: p.obj_filter.setText(""))

    def step_check():
        _scroll_to(p, p.check_card)
        caption("<b>2 · Check</b> — two buildings share a name, so their looks would mix up")
        dupes = [r for r in p.results if r.status == "error"]
        if dupes and dupes[0].nodes:
            cmds.select(dupes[0].nodes, replace=True)
        QtCore.QTimer.singleShot(2600, lambda: (caption("<b>Fix all</b> — renamed, ready to render"),
                                                p.fix_all_btn.click(), cmds.select(clear=True)))

    def step_render():
        _scroll_to(p, p.render_card)
        caption("<b>3 · Render</b> — Blender renders in the background, Maya stays usable")
        QtCore.QTimer.singleShot(1400, p.render_btn.click)

    def step_result():
        _scroll_to(p, p.result_card)
        caption("The frame comes back into Maya")

    def step_shot():
        n = p.load_last_render()
        caption("The whole %d-frame shot, rendered with the same button" % n)
        p.viewer.play_btn.setChecked(True)

    def step_viewport():
        p.viewer.play_btn.setChecked(False)
        p.ip_btn.setChecked(True)
        caption("<b>Show in viewport</b> — the comic frames sit on the camera; play the timeline", 5.5)
        cmds.currentTime(1)
        cmds.play(forward=True)

    def step_end():
        cmds.play(state=False)
        caption("Export MP4 · Open in Blender · everything inside Maya", 4.0)

    plan = [(500, lambda: caption("<b>Toon Bridge</b> — render a Maya shot in a comic style with Blender EEVEE")),
            (4500, step_style), (9000, step_names), (14000, step_check), (21000, step_render),
            (27000, step_result), (30500, step_shot), (36500, step_viewport), (46500, step_end)]
    del _timers[:]
    for ms, fn in plan:
        t = QtCore.QTimer()
        t.setSingleShot(True)
        t.timeout.connect(fn)
        t.start(ms)
        _timers.append(t)
    return 51
