`timescale 1ns / 1ps

module instruction_memory(

    input  [31:0] addr,
    output [31:0] instruction

);

    // 256 x 32-bit Instruction ROM
    reg [31:0] rom [0:255];

    integer i;

    initial
    begin

        // Initialize ROM with NOPs
        for(i = 0; i < 256; i = i + 1)
            rom[i] = 32'h00000013;

        $display("");
        $display("========================================");
        $display("      RISC-V Instruction Memory");
        $display("========================================");
        $display("Loading mem/program.mem ...");

        $readmemh("program.mem", rom);

        $display("Instruction Memory Loaded Successfully");
        $display("========================================");
        $display("");

    end

    // Word-aligned instruction fetch
    assign instruction =
        (addr[31:2] < 256) ?
        rom[addr[31:2]] :
        32'h00000013;

endmodule