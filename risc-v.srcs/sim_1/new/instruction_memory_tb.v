`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.06.2026 13:47:18
// Design Name: 
// Module Name: instruction_memory_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module instruction_memory_tb;

    reg [31:0] addr;

    wire [31:0] instruction;

    instruction_memory uut(
        .addr(addr),
        .instruction(instruction)
    );

    initial
    begin

        addr = 0;
        #10;

        addr = 4;
        #10;

        addr = 8;
        #10;

        addr = 12;
        #10;

        $finish;

    end

endmodule