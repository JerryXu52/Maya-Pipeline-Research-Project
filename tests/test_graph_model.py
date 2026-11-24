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


class LayoutAndGroupsTest(unittest.TestCase):
    def chain(self):
        g = {"nodes": [], "links": []}
        v = gm.add_node(g, "ShaderNodeValue", (0, 0))
        m1 = gm.add_node(g, "ShaderNodeMath", (200, 0))
        m2 = gm.add_node(g, "ShaderNodeMath", (400, 0))
        e = gm.add_node(g, "ShaderNodeEmission", (600, 0))
        gm.connect(g, v, "Value", m1, "Value")
        gm.connect(g, m1, "Value", m2, "Value")
        gm.connect(g, m2, "Value", e, "Strength")
        return g, v, m1, m2, e

    def test_frame_and_unframe(self):
        g, v, m1, m2, e = self.chain()
        f = gm.join_in_frame(g, [m1, m2], "Maths")
        self.assertEqual([n["name"] for n in gm.children(g, f)], [m1, m2])
        gm.remove_from_frame(g, [m1])
        self.assertEqual([n["name"] for n in gm.children(g, f)], [m2])
        gm.remove_node(g, f)
        self.assertNotIn("parent", gm.node(g, m2))

    def test_reroute_keeps_the_connection(self):
        g, v, m1, m2, e = self.chain()
        r = gm.insert_reroute(g, [m1, "Value", m2, "Value"], (300, -50))
        self.assertIn([m1, "Value", r, "Input"], g["links"])
        self.assertIn([r, "Output", m2, "Value"], g["links"])

    def test_group_then_ungroup_restores_wiring(self):
        g, v, m1, m2, e = self.chain()
        before = sorted(map(tuple, g["links"]))
        gn = gm.make_group(g, g, [m1, m2], "Maths")
        grp = g["groups"]["Maths"]
        self.assertEqual([i["in_out"] for i in grp["interface"]], ["INPUT", "OUTPUT"])
        self.assertEqual(len([l for l in g["links"] if gn in (l[0], l[2])]), 2)
        self.assertIsNone(gm.node(g, m1))
        gm.ungroup(g, g, gn)
        self.assertNotIn("groups", g)
        self.assertEqual(sorted(map(tuple, g["links"])), before)


class LayoutTest(unittest.TestCase):
    def test_auto_layout_has_no_overlaps(self):
        g = {"nodes": [], "links": []}
        out = gm.add_node(g, "ShaderNodeEmission", (0, 0))
        prev = out
        for i in range(6):                     # a fan of math nodes feeding a chain
            m = gm.add_node(g, "ShaderNodeMath", (0, 0))
            gm.connect(g, m, "Value", prev if i % 2 == 0 else out, "Strength" if prev == out else "Value")
            prev = m
        gm.auto_layout(g)
        boxes = [(n["location"][0], n["location"][1] - gm.node_height(n), n["location"][0] + n.get("width", 140),
                  n["location"][1]) for n in g["nodes"]]
        for i, a in enumerate(boxes):
            for b in boxes[i + 1:]:
                overlap = a[0] < b[2] and b[0] < a[2] and a[1] < b[3] and b[1] < a[3]
                self.assertFalse(overlap)
        self.assertEqual(max(n["location"][0] for n in g["nodes"]), gm.node(g, out)["location"][0])
