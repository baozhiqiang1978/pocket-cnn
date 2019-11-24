library ieee;
	use ieee.std_logic_1164.all;

package cnn_parameter is
	constant C_DATA_TOTAL_BITS : integer range 1 to 16 := 8;

	constant C_IMG_WIDTH_IN : integer range 2 to 512 := 24;
	constant C_IMG_HEIGHT_IN : integer range 2 to 512 := 48;

	constant C_PE : integer range 1 to 100 := 4;

	constant C_SCALE : integer range 0 to 256 := 128;

	-- 0 - preprocessing, 1 to C_PE - pe, C_PE+1 - average
	constant C_RELU : std_logic_vector(1 to C_PE) := "1111";
	constant C_LEAKY_RELU : std_logic_vector(1 to C_PE) := "0000";

	type t_pad_array is array (1 to C_PE) of integer range 0 to 1;
	constant C_PAD: t_pad_array := (1, 1, 0, 0);

	type t_win_array is array (1 to C_PE) of integer range 0 to 3;
	constant C_CONV_KSIZE : t_win_array := (3, 3, 1, 1);
	constant C_CONV_STRIDE : t_win_array := (1, 1, 1, 1);
	constant C_WIN_POOL : t_win_array := (2, 2, 0, 0);
	constant C_POOL_STRIDE : t_win_array := (2, 2, 0, 0);

	type t_ch_array is array (0 to C_PE) of integer range 1 to 512;
	constant C_CH: t_ch_array := (1, 16, 32, 64, 2);

	-- 0 - bitwidth data, 1 - bitwidth frac data in, 2 - bitwidth frac data out
	-- 3 - bitwidth weights, 4 - bitwidth frac weights
	type t_bitwidth_array is array (1 to C_PE, 0 to 4) of integer range 0 to C_DATA_TOTAL_BITS;
	constant C_BITWIDTH: t_bitwidth_array := (
		1 => (8, 5, 4, 8, 5),
		2 => (8, 4, 3, 8, 7),
		3 => (8, 3, 3, 8, 7),
		4 => (8, 3, 2, 8, 6));

	type t_weights_array is array (1 to C_PE) of string(1 to 44);
	constant STR_WEIGHTS_INIT : t_weights_array := (
		"top/src/test_input_zeros/weights/W_conv1.txt",
		"top/src/test_input_zeros/weights/W_conv2.txt",
		"top/src/test_input_zeros/weights/W_conv3.txt",
		"top/src/test_input_zeros/weights/W_conv4.txt");
	constant STR_BIAS_INIT : t_weights_array := (
		"top/src/test_input_zeros/weights/B_conv1.txt",
		"top/src/test_input_zeros/weights/B_conv2.txt",
		"top/src/test_input_zeros/weights/B_conv3.txt",
		"top/src/test_input_zeros/weights/B_conv4.txt");
end cnn_parameter;
