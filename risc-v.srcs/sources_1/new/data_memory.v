`timescale 1ns / 1ps

module data_memory(

    input clk,

    input MemRead,
    input MemWrite,

    input [2:0] MemOp,

    input [31:0] address,
    input [31:0] write_data,

    output reg [31:0] read_data

);

    reg [31:0] ram [0:255];

    wire [29:0] word_addr;
    wire [7:0] byte_data;
    wire [15:0] halfword_data;

    assign word_addr = address[31:2];

    assign byte_data =
           (address[1:0] == 2'b00) ? ram[word_addr][7:0] :
           (address[1:0] == 2'b01) ? ram[word_addr][15:8] :
           (address[1:0] == 2'b10) ? ram[word_addr][23:16] :
                                     ram[word_addr][31:24];

    assign halfword_data =
           address[1] ?
           ram[word_addr][31:16] :
           ram[word_addr][15:0];

    integer i;

    initial
    begin
        for(i=0;i<256;i=i+1)
            ram[i]=32'd0;
    end

    // Memory write

    always @(posedge clk)
    begin

        if(MemWrite)
        begin

            case(MemOp)

                // SW

                3'b101:
                    ram[word_addr] <= write_data;

                // SH

                3'b110:
                begin

                    if(address[1]==1'b0)
                        ram[word_addr][15:0] <= write_data[15:0];
                    else
                        ram[word_addr][31:16] <= write_data[15:0];

                end

                // SB

                3'b111:
                begin

                    case(address[1:0])

                        2'b00:
                            ram[word_addr][7:0] <= write_data[7:0];

                        2'b01:
                            ram[word_addr][15:8] <= write_data[7:0];

                        2'b10:
                            ram[word_addr][23:16] <= write_data[7:0];

                        2'b11:
                            ram[word_addr][31:24] <= write_data[7:0];

                    endcase

                end

            endcase

        end

    end

    // Memory read

    always @(*)
    begin

        read_data = 32'd0;

        if(MemRead)
        begin

            case(MemOp)

                // LW

                3'b000:
                    read_data = ram[word_addr];

                // LH

                3'b001:
                    read_data = {{16{halfword_data[15]}},halfword_data};

                // LHU

                3'b010:
                    read_data = {16'd0,halfword_data};

                // LB

                3'b011:
                    read_data = {{24{byte_data[7]}},byte_data};

                // LBU

                3'b100:
                    read_data = {24'd0,byte_data};

                default:
                    read_data = 32'd0;

            endcase

        end

    end

endmodule