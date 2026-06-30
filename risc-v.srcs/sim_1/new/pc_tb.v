`timescale 1ns / 1ps

module pc_tb;

    reg clk;
    reg rst;

    wire [31:0] pc_current;
    wire [31:0] pc_plus4;

    pc pc_inst(
        .clk(clk),
        .rst(rst),
        .pc_next(pc_plus4),
        .pc_current(pc_current)
    );

    pc_adder adder_inst(
        .pc_current(pc_current),
        .pc_plus4(pc_plus4)
    );

    always #5 clk = ~clk;

    initial
    begin

        clk = 0;
        rst = 1;

        #20;
        rst = 0;

        #100;

        $finish;

    end

endmodule