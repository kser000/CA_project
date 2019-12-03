module forward
(
	RS1_i,
	RS2_i,
	EX_RD_i,
	MEM_RD_i,
	EX_WB_i,
	MEM_WB_i,
	selectA_o,
	selectB_o
);

input  [4:0] RS1_i;
input  [4:0] RS2_i;
input  [4:0] EX_RD_i;
input  [4:0] MEM_RD_i;
input        EX_WB_i;
input        MEM_WB_i;
output [1:0] selectA_o;
output [1:0] selectB_o;

assign selectA_o = (EX_WB_i && EX_RD_i == RS1_i && EX_RD_i != 0) ? 2'b10:
				   (MEM_WB_i && MEM_RD_i == RS1_i && MEM_RD_i != 0) ? 2'b01 : 2'b00;
assign selectB_o = (EX_WB_i && EX_RD_i == RS2_i && EX_RD_i != 0) ? 2'b10:
				   (MEM_WB_i && MEM_RD_i == RS2_i && MEM_RD_i != 0) ? 2'b01 : 2'b00;

endmodule
