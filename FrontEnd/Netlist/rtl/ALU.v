// `timescale 1ps/1ps

module ALU(A, B, control, S, carryout, zero, overflow);
input signed [31:0] A; 
input signed [31:0] B;
input [3:0] control;
// wire [31:0] B_comp;
reg [32:0] RES;
output [31:0] S;
output carryout;
output zero;
output reg overflow;

assign S = RES[31:0];
assign carryout = RES [32];
assign zero = (S == 32'b0) ? 1'b1:1'b0;
// assign B_comp = (~B) + 1;
always @(*) begin
    overflow = 0;
    case(control)
        //bitwise AND
        4'b0000: begin
            RES = A & B;
        end
        // bitwise or
        4'b0001:begin
            RES = A | B;
        end
        // add
        4'b0010: begin
            RES = A + B;
            if((A[31] == 1 && B[31] == 1 && RES[31] == 0) || (A[31] == 0 && B[31] == 0 && RES[31] == 1))
                overflow = 1;
        end
        // subtract
        4'b0110:begin
            RES = A + ((~B) + 1);
            if((A[31] == 1 && B[31] == 0 && RES[31] == 0) || (A[31] == 0 && B[31] == 1 && RES[31] == 1))
                overflow = 1;
        end
        // SLT set on less than
        4'b0111:begin
            RES = (A<B) ? 1:0;
        end
        // NOR
        4'b1100:begin
            RES = A^B;
        end
        default:begin
            RES = {0, A};
        end
    endcase
end
endmodule