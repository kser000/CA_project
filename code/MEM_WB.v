module  MEM_WB
(
	clk_i,
	WB_i,
	Data_i,
	ALUout_i.
	RDaddr_i,
	RegWrite_o,
	MemtoReg_o,
	Data_o,
	ALUout_o,
	RDaddr_o
);

input         clk_i;
input  [ 1:0] WB_i;
input  [31:0] Data_i;
input  [31:0] ALUout_i;
input  [ 4:0] RDaddr_i;
output        RegWrite_o;
output        MemtoReg_o;
output [31:0] Data_o;
output [31:0] ALUout_o;
output [ 4:0] RDaddr_o;

reg    [ 1:0] WB;
reg    [31:0] Data;
reg    [31:0] ALUout;
reg    [ 4:0] RDaddr;

assign RegWrite_o = WB[1];
assign MemtoReg_o = WB[0];
assign Data_o = Data;
assign ALUout_o = ALUout;
assign RDaddr_o = RDaddr;

always@(posedge clk_i) begin
	WB <= WB_i;
	Data <= Data_i;
	ALUout <= ALUout_i;
	RDaddr <= RDaddr_i;
end

endmodule 
