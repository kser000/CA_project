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
	.data1_i        (),
	.data2_i        (),
	.select_i       (),
	.data_o         ()
); 

PC PC(
    .clk_i          (),
    .start_i        (),
    .PCWrite_i      (),
    .pc_i           (),
    .pc_o           ()
);

Instruction_Memory Instruction_Memory(
    .addr_i         (),
    .instr_o        ()
);

Adder Add_PC(
	.data1_in       (),
	.data2_in       (),
	.data_o         ()
);

// IF_ID pipeline

IF_ID IF_ID(
	.clk_i          (),
	.IF_flush       (),
	.IF_IDWrite     (),
	.PC_i           (),
	.instr_i        (),
	.PC_o           (),
	.instr_o        ()
);

// ID stage

hazard_detection haz(
	.ID_EX_MEMR_i   (),
	.RS1_i          (),
	.RS2_i          (),
	.ID_EX_RD_i     (),
	.PCWrite_o      (),
	.IF_ID_Write_o  (),
	.BubbleSignal   ()
);
Registers Registers(
    .clk_i          (),
    .RS1addr_i      (),
    .RS2addr_i      (),
    .RDaddr_i       (),
    .RDdata_i       (),
    .RegWrite_i     (),
    .RS1data_o      (),
    .RS2data_o      ()
);

Data_Memory Data_Memory(
    .clk_i          (),

    .addr_i         (),
    .MemWrite_i     (),
    .data_i         (),
    .data_o         ()
);

endmodule

