module IF_ID
(
	clk_i,
	IF_flush,
	IF_IDWrite,
	PC_i,
	instr_i,
	PC_o,
	instr_o
);

input clk_i;
input IF_flush;
input IF_IDWrite;
input [31:0] PC_i;
input [31:0] instr_i;
output [31:0] PC_o;
output [31:0] instr_o;

reg [31:0] PC;
reg [31:0] instruction;

assign PC_o = PC;
assign instr_o = instruction;

always@(posedge clk_i) begin
	if(IF_IDWrite && !IF_flush) begin
		PC <= PC_i;
		instruction <= instr_i;
	end
	else if(IF_flush)begin
		instruction <= 0;
	end
end

endmodule
