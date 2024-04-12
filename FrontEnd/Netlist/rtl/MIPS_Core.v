module MIPS_Core (
    clk, instructionInput, instructionWriteEnable, writeAddr, PC, PC_set, ALU_result, writeDataReg_WB, instruction_ID,
    readData1_EX, readData2_EX, PC_ID, PC_incr4_ID, PC_incr4_EX, MemtoReg_MEM, RegWrite_MEM, RegWrite_ID, writeAddr_WB,
    writeAddr_EX, writeAddr_ID
);
    input clk;
    input [31:0] instructionInput;
    input instructionWriteEnable;
    input [10:0] writeAddr;
    input [31:0] PC;
    input PC_set;

    output wire [31:0] instruction_ID;
    wire [31:0] PC1;
    output wire [31:0] PC_ID;
    output wire [31:0] PC_incr4_ID;

    wire [31:0] JumpAddr_ID;
    wire RegDst_ID, Jump_ID, Branch_ID, MemRead_ID, MemtoReg_ID;
    wire [1:0] ALUOp_ID;
    wire MemWrite_ID;
    wire ALUSrc_ID;
    output wire RegWrite_ID;

    output wire [31:0] readData1_EX;
    output wire [31:0] readData2_EX;
    output wire [31:0] PC_incr4_EX;
    wire [31:0] JumpAddr_EX;
    wire [1:0] ALUOp_EX;
    wire [15:0] immediate_EX;
    wire Jump_EX;
    wire Branch_EX;
    wire MemRead_EX;
    wire MemtoReg_EX;
    wire MemWrite_EX;
    wire ALUSrc_EX;
    output wire [4:0] writeAddr_EX;
    wire [31:0] immediate_extended_EX;
    wire [3:0] ALU_sel;
    wire RegWrite_EX;

    wire [31:0] readData_MEM;
    output wire MemtoReg_MEM;
    output wire RegWrite_MEM;
    wire [4:0] writeAddr_MEM;
    wire [31:0] ALU_result_MEM;
    wire [31:0] PC_next_MEM;

    

    output wire [4:0] writeAddr_ID;
    output wire [4:0] writeAddr_WB;

    // wire RegWrite_WB;
    
    assign PC1 = (PC_set == 1'b1) ? PC : PC_incr4_ID;

    Instruction_Memory instr_mem(.writeAddr(writeAddr), .PC(PC1), .instructionInput(instructionInput), 
    .writeEnable(instructionWriteEnable), .clk(clk), .instructionOutput(instruction_ID));
    PC_Reg pc_reg(.D(PC1), .Q(PC_ID) , .clk(clk));

    // ID----stage---starts---here-----------------------------------
    // REGFILE and Control unit in this stage
    assign PC_incr4_ID = PC_ID + 4;
    assign JumpAddr_ID = {PC_incr4_ID[31:28],instruction_ID[25:0], 2'b00};
    
    
    Control control(.opcode(instruction_ID[31:26]), .RegDst(RegDst_ID), .Jump(Jump_ID), .Branch(Branch_ID), .MemRead(MemRead_ID), 
                .MemtoReg(MemtoReg_ID), .ALUOp(ALUOp_ID), .MemWrite(MemWrite_ID),
                .ALUSrc(ALUSrc_ID), .RegWrite(RegWrite_ID));
    
    output wire [31:0] writeDataReg_WB;
    
    assign writeAddr_ID = (RegDst_ID == 1'b1) ? instruction_ID[15:11]:instruction_ID[20:16];

    RegFile32x32 reg_file(.readAddr1(instruction_ID[25:21]), .readAddr2(instruction_ID[20:16]), .writeAddr(writeAddr_WB), 
        .writeData(writeDataReg_WB), .RegWrite(RegWrite_MEM), 
        .clk(clk), .readData1(readData1_EX), .readData2(readData2_EX));
    
    Reg_ID2EX reg_ID2EX(.clk(clk), .PC_incr4_ID(PC_incr4_ID), .PC_incr4_EX(PC_incr4_EX), 
    .JumpAddr_ID(JumpAddr_ID),
    .JumpAddr_EX(JumpAddr_EX),
    .ALUOp_ID(ALUOp_ID),
    .ALUOp_EX(ALUOp_EX),
    .immediate_ID(instruction_ID[15:0]), 
    .immediate_EX(immediate_EX),
    .Jump_ID(Jump_ID),
    .Jump_EX(Jump_EX),
    .Branch_ID(Branch_ID),
    .Branch_EX(Branch_EX),
    .MemRead_ID(MemRead_ID),
    .MemRead_EX(MemRead_EX),
    .MemtoReg_ID(MemtoReg_ID),
    .MemtoReg_EX(MemtoReg_EX),
    .MemWrite_ID(MemWrite_ID),
    .MemWrite_EX(MemWrite_EX),
    .ALUSrc_ID(ALUSrc_ID),
    .ALUSrc_EX(ALUSrc_EX),
    .writeAddr_ID(writeAddr_ID),
    .writeAddr_EX(writeAddr_EX),
    .RegWrite_ID(RegWrite_ID),
    .RegWrite_EX(RegWrite_EX)
);

    // EXE---stage---starts---here---------------------------------
    

    Sign_Extend sign_ext(.in(immediate_EX), .Unsigned(1'b0), .out(immediate_extended_EX)); 
    wire [31:0] ALUdata2;
    assign ALUdata2 = (ALUSrc_EX == 1'b1) ? immediate_extended_EX: readData2_EX;
    ALU_Control alu_ctrl(.funct(immediate_EX[5:0]), .ALUOp(ALUOp_EX), .out(ALU_sel));
    output wire [31:0] ALU_result;
    wire zero;

    ALU(.A(readData1_EX), .B(ALUdata2), .control(ALU_sel), .S(ALU_result), .carryout(), .zero(zero), .overflow());

    wire [31:0] branchAddr;
    assign branchAddr = PC_incr4_EX + {immediate_extended_EX[29:0], 2'b00};
    wire Branch;
    assign Branch = zero & Branch_EX;
    wire [31:0] BranchedAddr;
    assign BranchedAddr = (Branch == 1'b1) ? branchAddr : PC_incr4_EX;
    wire [31:0] PC_next_EX;
    assign PC_next_EX = (Jump_EX == 1'b1) ? JumpAddr_EX:BranchedAddr;


    Data_Memory_16384x32 data_memory(
    .addr(ALU_result), .writeData(readData2_EX), 
    .MemWrite(MemWrite_EX), .MemRead(MemRead_EX), .clk(clk), .readData(readData_MEM));

    Reg_EX2MEM reg_EX2MEM(
    .clk(clk), .PC_next_EX(PC_next_EX),
    .PC_next_MEM(PC_next_MEM),
    .MemtoReg_EX(MemtoReg_EX),
    .MemtoReg_MEM(MemtoReg_MEM),
    .RegWrite_EX(RegWrite_EX),
    .RegWrite_MEM(RegWrite_MEM),
    .writeAddr_EX(writeAddr_EX),
    .writeAddr_MEM(writeAddr_WB),
    .ALU_result_EX(ALU_result),
    .ALU_result_MEM(ALU_result_MEM));

    // MEM---stage---starts---here---------------------------------
    


    assign writeDataReg_WB = (MemtoReg_MEM == 1'b1) ? readData_MEM:ALU_result_MEM;








    






endmodule