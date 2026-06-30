//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.06.2026 18:48:09
// Design Name: 
// Module Name: data_memory_tb
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
`timescale 1ns / 1ps
module data_memory_tb;

    reg clk;

    reg MemRead;
    reg MemWrite;

    reg [2:0] MemOp;

    reg [31:0] address;
    reg [31:0] write_data;

    wire [31:0] read_data;

    data_memory uut(

        .clk(clk),

        .MemRead(MemRead),
        .MemWrite(MemWrite),

        .MemOp(MemOp),

        .address(address),

        .write_data(write_data),

        .read_data(read_data)

    );

    always #5 clk = ~clk;

    initial
    begin

        clk = 0;

        MemRead = 0;
        MemWrite = 0;

        MemOp = 0;

        address = 0;
        write_data = 0;

        //--------------------------------
        // TEST 1 : LW
        //--------------------------------

        $display("\n========== TEST 1 : LW ==========");

        uut.ram[0] = 32'h12345678;

        MemRead = 1;
        MemOp = 3'b000;
        address = 32'd0;

        #10;

        if(read_data == 32'h12345678)
            $display("LW PASSED");
        else
            $display("LW FAILED : %h",read_data);

        MemRead = 0;

        //--------------------------------
        // TEST 2 : LB
        //--------------------------------

        $display("\n========== TEST 2 : LB ==========");

        uut.ram[0] = 32'h12FF5678;

        MemRead = 1;
        MemOp = 3'b011;
        address = 32'd2;

        #10;

        if(read_data == 32'hFFFFFFFF)
            $display("LB PASSED");
        else
            $display("LB FAILED : %h",read_data);

        MemRead = 0;

        //--------------------------------
        // TEST 3 : LBU
        //--------------------------------

        $display("\n========== TEST 3 : LBU ==========");

        MemRead = 1;
        MemOp = 3'b100;
        address = 32'd2;

        #10;

        if(read_data == 32'h000000FF)
            $display("LBU PASSED");
        else
            $display("LBU FAILED : %h",read_data);

        MemRead = 0;

        //--------------------------------
        // TEST 4 : LH
        //--------------------------------

        $display("\n========== TEST 4 : LH ==========");

        uut.ram[0] = 32'h80015678;

        MemRead = 1;
        MemOp = 3'b001;
        address = 32'd2;

        #10;

        if(read_data == 32'hFFFF8001)
            $display("LH PASSED");
        else
            $display("LH FAILED : %h",read_data);

        MemRead = 0;

        //--------------------------------
        // TEST 5 : LHU
        //--------------------------------

        $display("\n========== TEST 5 : LHU ==========");

        MemRead = 1;
        MemOp = 3'b010;
        address = 32'd2;

        #10;

        if(read_data == 32'h00008001)
            $display("LHU PASSED");
        else
            $display("LHU FAILED : %h",read_data);

        MemRead = 0;

        //--------------------------------
        // TEST 6 : SW
        //--------------------------------

        $display("\n========== TEST 6 : SW ==========");

        uut.ram[0] = 32'h00000000;

        MemWrite = 1;
        MemOp = 3'b101;
        address = 32'd0;
        write_data = 32'h12345678;

        #10;

        MemWrite = 0;

        if(uut.ram[0] == 32'h12345678)
            $display("SW PASSED");
        else
            $display("SW FAILED : %h",uut.ram[0]);

        //--------------------------------
        // TEST 7 : SH LOWER
        //--------------------------------

        $display("\n========== TEST 7 : SH LOWER ==========");

        uut.ram[0] = 32'hAAAAAAAA;

        MemWrite = 1;
        MemOp = 3'b110;
        address = 32'd0;
        write_data = 32'h00001234;

        #10;

        MemWrite = 0;

        if(uut.ram[0] == 32'hAAAA1234)
            $display("SH LOWER PASSED");
        else
            $display("SH LOWER FAILED : %h",uut.ram[0]);

        //--------------------------------
        // TEST 8 : SH UPPER
        //--------------------------------

        $display("\n========== TEST 8 : SH UPPER ==========");

        uut.ram[0] = 32'hAAAAAAAA;

        MemWrite = 1;
        MemOp = 3'b110;
        address = 32'd2;
        write_data = 32'h00001234;

        #10;

        MemWrite = 0;

        if(uut.ram[0] == 32'h1234AAAA)
            $display("SH UPPER PASSED");
        else
            $display("SH UPPER FAILED : %h",uut.ram[0]);

        //--------------------------------
        // TEST 9 : SB
        //--------------------------------

        $display("\n========== TEST 9 : SB ==========");

        uut.ram[0] = 32'hAAAAAAAA;

        MemWrite = 1;
        MemOp = 3'b111;

        address = 32'd0;
        write_data = 32'h00000011;
        #10;

        address = 32'd1;
        write_data = 32'h00000022;
        #10;

        address = 32'd2;
        write_data = 32'h00000033;
        #10;

        address = 32'd3;
        write_data = 32'h00000044;
        #10;

        MemWrite = 0;

        if(uut.ram[0] == 32'h44332211)
            $display("SB PASSED");
        else
            $display("SB FAILED : %h",uut.ram[0]);

        //--------------------------------
        // FINAL
        //--------------------------------

        $display("\n=================================");
        $display("ALL DATA MEMORY TESTS FINISHED");
        $display("=================================\n");

        $finish;

    end

endmodule
