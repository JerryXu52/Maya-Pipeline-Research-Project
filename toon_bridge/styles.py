"""Style presets: one click picks a look for every object plus matching render settings.

A style is the artist-facing idea ("make it pop-art"). It maps object roles to
looks from blender/looks.json, and sets the render options that belong to the
style (line style, print effects, background). Roles are guessed from object
names, so `head_geo` gets the skin look and `ground` the ground look; any
object can still be changed by hand in the panel.
"""
import os
import re

ICON_DIR = os.path.join(os.path.dirname(os.path.abspath(__file__)), "icons")

STYLES = {
    "pop": {
        "label": "Pop-Art Comic",
        "blurb": "Halftone, hatching, off-register print, on twos",
        "roles": {"default": "pop_comic", "skin": "pop_skin", "eyes": "flat_ink", "ground": "pop_ground"},
        "settings": {"line_mode": "ink", "misregister_px": 3, "on_twos": True},
        "background": [1.0, 0.66, 0.50],
    },
    "cel": {
        "label": "Cel 2D",
        "blurb": "Anime two-tone, cool shadows, ink lines",
        "roles": {"default": "cel_2d", "skin": "anime_skin", "eyes": "flat_ink", "ground": "ground_2d"},
        "settings": {"line_mode": "ink", "misregister_px": 0, "on_twos": False},
        "background": [0.92, 0.91, 0.87],
    },
    "manga": {
        "label": "Manga Ink",
        "blurb": "Black and white, screentone greys",
        "roles": {"default": "manga_ink", "skin": "manga_ink", "eyes": "flat_ink", "ground": "manga_ink"},
        "settings": {"line_mode": "ink", "misregister_px": 0, "on_twos": True},
        "background": [1.0, 1.0, 1.0],
    },
    "flat": {
        "label": "Flat 2D",
        "blurb": "Unlit colour shapes with an ink line",
        "roles": {"default": "flat_ink", "skin": "flat_ink", "eyes": "flat_ink", "ground": "flat_ink"},
        "settings": {"line_mode": "ink", "misregister_px": 0, "on_twos": False},
        "background": [0.96, 0.94, 0.88],
    },
}
ORDER = ["pop", "cel", "manga", "flat"]

ROLE_PATTERNS = [
    ("eyes", re.compile(r"eye|pupil|iris|lens|cornea", re.I)),
    ("skin", re.compile(r"head|face|skin|hand|ear|nose|neck", re.I)),
    ("ground", re.compile(r"ground|floor|terrain|road|street|grass|_top$|roof_?top|plane", re.I)),
]


def icon_path(key):
    return os.path.join(ICON_DIR, "style_%s.png" % key)


def role_of(transform):
    name = transform.split("|")[-1].split(":")[-1]
    for role, pat in ROLE_PATTERNS:
        if pat.search(name):
            return role
    return "default"


def look_for(style_key, transform):
    roles = STYLES[style_key]["roles"]
    return roles.get(role_of(transform), roles["default"])


def plan(style_key, transforms, overwrite=False):
    """[(transform, look)] a style would apply.

    Objects with no look, or a look that came from a style or an automatic fix,
    are re-styled. Looks picked by hand are kept unless overwrite.
    """
    from . import looks as looks_mod     # Maya-only; styles.py is also read by Blender scripts
    out = []
    for t in transforms:
        if not overwrite and looks_mod.get_look(t) and looks_mod.get_source(t) == "hand":
            continue
        new = look_for(style_key, t)
        if looks_mod.get_look(t) != new:
            out.append((t, new))
    return out


def apply(style_key, transforms, overwrite=False):
    """Assign the style's looks. Returns how many objects changed."""
    from . import looks as looks_mod
    changes = plan(style_key, transforms, overwrite)
    by_look = {}
    for t, look in changes:
        by_look.setdefault(look, []).append(t)
    for look, ts in by_look.items():
        looks_mod.assign(look, ts, source="style")
    return len(changes)
