module ID_EX
(
	clk_i,
	WB_i,
	MEM_i,
	EX_i,
	RS1_i,
	RS2_i,
	IMM_i,
	RS1addr_i,
	RS2addr_i,
	RDaddr_i,
	WB_o,
	MEM_o,
	ALUSrc_o,
	ALUOp_o,
	RS1_o,
	RS2_o,
	IMM_o,
	RS1addr_o,
	RS2addr_o,
	RDaddr_o
)

input           clk_i;
input  [ 1:0]   WB_i;
input  [ 1:0]   MEM_i;
input  [ 2:0]   EX_i;
input  [31:0]   RS1_i;
input  [31:0]   RS2_i;
input  [31:0]   IMM_i;
input  [ 4:0]   RS1addr_i;
input  [ 4:0]   RS2addr_i;
input  [ 4:0]   RDaddr_i;
output [ 1:0]   WB_o;
output [ 1:0]   MEM_o;
output          ALUSrc_o;
output [ 1:0]   ALUOp_o;
output [31:0]   RS1_o;
output [31:0]   RS2_o;
output [31:0]   IMM_o;
output [ 4:0]   RS1addr_o;
output [ 4:0]   RS2addr_o;
output [ 4:0]   RDaddr_o;

reg    [ 1:0]   WB;
reg    [ 1:0]   MEM;
reg    [ 2:0]   EX;
reg    [31:0]   RS1;
reg    [31:0]   RS2;
reg    [31:0]   IMM;
reg    [ 4:0]   RS1_addr;
reg    [ 4:0]   RS2_addr;
reg    [ 4:0]   RD_addr;

assign WB_o = WB;
assign MEM_o = MEM;
assign ALUSrc_o = EX[0];
assign ALUOp_o = EX[2:1];
assign RS1_o = RS1;
assign RS2_o = RS2;
assign IMM_o = IMM;
assign RS1addr_o = RS1_addr;
assign RS2addr_o = RS2_addr;
assign RDaddr_o = RD_addr;

always@(posedge clk_i) begin
	WB <= WB_i;
	MEM <= MEM_i;
	EX <= EX_i;
	RS1 <= RS1_i;
	RS2 <= RS2_i;
	IMM <= IMM_i;
	RS1_addr <= RS1addr_i;
	RS2_addr <= RS2addr_i;
	RD_addr <= RDaddr_i;
end

endmodule

