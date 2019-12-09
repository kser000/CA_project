module CPU
(
    clk_i, 
    start_i
);

// Ports
input         clk_i;
input         start_i;
// IF stage
MUX32 PC_MUX(
	.data1_i        (Add_PC.data_o),
	.data2_i        (beq_adder.data_o),
	.select_i       (control.flush_o),
	.data_o         ()
); 

PC PC(
    .clk_i          (clk_i),
    .start_i        (start_i),
    .PCWrite_i      (haz.PCWrite_o),
    .pc_i           (PC_MUX.data_o),
    .pc_o           ()
);

Instruction_Memory Instruction_Memory(
    .addr_i         (PC.pc_o),
    .instr_o        ()
);

Adder Add_PC(
	.data1_in       (PC.pc_o),
	.data2_in       (4),
	.data_o         ()
);

// IF_ID pipeline

IF_ID IF_ID(
	.clk_i          (clk_i),
	.IF_flush       (control.flush_o),
	.IF_IDWrite     (haz.IF_ID_Write_o),
	.PC_i           (PC.pc_o),
	.instr_i        (Instruction_Memory.instr_o),
	.PC_o           (),
	.instr_o        ()
);

// ID stage

hazard_detection haz(
	.ID_EX_MEMR_i   (ID_EX.WB_o[0]),
	.RS1_i          (IF_ID.instr_o[19:15]),
	.RS2_i          (IF_ID.instr_o[24:20]),
	.ID_EX_RD_i     (ID_EX.RDaddr_o),
	.PCWrite_o      (),
	.IF_ID_Write_o  (),
	.BubbleSignal_o ()
);

Control control(
	.Op_i           (IF_ID.instr_o[6:0]),
	.Zero_i         (equal.zero_o),
	.Signal_o       (),
	.flush_o        ()
);

Shift_left shift(
	.data_i         (IMM_gen.data_o),
	.data_o         ()
);

Sign_Extend IMM_gen(
	.data_i         (IF_ID.instr_o),
	.data_o         ()
);

equal equal(
	.data1_i        (Registers.RS1data_o),
	.data2_i        (Registers.RS2data_o),
	.zero_o         ()
);

MUX6 MUX_Control(
	.data1_i        (control.Signal_o),
	.data2_i        (6'b0),
	.select_i       (haz.BubbleSignal_o),
	.data_o         ()
);

Adder beq_adder(
	.data1_in       (shift.data_o),
	.data2_in       (IF_ID.PC_o),
	.data_o         ()
);

Registers Registers(
    .clk_i          (clk_i),
    .RS1addr_i      (IF_ID.instr_o[19:15]),
    .RS2addr_i      (IF_ID.instr_o[24:20]),
    .RDaddr_i       (MEM_WB.RDaddr_o),
    .RDdata_i       (MemtoReg.data_o),
    .RegWrite_i     (MEM_WB.RegWrite_o),
    .RS1data_o      (),
    .RS2data_o      ()
);

// ID_EX stage

ID_EX ID_EX(
	.clk_i          (clk_i),
	.WB_i           (MUX_Control.data_o[1:0]),
	.MEM_i          (MUX_Control.data_o[2]),
	.EX_i           (MUX_Control.data_o[5:3]),
	.RS1_i          (Registers.RS1data_o),
	.RS2_i          (Registers.RS2data_o),
	.IMM_i          (IMM_gen.data_o),
	.RS1addr_i      (IF_ID.instr_o[19:15]),
	.RS2addr_i      (IF_ID.instr_o[24:20]),
	.RDaddr_i       (IF_ID.instr_o[11:7]),
	.funct_i        ({IF_ID.instr_o[31:25],IF_ID.instr_o[14:12]}),
	.WB_o           (),
	.MEM_o          (),
	.ALUSrc_o       (),
	.ALUOp_o        (),
	.RS1_o          (),
	.RS2_o          (),
	.IMM_o          (),
	.RS1addr_o      (),
	.RS2addr_o      (),
	.RDaddr_o       (),
	.funct_o        ()
);

// EX stage 

MUX3_1 forwardA(
	.data1_i        (ID_EX.RS1_o),
	.data2_i        (MemtoReg.data_o),
	.data3_i        (EX_MEM.ALUout_o),
	.select_i       (forward.selectA_o),
	.data_o         ()
);

MUX3_1 forwardB(
	.data1_i        (ID_EX.RS2_o),
	.data2_i        (MemtoReg.data_o),
	.data3_i        (EX_MEM.ALUout_o),
	.select_i       (forward.selectB_o),
	.data_o         ()
);

MUX32 ALU_MUX(
	.data1_i        (forwardB.data_o),
	.data2_i        (ID_EX.IMM_o),
	.select_i       (ID_EX.ALUSrc_o),
	.data_o         ()
);

forward forward(	
	.RS1_i          (ID_EX.RS1addr_o),
	.RS2_i          (ID_EX.RS2addr_o),
	.EX_RD_i        (EX_MEM.RDaddr_o),
	.MEM_RD_i       (MEM_WB.RDaddr_o),
	.EX_WB_i        (EX_MEM.WB_o[1]),
	.MEM_WB_i       (MEM_WB.RegWrite_o),
	.selectA_o      (),
	.selectB_o      ()
);

ALU_Control ALU_Control(
	.funct_i        (ID_EX.funct_o),
	.ALUOp_i        (ID_EX.ALUOp_o),
	.ALUCtrl_o      ()
);

ALU ALU(
	.data1_i        (forwardA.data_o),
	.data2_i        (ALU_MUX.data_o),
	.ALUCtrl_i      (ALU_Control.ALUCtrl_o),
	.data_o         ()
);
 
// EX_MEM stage

EX_MEM EX_MEM(	
	.clk_i          (clk_i),
	.MEM_i          (ID_EX.MEM_o),
	.WB_i           (ID_EX.WB_o),
	.ALUout_i       (ALU.data_o),
	.RS2_i          (forwardB.data_o),
	.RDaddr_i       (ID_EX.RDaddr_o),
	.WB_o           (),
	.MEMW_o         (),
	.ALUout_o       (),
	.RS2_o          (),
	.RDaddr_o       ()
);

// MEM stage

Data_Memory Data_Memory(
    .clk_i          (clk_i),
    .addr_i         (EX_MEM.ALUout_o),
    .MemWrite_i     (EX_MEM.MEMW_o),
    .data_i         (EX_MEM.RS2_o),
    .data_o         ()
);

// MEM_WB stage

MEM_WB MEM_WB(
	.clk_i          (clk_i),
	.WB_i           (EX_MEM.WB_o),
	.Data_i         (Data_Memory.data_o),
	.ALUout_i       (EX_MEM.ALUout_o),
	.RDaddr_i       (EX_MEM.RDaddr_o),
	.RegWrite_o     (),
	.MemtoReg_o     (),
	.Data_o         (),
	.ALUout_o       (),
	.RDaddr_o       ()
);

// WB stage

MUX32 MemtoReg(
	.data1_i        (MEM_WB.ALUout_o),
	.data2_i        (MEM_WB.Data_o),
	.select_i       (MEM_WB.MemtoReg_o),
	.data_o         ()
);

endmodule

