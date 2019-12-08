module Control
(
	Op_i,
	Zero_i,
	Signal_o,
	flush_o
);

input  [6:0] Op_i;
input        Zero_i;
output [5:0] Signal_o;
output       flush_o;

assign flush_o = (Zero_i && Op_i[6]) ? 1 : 0;
assign Signal_o[5] = (Op_i[4]) ? 1 : Op_i[5];
assign Signal_o[4] = Op_i[4];
assign Signal_o[3] = (!Op_i[4] || !Op_i[5]) ? 1 : 0;
assign Signal_o[2] = (Op_i[6:4] == 3'b010) ? 1 : 0;
assign Signal_o[1] = (Op_i[5:4] != 2'b10) ? 1 : 0;
assign Signal_o[0] = (Op_i[5:4] == 2'b00) ? 1 : 0;

endmodule
