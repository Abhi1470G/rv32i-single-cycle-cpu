`timescale 1ns / 1ps

module control_unit(

    input [6:0] opcode,
    input [2:0] funct3,

    output reg RegWrite,
    output reg ALUASrc,
    output reg ALUSrc,

    output reg MemRead,
    output reg MemWrite,
    
    output reg [2:0] MemOp,

    output reg Branch,
    output reg Jump,
    output reg JALR,

    output reg [1:0] ResultSrc

);

always @(*)
begin

    // Default values

    RegWrite  = 0;

    ALUASrc   = 0;
    ALUSrc    = 0;

    MemRead   = 0;
    MemWrite  = 0;
    MemOp = 3'b000;

    Branch    = 0;
    Jump      = 0;
    JALR      = 0;

    ResultSrc = 2'b00;

    case(opcode)

        // R-Type

        7'b0110011:
        begin
            RegWrite  = 1;

            ResultSrc = 2'b00;
        end

        // I-Type Arithmetic

        7'b0010011:
        begin
            RegWrite  = 1;

            ALUSrc    = 1;

            ResultSrc = 2'b00;
        end

        // LOAD

        7'b0000011:
        begin
            RegWrite  = 1;

            ALUSrc    = 1;

            MemRead   = 1;

            ResultSrc = 2'b01;
            
            case(funct3)

                3'b000:
                    MemOp = 3'b011;    // LB
        
                3'b001:
                    MemOp = 3'b001;    // LH
        
                3'b010:
                    MemOp = 3'b000;    // LW
        
                3'b100:
                    MemOp = 3'b100;    // LBU
        
                3'b101:
                    MemOp = 3'b010;    // LHU
        
                default:
                    MemOp = 3'b000;

                endcase   
        end

        // STORE

        7'b0100011:
        begin
            ALUSrc   = 1;

            MemWrite = 1;
            
            case(funct3)

                    3'b000:
                        MemOp = 3'b111;     // SB
            
                    3'b001:
                        MemOp = 3'b110;     // SH
            
                    3'b010:
                        MemOp = 3'b101;     // SW
            
                    default:
                        MemOp = 3'b101;
            
                endcase 
        end

        // BRANCH

        7'b1100011:
        begin
            Branch = 1;
        end

        // JAL

        7'b1101111:
        begin
            Jump = 1;

            RegWrite = 1;

            ResultSrc = 2'b10;
        end

        // JALR

        7'b1100111:
        begin
            RegWrite = 1;

            ALUSrc = 1;

            JALR = 1;

            ResultSrc = 2'b10;
        end

        // LUI

        7'b0110111:
        begin
            RegWrite = 1;

            ResultSrc = 2'b11;
        end

        // AUIPC

        7'b0010111:
        begin
            RegWrite = 1;

            ALUASrc = 1;
            ALUSrc  = 1;

            ResultSrc = 2'b00;
        end

    endcase

end

endmodule