"""What a look is: one node template with optional nodes, as plain data.

Pure Python (no maya.cmds, no bpy): the Maya Look Editor edits these dicts,
blender/toon_materials.py turns them into an EEVEE node tree, and the tests
check them. Every look has the same graph, so every look edits the same way:

  Light (Diffuse) -> Shader to RGB -> L (how lit, 0..1)
  Base colour x Bands(L)           colour ramp, constant interpolation
  -> Saturation
  -> + Specular                    optional: Glossy -> Shader to RGB -> threshold
  -> Halftone dots                 optional: screen-space dots, bigger where darker
  -> Hatching                      optional: screen-space diagonal lines in deep shadow
  -> Rim light                     optional: facing ratio -> threshold, add or replace
  -> Emission -> Output
  Outline                          optional: inverted hull / ink lines width + colour
"""
import copy

NODES = ["light", "base", "bands", "saturation", "specular", "halftone", "hatching", "rim", "output", "outline"]
OPTIONAL = ["specular", "halftone", "hatching", "rim", "outline"]

DEFAULTS = {
    "label": "New look",
    "base_color": "maya",
    "bands": [[0.0, [0.45, 0.42, 0.6]], [0.4, [1.0, 1.0, 1.0]]],
    "saturation": 1.0,
    "specular": {"enabled": False, "roughness": 0.3, "threshold": 0.5, "color": [1.0, 1.0, 1.0]},
    "halftone": {"enabled": False, "per_screen": 70.0, "below": 0.75, "max_dot": 0.6,
                 "angle": 45.0, "color": None, "darken": 0.35},
    "hatching": {"enabled": False, "per_screen": 110.0, "below": 0.18, "width": 0.28,
                 "angle": -45.0, "color": [0.06, 0.04, 0.12]},
    "rim": {"enabled": False, "threshold": 0.7, "color": [0.3, 0.3, 0.35], "mode": "add"},
    "outline": {"enabled": False, "width_cm": 0.4, "color": [0.05, 0.04, 0.08]},
    "source": "json",          # "blend": use the material hand-edited in look_library.blend instead
}


def _merge(base, over):
    out = copy.deepcopy(base)
    for k, v in (over or {}).items():
        if isinstance(v, dict) and isinstance(out.get(k), dict):
            out[k] = _merge(out[k], v)
        else:
            out[k] = copy.deepcopy(v)
    return out


def normalize(look):
    """Any stored look (old cel / old pop / new) -> the full template dict with every key."""
    look = copy.deepcopy(look or {})
    if look.get("type") == "pop" and "halftone" not in look:     # the first pop-art format
        mult = look.get("shadow_mult", [0.78, 0.74, 0.92])
        new = {
            "label": look.get("label", "Pop look"),
            "base_color": look.get("base_color", "maya"),
            "bands": [[0.0, mult], [look.get("lit_above", 0.45), [1.0, 1.0, 1.0]]],
            "saturation": look.get("saturation", 1.35),
            "halftone": {"enabled": True, "per_screen": look.get("dots_per_screen", 70.0),
                         "below": look.get("dots_below", 0.75), "max_dot": look.get("max_dot", 0.6),
                         "color": look.get("dot_color"), "darken": 0.35},
            "hatching": {"enabled": look.get("hatch_below", 0.18) > 0,
                         "per_screen": look.get("hatch_per_screen", 110.0),
                         "below": look.get("hatch_below", 0.18), "width": look.get("hatch_width", 0.28),
                         "color": look.get("hatch_color", [0.06, 0.04, 0.12])},
        }
        if look.get("rim"):
            new["rim"] = dict(look["rim"], enabled=True, mode="replace")
        if look.get("outline"):
            new["outline"] = dict(look["outline"], enabled=True)
        look = new
    else:
        for key in ("specular", "rim", "outline", "halftone", "hatching"):
            v = look.get(key)
            if isinstance(v, dict) and "enabled" not in v:
                look[key] = dict(v, enabled=True)
            elif v is None and key in look:
                look[key] = {"enabled": False}
        if look.get("rim") and "mode" not in look["rim"]:
            look["rim"]["mode"] = "add"
    look.pop("type", None)
    full = _merge(DEFAULTS, look)
    full["bands"] = sorted([[float(p), list(c)] for p, c in full["bands"]], key=lambda b: b[0]) or DEFAULTS["bands"]
    return full


def compact(look):
    """Drop disabled nodes' settings and defaults, so looks.json stays readable."""
    look = normalize(look)
    out = {"label": look["label"], "base_color": look["base_color"], "bands": look["bands"]}
    if abs(look["saturation"] - 1.0) > 1e-6:
        out["saturation"] = look["saturation"]
    for key in OPTIONAL:
        node = look[key]
        if node.get("enabled"):
            out[key] = {k: v for k, v in node.items() if k != "enabled"}
    if look.get("source") == "blend":
        out["source"] = "blend"
    return out


def is_enabled(look, node):
    return bool(normalize(look)[node].get("enabled")) if node in OPTIONAL else True
