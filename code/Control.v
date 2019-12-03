module Control
(
	Op_i,
	ALUOp_o,
	ALUSrc_o,
	RegWrite_o
);

input [6:0] Op_i;
output [1:0] ALUOp_o;
output ALUSrc_o;
output RegWrite_o;

assign ALUOp_o = 2'b01;
assign ALUSrc_o = ~Op_i[5];
assign RegWrite_o = 1;

endmodule
