`timescale 1ns / 1ps

module pc_mux(

    input [31:0] pc_plus4,
    input [31:0] branch_target,
    input [31:0] jalr_target,

    input [1:0] pc_src,

    output reg [31:0] pc_next

);

always @(*)
begin

    case(pc_src)

        2'b00:
            pc_next = pc_plus4;

        2'b01:
            pc_next = branch_target;

        2'b10:
            pc_next = jalr_target;

        default:
            pc_next = pc_plus4;

    endcase

end

endmodule