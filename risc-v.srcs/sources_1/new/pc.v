`timescale 1ns / 1ps

module pc(

    input clk,
    input rst,
    input halt,

    input [31:0] pc_next,

    output reg [31:0] pc_current

);

always @(posedge clk or posedge rst)
begin

    if(rst)
        pc_current <= 32'd0;

    else if(!halt)
        pc_current <= pc_next;

end

endmodule