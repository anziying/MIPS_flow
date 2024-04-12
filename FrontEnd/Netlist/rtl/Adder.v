module Adder(A, B, S, overflow);
    input signed [31:0] A; 
    input signed [31:0] B;
    output reg [31:0] S;
    output reg overflow;
    always @(*) begin
        S = A + B;
        overflow = 0;
        if((A[31] == 1 && B[31] == 1 && S[31] == 0) || (A[31] == 0 && B[31] == 0 && S[31] == 1))
            overflow = 1;
        if((A[31] == 1 && B[31] == 0 && S[31] == 0) || (A[31] == 0 && B[31] == 1 && S[31] == 1))
            overflow = 1;
    end

endmodule