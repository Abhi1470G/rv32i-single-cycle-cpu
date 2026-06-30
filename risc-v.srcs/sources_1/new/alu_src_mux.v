`timescale 1ns / 1ps
module alu_src_mux(

    input [31:0] register_data,
    input [31:0] immediate,

    input ALUSrc,

    output [31:0] alu_operand_b

);

assign alu_operand_b =
       ALUSrc
       ? immediate
       : register_data;

endmodule
