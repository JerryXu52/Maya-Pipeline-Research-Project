"""Unit tests for editing a node graph as data (pure Python)."""
import os
import sys
import unittest

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
from toon_bridge import graph_model as gm  # noqa: E402


def small():
    g = {"nodes": [], "links": []}
    a = gm.add_node(g, "ShaderNodeValue", (0, 0))
    b = gm.add_node(g, "ShaderNodeMath", (200, 0))
    c = gm.add_node(g, "ShaderNodeMath", (400, 0))
    return g, a, b, c


class GraphModelTest(unittest.TestCase):
    def test_catalog_has_blender_menu(self):
        cats = [c for c, _ in gm.catalog()["menu"]]
        self.assertEqual(cats[:2], ["Input", "Shader"])
        self.assertIn("ShaderNodeMath", gm.catalog()["nodes"])

    def test_unique_names_like_blender(self):
        g, a, b, c = small()
        self.assertEqual((b, c), ("Math", "Math.001"))

    def test_connect_replaces_old_link(self):
        g, a, b, c = small()
        self.assertTrue(gm.connect(g, a, "Value", b, "Value"))
        self.assertTrue(gm.connect(g, c, "Value", b, "Value"))
        self.assertEqual(gm.links_into(g, b, "Value"), [[c, "Value", b, "Value"]])

    def test_bad_links_refused(self):
        g, a, b, c = small()
        self.assertFalse(gm.connect(g, b, "Value", b, "Value"))      # to itself
        self.assertFalse(gm.connect(g, a, "nope", b, "Value"))

    def test_remove_node_drops_its_links(self):
        g, a, b, c = small()
        gm.connect(g, a, "Value", b, "Value")
        gm.remove_node(g, a)
        self.assertEqual(g["links"], [])

    def test_set_values_and_settings(self):
        g, a, b, c = small()
        self.assertTrue(gm.set_prop(g, b, "operation", "MULTIPLY"))
        self.assertTrue(gm.set_input(g, b, "Value_001", 0.25))
        self.assertEqual(gm.node(g, b)["props"]["operation"]["value"], "MULTIPLY")


if __name__ == "__main__":
    unittest.main()
