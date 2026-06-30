`timescale 1ns / 1ps

module branch_adder(

    input [31:0] pc_current,
    input [31:0] immediate,

    output [31:0] branch_target

);

    assign branch_target =
           pc_current + immediate;

endmodule