module MUX3_1
(
	data1_i,
	data2_i,
	data3_i,
	select_i,
	data_o
);

input  [31:0] data1_i;
input  [31:0] data2_i;
input  [31:0] data3_i;
input  [ 1:0] select_i;
output [31:0] data_o;

assign data_o = (select_i == 0) ? data1_i:
				(select_i == 1) ? data2_i: data3_i;

endmodule
