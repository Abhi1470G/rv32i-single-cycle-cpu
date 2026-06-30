`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.06.2026 14:06:24
// Design Name: 
// Module Name: register_file_tb
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
module register_file_tb;

    reg clk;

    reg reg_write;

    reg [4:0] rs1;
    reg [4:0] rs2;
    reg [4:0] rd;

    reg [31:0] write_data;

    wire [31:0] read_data1;
    wire [31:0] read_data2;

    register_file uut(

        .clk(clk),

        .reg_write(reg_write),

        .rs1(rs1),
        .rs2(rs2),

        .rd(rd),

        .write_data(write_data),

        .read_data1(read_data1),
        .read_data2(read_data2)

    );

    always #5 clk = ~clk;

    initial
    begin

        clk = 0;

        reg_write = 1;

        //--------------------------------
        // x1 = 5
        //--------------------------------

        rd = 1;
        write_data = 5;

        #10;

        //--------------------------------
        // x2 = 10
        //--------------------------------

        rd = 2;
        write_data = 10;

        #10;

        //--------------------------------
        // Read x1 and x2
        //--------------------------------

        reg_write = 0;

        rs1 = 1;
        rs2 = 2;

        #20;

        $finish;

    end

endmodule