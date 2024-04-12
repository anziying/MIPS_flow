// `timescale 1ps/1ps

module Sign_Extend(in, Unsigned, out);
    input [15:0] in;
    input Unsigned;
    output reg [31:0] out;
    integer i;
    
    always @(*) begin
        out[15:0] = in[15:0];
        for(i=16; i<32; i = i+1) begin
            if (Unsigned == 1'b1) begin
                out[i] = 1'b0;
            end else begin
                out[i] = in[15];
            end
        end
    end

endmodule