module wb_mux(

    input [31:0] alu_result,
    input [31:0] memory_data,
    input [31:0] pc_plus4,
    input [31:0] imm_out,

    input [1:0] ResultSrc,

    output reg [31:0] write_back_data

);

always @(*)
begin

    case(ResultSrc)

        2'b00:
            write_back_data = alu_result;

        2'b01:
            write_back_data = memory_data;

        2'b10:
            write_back_data = pc_plus4;

        2'b11:
            write_back_data = imm_out;

    endcase

end

endmodule