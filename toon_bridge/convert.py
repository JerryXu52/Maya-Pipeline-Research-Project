"""Maya -> Blender conversion math.

Pure Python on purpose: no maya.cmds and no bpy here, so the same file is
imported by the Maya exporter, by blender/render.py, and by the unit tests.

Maya:    Y-up, centimetres, film back in inches, light intensity is unitless.
Blender: Z-up, metres,      sensor in millimetres, sun strength is W/m^2.
"""
import math

CM_TO_M = 0.01
INCH_TO_MM = 25.4

# Rotating the world +90 degrees about X turns Maya's Y-up into Blender's Z-up:
#   Maya (x, y, z)  ->  Blender (x, -z, y)
# Maya "up" (0,1,0) becomes Blender "up" (0,0,1), and Maya +Z (towards the
# front camera) becomes Blender -Y (towards Blender's front view).
# This is the same conversion Blender's Alembic importer applies to meshes,
# so cameras and lights built from it line up with the imported geometry.


def axis(v):
    """Convert a direction (no unit change)."""
    x, y, z = v
    return (x, -z, y)


def point(p):
    """Convert a position: axis swap plus cm -> m."""
    x, y, z = axis(p)
    return (x * CM_TO_M, y * CM_TO_M, z * CM_TO_M)


def matrix(m):
    """Convert a Maya world matrix to Blender rows for mathutils.Matrix.

    `m` is the 16 floats from getAttr('.worldMatrix'). Maya stores matrices
    row-major with row vectors: rows 0-2 are the object's X/Y/Z axes in world
    space, row 3 is the translation. Blender's mathutils uses column vectors,
    so the axes become columns.

    Cameras and lights look down their local -Z in BOTH programs, so only the
    world frame changes; local axes are carried across unchanged.
    """
    ax = [axis(m[0:3]), axis(m[4:7]), axis(m[8:11])]
    t = point(m[12:15])
    return [
        [ax[0][0], ax[1][0], ax[2][0], t[0]],
        [ax[0][1], ax[1][1], ax[2][1], t[1]],
        [ax[0][2], ax[1][2], ax[2][2], t[2]],
        [0.0, 0.0, 0.0, 1.0],
    ]


# Maya camera.filmFit enum
FIT_FILL, FIT_HORIZONTAL, FIT_VERTICAL, FIT_OVERSCAN = 0, 1, 2, 3


def sensor(h_aperture_in, v_aperture_in, film_fit, res_w, res_h):
    """Return (sensor_fit, sensor_width_mm, sensor_height_mm) for Blender.

    Maya fits the film back to the render resolution in four ways; Blender
    only has HORIZONTAL / VERTICAL, so Fill and Overscan are resolved here by
    comparing the film-back aspect with the image aspect.
      Fill:     the image sits inside the film back  -> fit the tighter side
      Overscan: the film back sits inside the image  -> fit the looser side
    """
    w_mm = h_aperture_in * INCH_TO_MM
    h_mm = v_aperture_in * INCH_TO_MM
    film_aspect = w_mm / h_mm
    image_aspect = float(res_w) / float(res_h)
    if film_fit == FIT_HORIZONTAL:
        fit = "HORIZONTAL"
    elif film_fit == FIT_VERTICAL:
        fit = "VERTICAL"
    elif film_fit == FIT_FILL:
        fit = "HORIZONTAL" if image_aspect >= film_aspect else "VERTICAL"
    else:  # overscan
        fit = "VERTICAL" if image_aspect >= film_aspect else "HORIZONTAL"
    return fit, w_mm, h_mm


def sun_strength(intensity):
    """Maya directional light intensity -> Blender sun strength (W/m^2).

    A Maya Lambert lit head-on by intensity 1.0 returns its own colour.
    Blender's diffuse BSDF returns colour * strength / pi, so strength must be
    intensity * pi to give the same brightness (checked by tests/test_light_match).
    """
    return intensity * math.pi


def point_power(intensity, decay_rate):
    """Maya point/spot intensity -> Blender point/spot power in watts.

    Approximate. Maya's "no decay" light has no physical equivalent; we treat
    it as if the light were 1 m away from the subject. Quadratic decay in Maya
    is in cm, so the 1/d^2 term differs by 100^2 between programs.
    A Blender point light of power P gives irradiance P / (4 pi d^2) at d metres.
    """
    if decay_rate == 2:      # quadratic: I / d_cm^2 = I / (10000 d_m^2)
        return intensity * 4 * math.pi / 10000.0 * math.pi
    if decay_rate == 1:      # linear: no exact match, use 1 m reference
        return intensity / 100.0 * 4 * math.pi * math.pi
    return intensity * 4 * math.pi * math.pi   # no decay, 1 m reference


def clip(near_cm, far_cm):
    return near_cm * CM_TO_M, far_cm * CM_TO_M
