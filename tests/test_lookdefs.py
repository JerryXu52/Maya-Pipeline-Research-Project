"""Unit tests for the look template (pure Python)."""
import json
import os
import sys
import unittest

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
from toon_bridge import lookdefs  # noqa: E402

LOOKS = os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), "blender", "looks.json")


class LookdefsTest(unittest.TestCase):
    def test_every_library_look_normalizes(self):
        looks = {k: v for k, v in json.load(open(LOOKS)).items() if not k.startswith("_")}
        for name, look in looks.items():
            full = lookdefs.normalize(look)
            for key in lookdefs.DEFAULTS:
                self.assertIn(key, full, name)

    def test_old_pop_format_becomes_halftone_nodes(self):
        old = {"type": "pop", "base_color": "maya", "dots_per_screen": 75, "dots_below": 0.6,
               "max_dot": 0.5, "hatch_below": 0.2, "shadow_mult": [0.5, 0.4, 0.9], "lit_above": 0.45,
               "rim": {"threshold": 0.66, "color": [0, 1, 1]}}
        full = lookdefs.normalize(old)
        self.assertTrue(full["halftone"]["enabled"])
        self.assertEqual(full["halftone"]["per_screen"], 75)
        self.assertTrue(full["hatching"]["enabled"])
        self.assertEqual(full["rim"]["mode"], "replace")
        self.assertEqual(full["bands"][1][0], 0.45)

    def test_old_cel_nodes_are_on_when_present(self):
        full = lookdefs.normalize({"bands": [[0, [1, 1, 1]]], "rim": {"threshold": 0.7, "color": [1, 1, 1]}})
        self.assertTrue(full["rim"]["enabled"])
        self.assertEqual(full["rim"]["mode"], "add")
        self.assertFalse(full["halftone"]["enabled"])

    def test_compact_round_trip(self):
        full = lookdefs.normalize({"bands": [[0.5, [1, 0, 0]], [0, [0, 0, 1]]],
                                   "halftone": {"per_screen": 40}})
        self.assertEqual(full["bands"][0][0], 0.0)          # sorted
        again = lookdefs.normalize(lookdefs.compact(full))
        self.assertEqual(again, full)
        self.assertNotIn("specular", lookdefs.compact(full))


if __name__ == "__main__":
    unittest.main()
