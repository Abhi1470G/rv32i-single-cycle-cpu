`timescale 1ns / 1ps

module alu_control(

    input [6:0] opcode,
    input [2:0] funct3,
    input [6:0] funct7,

    output reg [3:0] alu_ctrl

);

always @(*)
begin

    case(opcode)

        // R-Type

        7'b0110011:
        begin

            case({funct7,funct3})

                {7'b0000000,3'b000}: alu_ctrl = 4'b0000; // ADD
                {7'b0100000,3'b000}: alu_ctrl = 4'b0001; // SUB

                {7'b0000000,3'b111}: alu_ctrl = 4'b0010; // AND
                {7'b0000000,3'b110}: alu_ctrl = 4'b0011; // OR
                {7'b0000000,3'b100}: alu_ctrl = 4'b0100; // XOR

                {7'b0000000,3'b010}: alu_ctrl = 4'b0101; // SLT
                {7'b0000000,3'b011}: alu_ctrl = 4'b1001; // SLTU

                {7'b0000000,3'b001}: alu_ctrl = 4'b0110; // SLL

                {7'b0000000,3'b101}: alu_ctrl = 4'b0111; // SRL
                {7'b0100000,3'b101}: alu_ctrl = 4'b1000; // SRA

                default: alu_ctrl = 4'b0000;

            endcase

        end

        // I-Type Arithmetic

        7'b0010011:
    begin

    case(funct3)

        3'b000: alu_ctrl = 4'b0000; // ADDI
        3'b010: alu_ctrl = 4'b0101; // SLTI
        3'b011: alu_ctrl = 4'b1001; // SLTIU
        3'b100: alu_ctrl = 4'b0100; // XORI
        3'b110: alu_ctrl = 4'b0011; // ORI
        3'b111: alu_ctrl = 4'b0010; // ANDI
        3'b001:
            alu_ctrl = 4'b0110;      // SLLI
        3'b101:
        begin

            if(funct7 == 7'b0000000)
                alu_ctrl = 4'b0111;  // SRLI

            else if(funct7 == 7'b0100000)
                alu_ctrl = 4'b1000;  // SRAI

            else
                alu_ctrl = 4'b0000;

        end

        default:
            alu_ctrl = 4'b0000;

        endcase

        end

        // Loads / Stores

        7'b0000011,
        7'b0100011:
        begin
            alu_ctrl = 4'b0000;
        end

        // Branches

        7'b1100011:
        begin
            alu_ctrl = 4'b0001;
        end

        // JAL

        7'b1101111:
        begin
            alu_ctrl = 4'b0000;
        end

        // JALR

        7'b1100111:
        begin
            alu_ctrl = 4'b0000;
        end

        // LUI

        7'b0110111:
        begin
            alu_ctrl = 4'b0000;
        end

        // AUIPC

        7'b0010111:
        begin
            alu_ctrl = 4'b0000;
        end

        default:
            alu_ctrl = 4'b0000;

    endcase

end

endmodule