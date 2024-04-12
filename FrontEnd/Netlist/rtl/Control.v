module Control(opcode, RegDst, Jump, Branch, MemRead, 
                MemtoReg, ALUOp, MemWrite,
                ALUSrc, RegWrite);
input [5:0] opcode;
output reg RegDst;
output reg Jump;
output reg Branch, MemRead;
output reg MemtoReg;
output reg [1:0] ALUOp;
output reg MemWrite;
output reg ALUSrc, RegWrite;

always @(*) begin
    RegDst = 1'b0;
    Jump = 1'b0;
    Branch = 1'b0;
    MemRead = 1'b0;
    MemtoReg = 1'b0;
    ALUOp = 2'b00;
    MemWrite = 1'b0;
    ALUSrc = 1'b0;
    RegWrite = 1'b0;

    case(opcode)
        6'b000000:begin 
            //R-type, let funct decide the alu operation
            RegDst=1'b1;
            ALUOp = 2'b10;
            RegWrite = 1'b1;
        end
        6'b000010:begin //2 jump
            // j/immediate
            // PC=JumpAddr, JumpAddr = {PC[31:28], address, 2’b0 }
            RegDst = 1'b0; // dont care
            Jump = 1'b1; 
            Branch = 1'b0; //dont care
            MemRead = 1'b1; //dont care
            MemtoReg = 1'b0; // don't care
            ALUOp = 2'b01; // don't care
            MemWrite = 1'b0; 
            ALUSrc = 1'b0;
            RegWrite = 1'b0;
        end
        6'b000011:begin //3 jump and link
            //jal/immediate
            //R[31]=PC+4;
        end
        6'b000100:begin //4
            // beq/rs/rt/BranchAddr
            // if(R[rs]==R[rt]) PC=PC+4+BranchAdd
            RegDst = 1'b0; // This is not cared in branch
            Jump = 1'b0;
            Branch = 1'b1;
            MemRead = 1'b0;//dont care
            MemtoReg = 1'b0;// don't care
            ALUOp = 2'b01; // substract. This is cared!
            MemWrite = 1'b0; 
            ALUSrc = 1'b0;
            RegWrite = 1'b0;
        end
        6'b000101:begin //5
            // bne/rs/rt/BranchAddr
            // if(R[rs]!=R[rt]) PC=PC+4+BranchAdd
        end
        6'b000110:begin //6
            //
        end
        6'b000111:begin //7
            //
        end
        6'b001000:begin //8
            // addi/rs/rt/immediate
            // R[rt]=R[rs]+SignExtImm
            RegDst = 1'b0;
            Jump = 1'b0;
            Branch = 1'b0;
            MemRead = 1'b0;
            MemtoReg = 1'b0;
            ALUOp = 2'b00;
            MemWrite = 1'b0;
            ALUSrc = 1'b1;
            RegWrite = 1'b1;
        end
        6'b001001:begin //addiu
            // addiu/rs/rt/immediate
            // R[rt]=R[rs]+SignExtImm
            RegDst = 1'b0;
            Jump = 1'b0;
            Branch = 1'b0;
            MemRead = 1'b0;
            MemtoReg = 1'b0;
            ALUOp = 2'b00;
            MemWrite = 1'b0;
            ALUSrc = 1'b1;
            RegWrite = 1'b1;
        end
        6'b001010:begin //a, not implemented
            // Warning！This operation has not been implemented. 
            // slti/rs/rt/immediate
            // R[rt]=(R[rs]<SignExtImm)?1:0
            // 
            // RegDst = 1'b0;
            // Jump = 1'b0;
            // Branch = 1'b0;
            // MemRead = 1'b0;
            // MemtoReg = 1'b0;
            // ALUOp = 2'b11;
            // MemWrite = 1'b0;
            // ALUSrc = 1'b1;
            // RegWrite = 1'b1;
            // Unsigned = 1'b0;
        end
        6'b001011:begin //b, not implemented
            // Warning！This operation has not been implemented. 
            // sltiu/rs/rt/immediate
            // R[rt]=(R[rs]<SignExtImm)?1:0
            // 
            // RegDst = 1'b0;
            // Jump = 1'b0;
            // Branch = 1'b0;
            // MemRead = 1'b0;
            // MemtoReg = 1'b0;
            // ALUOp = 2'b11;
            // MemWrite = 1'b0;
            // ALUSrc = 1'b1;
            // RegWrite = 1'b1;
            // Unsigned = 1'b1;
        end
        6'b001100:begin //c, not implemented
            // Warning！This operation has not been implemented. Comment out when implemented
            // andi/rs/rt/immediate
            // ALUOp = 11 is to decide the ALU control Output
            // RegDst = 1'b0;
            // Jump = 1'b0;
            // Branch = 1'b0;
            // MemRead = 1'b0;
            // MemtoReg = 1'b0;
            // ALUOp = 2'b11;
            // MemWrite = 1'b0;
            // ALUSrc = 1'b1;
            // RegWrite = 1'b1;
            // Unsigned = 1'b1;
        end
        6'b001101:begin //d, not implemented
            // Warning！This operation has not been implemented. Comment out when implemented
            // ori/rs/rt/immediate
            // ALUOp = 11 is to decide the ALU control Output
            // RegDst = 1'b0;
            // Jump = 1'b0;
            // Branch = 1'b0;
            // MemRead = 1'b0;
            // MemtoReg = 1'b0;
            // ALUOp = 2'b11;
            // MemWrite = 1'b0;
            // ALUSrc = 1'b1;
            // RegWrite = 1'b1;
            // Unsigned = 1'b1;
        end
        6'b001110:begin //e, not implemented
            // Warning！This operation has not been implemented. Comment out when implemented
            // xori/rs/rt/immediate
            // ALUOp = 11 is to decide the ALU control Output
            // RegDst = 1'b0;
            // Jump = 1'b0;
            // Branch = 1'b0;
            // MemRead = 1'b0;
            // MemtoReg = 1'b0;
            // ALUOp = 2'b11;
            // MemWrite = 1'b0;
            // ALUSrc = 1'b1;
            // RegWrite = 1'b1;
            // Unsigned = 1'b1;
        end
        6'b001111:begin //f, not implemented
            // lui/rs/rt/immediate
            //R[rt]={imm,16’b0}
        end
        6'b010000:begin //10, not implemented
            //
        end
        6'b100000:begin //20, not implemented load byte
            //lb/rs/rt/immediate
            //R[rt]={24’b0, M[R[rs]+SignExtImm](7:0)}
        end
        6'b100011:begin //23, load word
            //lw/rs/rt/immediate
            //R[rt]=M[R[rs]+SignExtImm]
            RegDst = 1'b0;
            Jump = 1'b0;
            Branch = 1'b0;
            MemRead = 1'b1;
            MemtoReg = 1'b1;
            ALUOp = 2'b00; // ALU add
            MemWrite = 1'b0;
            ALUSrc = 1'b1;
            RegWrite = 1'b1;
        end
        6'b100100:begin //24, not implemented load byte unsigned
            //lb/rs/rt/immediate
            //R[rt]={24’b0, M[R[rs]+ZeroExtImm](7:0)}
        end
        6'b100101:begin //25, not implemented load halfword
            //lh/rs/rt/immediate
            //R[rt]={16’b0, M[R[rs]+SignExtImm](15:0)}
        end
        6'b100110:begin //26, not implemented load halfword unsigned
            //lhu/rs/rt/immediate
            //R[rt]={16’b0, M[R[rs]+ZeroExtImm](15:0)}
        end
        6'b101011:begin //2b, store word
            //sw/rs/rt/immediate
            //M[R[rs]+SignExtImm]=R[rt]
            RegDst = 1'b0; //dont care
            Jump = 1'b0;
            Branch = 1'b0;
            MemRead = 1'b0;
            MemtoReg = 1'b0;// dont care
            ALUOp = 2'b00; // ALU add
            MemWrite = 1'b1;
            ALUSrc = 1'b1; // ALU second byte immediate
            RegWrite = 1'b0;
        end
        default:begin
        end
    endcase

end

endmodule