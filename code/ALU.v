module ALU
(
	data1_i,
	data2_i,
	ALUCtrl_i,
	data_o,
);

input [31:0] data1_i;
input [31:0] data2_i;
input [2:0] ALUCtrl_i;
output [31:0] data_o;
assign data_o = (ALUCtrl_i == 0) ? data1_i + data2_i :
				(ALUCtrl_i == 1) ? data1_i * data2_i :
				(ALUCtrl_i == 2) ? data1_i - data2_i :
				(ALUCtrl_i == 6) ? data1_i | data2_i : data1_i & data2_i;

endmodule
