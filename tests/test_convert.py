"""Unit tests for the conversion math. Run with any Python 3:  python3 -m unittest discover tests"""
import math
import os
import sys
import unittest

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
from toon_bridge import convert  # noqa: E402


class ConvertTest(unittest.TestCase):
    def test_up_axis(self):
        self.assertEqual(convert.axis((0, 1, 0)), (0, 0, 1))

    def test_point_units(self):
        x, y, z = convert.point((100, 200, 300))
        self.assertAlmostEqual(x, 1.0)
        self.assertAlmostEqual(y, -3.0)
        self.assertAlmostEqual(z, 2.0)

    def test_identity_camera_looks_along_blender_plus_y(self):
        # A Maya camera at rest looks down Maya -Z. In Blender that must be +Y.
        m = [1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1]
        rows = convert.matrix(m)
        local_z = (rows[0][2], rows[1][2], rows[2][2])
        look = tuple(-c for c in local_z)
        self.assertEqual(look, (0, 1, 0))

    def test_translation_column(self):
        m = [1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 10, 20, 30, 1]
        rows = convert.matrix(m)
        self.assertAlmostEqual(rows[0][3], 0.1)
        self.assertAlmostEqual(rows[1][3], -0.3)
        self.assertAlmostEqual(rows[2][3], 0.2)

    def test_sensor_fill(self):
        # 36x24 mm film back, 16:9 image -> image is wider -> horizontal fit
        fit, w, h = convert.sensor(36 / 25.4, 24 / 25.4, convert.FIT_FILL, 1920, 1080)
        self.assertEqual(fit, "HORIZONTAL")
        self.assertAlmostEqual(w, 36)
        # square image inside a 3:2 film back -> vertical fit
        fit, _, _ = convert.sensor(36 / 25.4, 24 / 25.4, convert.FIT_FILL, 1000, 1000)
        self.assertEqual(fit, "VERTICAL")

    def test_sun(self):
        self.assertAlmostEqual(convert.sun_strength(1.0), math.pi)


if __name__ == "__main__":
    unittest.main()
