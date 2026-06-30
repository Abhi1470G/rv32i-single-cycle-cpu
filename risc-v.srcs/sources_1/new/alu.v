`timescale 1ns / 1ps
module alu(

    input [31:0] a,
    input [31:0] b,

    input [3:0] alu_ctrl,

    output reg [31:0] result,

    output zero,
    output negative,
    output carry,
    output overflow,
    output parity,
    output unsigned_less

);

    reg [32:0] temp;

    always @(*)
    begin

        temp = 33'd0;
        result = 32'd0;

        case(alu_ctrl)

            //--------------------------------
            // ADD
            //--------------------------------

            4'b0000:
            begin
                temp = {1'b0,a} + {1'b0,b};
                result = temp[31:0];
            end

            //--------------------------------
            // SUB
            //--------------------------------

            4'b0001:
            begin
                temp = {1'b0,a} - {1'b0,b};
                result = temp[31:0];
            end

            //--------------------------------
            // AND
            //--------------------------------

            4'b0010:
                result = a & b;

            //--------------------------------
            // OR
            //--------------------------------

            4'b0011:
                result = a | b;

            //--------------------------------
            // XOR
            //--------------------------------

            4'b0100:
                result = a ^ b;

            //--------------------------------
            // SLT
            //--------------------------------

            4'b0101:
                result = ($signed(a) < $signed(b)) ? 32'd1 : 32'd0;
                
            //--------------------------------
            // SLTU
            //--------------------------------
            
            4'b1001:
                result = (a < b) ? 32'd1 : 32'd0;

            //--------------------------------
            // SLL
            //--------------------------------

            4'b0110:
                result = a << b[4:0];

            //--------------------------------
            // SRL
            //--------------------------------

            4'b0111:
                result = a >> b[4:0];

            //--------------------------------
            // SRA
            //--------------------------------

            4'b1000:
                result = $signed(a) >>> b[4:0];

        endcase

    end

    //--------------------------------
    // Flags
    //--------------------------------

    assign zero     = (result == 32'd0);

    assign negative = result[31];

    assign carry    = temp[32];

    assign parity   = ~(^result);
    
    assign unsigned_less = (a < b);

    //--------------------------------
    // Overflow
    //--------------------------------

    assign overflow =
           (alu_ctrl == 4'b0000) ?

           ((a[31] == b[31]) &&
            (result[31] != a[31]))

           :

           (alu_ctrl == 4'b0001) ?

           ((a[31] != b[31]) &&
            (result[31] != a[31]))

           :

           1'b0;

endmodule
