module ALU_Control
(
	funct_i,
	ALUOp_i,
	ALUCtrl_o
);

input [9:0] funct_i;
input [1:0] ALUOp_i;
output [2:0] ALUCtrl_o;

assign ALUCtrl_o[2:0] = (ALUOp_i == 2'b11 || ALUOp_i == 2'b00) ? 3'b000:
					    (funct_i == 0) ? 3'b000:
						(funct_i == 256) ? 3'b010:
						(funct_i == 8) ? 3'b001:
						(funct_i == 7) ? 3'b111:
						(funct_i == 6) ? 3'b110: 3'b000;
endmodule
