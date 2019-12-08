module EX_MEM
(
	clk_i,
	MEM_i,
	WB_i,
	ALUout_i,
	RS2_i,
	RDaddr_i,
	WB_o,
	MEMW_o,
	ALUout_o,
	RS2_o,
	RDaddr_o,
);

input         clk_i;
input         MEM_i;
input  [ 1:0] WB_i;
input  [31:0] ALUout_i;
input  [31:0] RS2_i;
input  [ 4:0] RDaddr_i;
output [ 1:0] WB_o;
output        MEMR_o;
output        MEMW_o;
output [31:0] ALUout_o;
output [31:0] RS2_o;
output [ 4:0] RDaddr_o;

reg           MEM;
reg    [ 1:0] WB;
reg    [31:0] ALUout;
reg    [31:0] RS2;
reg    [ 4:0] RDaddr;

assign WB_o = WB;
assign MEMW_o = MEM;
assign ALUout_o = ALUout;
assign RS2_o = RS2;
assign RDaddr_o = RDaddr;

always@(posedge clk_i) begin 
	MEM <= MEM_i;
	WB  <= WB_i;
	ALUout <= ALUout_i;
	RS2 <= RS2_i;
	RDaddr = RDaddr_i;
end 

endmodule
