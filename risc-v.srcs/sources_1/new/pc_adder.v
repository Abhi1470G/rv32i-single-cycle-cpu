`timescale 1ns / 1ps
module pc_adder(

    input  [31:0] pc_current,

    output [31:0] pc_plus4

);

    assign pc_plus4 = pc_current + 32'd4;

endmodule
