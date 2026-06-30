`timescale 1ns / 1ps

module alu_a_mux(

    input [31:0] register_data,
    input [31:0] pc_current,

    input ALUASrc,

    output [31:0] alu_operand_a

);

assign alu_operand_a =
       ALUASrc
       ? pc_current
       : register_data;

endmodule