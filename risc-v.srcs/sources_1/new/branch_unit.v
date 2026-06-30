`timescale 1ns / 1ps

module branch_unit(

    input Branch,
    input Jump,

    input JALR,

    input [2:0] funct3,

    input zero,
    input negative,
    input unsigned_less,

    output reg [1:0] pc_src

);

always @(*)
begin

    // Default = PC + 4

    pc_src = 2'b00;

    // JALR

    if(JALR)
    begin
        pc_src = 2'b10;
    end

    // JAL

    else if(Jump)
    begin
        pc_src = 2'b01;
    end

    // Conditional branches

    else if(Branch)
    begin

        case(funct3)

            // BEQ

            3'b000:
            begin
                if(zero)
                    pc_src = 2'b01;
            end

            // BNE

            3'b001:
            begin
                if(~zero)
                    pc_src = 2'b01;
            end

            // BLT

            3'b100:
            begin
                if(negative)
                    pc_src = 2'b01;
            end

            // BGE

            3'b101:
            begin
                if(~negative)
                    pc_src = 2'b01;
            end
            
            // BLTU

            3'b110:
            begin
            
                if(unsigned_less)
                    pc_src = 2'b01;
            
            end
            
            // BGEU
            
            3'b111:
            begin
            
                if(~unsigned_less)
                    pc_src = 2'b01;
            
            end 

        endcase

    end

end

endmodule