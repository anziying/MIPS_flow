module ALU_Control(funct,ALUOp,out);
    input [5:0] funct;
    input [1:0] ALUOp;
    output reg [3:0] out;

    always @(*) begin
        out = 4'b0010;
        case(ALUOp)
            2'b00:begin
                out=4'b0010;
            end
            2'b01:begin
                out=4'b0110;
            end
            // R-type start
            2'b10:begin
                case(funct)
                    // add
                    6'b100000:
                        out=4'b0010;
                    // subtract
                    6'b100010:
                        out=4'b0110;
                    // AND
                    6'b100100:
                        out=4'b0000;
                    // OR
                    6'b100101:
                        out=4'b0001;
                    // SLT
                    6'b101010:
                        out=4'b0111;
                    default:begin
                    end
                endcase

            end
            default:begin
            end
        endcase
    end

endmodule