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
assign Signal_o[5:0] = (Op_i == 51) ? 6'b100010 :
					   (Op_i == 19) ? 6'b111010 :
				   	   (Op_i ==  3) ? 6'b001011 : 
					   (Op_i == 35) ? 6'b001100 : 6'b010000;

endmodule
