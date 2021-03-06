"""Run the testbench of the "zero_pad" module."""

from os.path import join, dirname
from random import randint

import numpy as np
from vunit import VUnit

from fixfloat import v_float2fixedint
from fixfloat import random_fixed_array
from cnn_reference import flatten, zero_pad


def create_arrays(root, w, h, ch):
    id_ = "one" if ch == 1 else "multiple"

    a_rand = random_fixed_array((1, ch, h, w), 8, 0)
    a_in = v_float2fixedint(a_rand, 8, 0)
    np.savetxt(join(root, "src", "input_%s.csv" % id_),
               flatten(a_in), delimiter=", ", fmt="%3d")

    a_out = v_float2fixedint(zero_pad(a_rand), 8, 0)
    np.savetxt(join(root, "src", "output_%s.csv" % id_),
               flatten(a_out), delimiter=", ", fmt="%3d")


def create_test_suite(prj):
    root = dirname(__file__)

    prj.add_array_util()
    unittest = prj.add_library("unittest", allow_duplicate=True)
    unittest.add_source_files(join(root, "src", "*.vhd"))
    tb_zero_pad = unittest.entity("tb_zero_pad")

    config_multiple_ch = randint(1, 32), randint(1, 32), randint(2, 16)
    config_one_ch = randint(1, 32), randint(1, 32), 1
    for width, height, channel in (config_one_ch, config_multiple_ch):
        id_ = "one" if channel == 1 else "multiple"
        tb_zero_pad.add_config(name="%s_channel" % id_,
                               generics={"id": id_,
                                         "C_IMG_WIDTH": width,
                                         "C_IMG_HEIGHT": height,
                                         "C_IMG_DEPTH": channel},
                               pre_config=create_arrays(root, width, height,
                                                        channel))


if __name__ == "__main__":
    UI = VUnit.from_argv()
    create_test_suite(UI)
    UI.main()
