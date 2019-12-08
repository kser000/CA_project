module equal
(
	data1_i,
	data2_i,
	zero_o
);

input [31:0] data1_i;
input [31:0] data2_i;
output       zero_o;

assign zero_o = (data1_i == data2_i) ? 1 : 0;

endmodule
