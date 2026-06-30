`timescale 1ns / 1ps

module cpu(

    input clk,
    input rst,
    
    output [31:0] pc_out,

    output [31:0] instruction_out,
    
    output [31:0] alu_result_out,
    
    output halt_out,
    
    output [31:0] write_back_out

);
    
    wire halt;
    wire [31:0] pc_current;
    wire [31:0] pc_plus4;
    wire [31:0] pc_next;

    wire [31:0] instruction;

    wire [6:0] opcode;
    wire [4:0] rd;
    wire [4:0] rs1;
    wire [4:0] rs2;
    wire [2:0] funct3;
    wire [6:0] funct7;

    wire RegWrite;

    wire ALUASrc;
    wire ALUSrc;

    wire MemRead;
    wire MemWrite;
    wire [2:0] MemOp;

    wire Branch;
    wire Jump;
    wire JALR;

    wire [1:0] ResultSrc;

    wire [31:0] read_data1;
    wire [31:0] read_data2;

    wire [31:0] imm_out;

    wire [3:0] alu_ctrl;

    wire [31:0] alu_operand_a;
    wire [31:0] alu_operand_b;

    wire [31:0] alu_result;

    wire zero;
    wire negative;
    wire carry;
    wire overflow;
    wire parity;
    wire unsigned_less;
    
    wire [31:0] memory_read_data;

    wire [31:0] write_back_data;

    wire [31:0] branch_target;
    wire [31:0] jalr_target;

    wire [1:0] pc_src;
    
    wire ecall;
    wire ebreak;
    
    assign ecall =
       opcode == 7'b1110011 &&
       funct3 == 3'b000 &&
       instruction[31:20] == 12'd0;
       
    assign ebreak =
       opcode == 7'b1110011 &&
       funct3 == 3'b000 &&
       instruction[31:20] == 12'd1;
       
    assign halt = ecall | ebreak;
    
    assign halt_out = halt;
    assign pc_out = pc_current;
    assign alu_result_out = alu_result;
    assign write_back_out = write_back_data;
    assign instruction_out = instruction;
    


    pc pc_inst(

        .clk(clk),
        .rst(rst),
        .halt(halt),

        .pc_next(pc_next),

        .pc_current(pc_current)

    );


    pc_adder pc_adder_inst(

        .pc_current(pc_current),

        .pc_plus4(pc_plus4)

    );

    instruction_memory imem(

        .addr(pc_current),

        .instruction(instruction)

    );

    assign opcode = instruction[6:0];

    assign rd     = instruction[11:7];

    assign funct3 = instruction[14:12];

    assign rs1    = instruction[19:15];

    assign rs2    = instruction[24:20];

    assign funct7 = instruction[31:25];


    control_unit cu(

        .opcode(opcode),
        .funct3(funct3),

        .RegWrite(RegWrite),

        .ALUASrc(ALUASrc),
        .ALUSrc(ALUSrc),

        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .MemOp(MemOp),

        .Branch(Branch),
        .Jump(Jump),
        .JALR(JALR),

        .ResultSrc(ResultSrc)

    );


    immediate_generator imm_gen(

        .instruction(instruction),

        .imm_out(imm_out)

    );


    register_file rf(

        .clk(clk),

        .reg_write(RegWrite),

        .rs1(rs1),
        .rs2(rs2),

        .rd(rd),

        .write_data(write_back_data),

        .read_data1(read_data1),
        .read_data2(read_data2)

    );


    alu_control alu_ctrl_unit(

        .opcode(opcode),

        .funct3(funct3),
        .funct7(funct7),

        .alu_ctrl(alu_ctrl)

    );


    alu_a_mux a_mux(

        .register_data(read_data1),

        .pc_current(pc_current),

        .ALUASrc(ALUASrc),

        .alu_operand_a(alu_operand_a)

    );


    alu_src_mux src_mux(

        .register_data(read_data2),

        .immediate(imm_out),

        .ALUSrc(ALUSrc),

        .alu_operand_b(alu_operand_b)

    );


    alu alu_inst(

        .a(alu_operand_a),

        .b(alu_operand_b),

        .alu_ctrl(alu_ctrl),

        .result(alu_result),

        .zero(zero),
        .negative(negative),

        .carry(carry),

        .overflow(overflow),

        .parity(parity),
        
        .unsigned_less(unsigned_less)

    );


    data_memory dmem(

        .clk(clk),

        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .MemOp(MemOp),

        .address(alu_result),

        .write_data(read_data2),

        .read_data(memory_read_data)

    );


    wb_mux wb(

        .alu_result(alu_result),

        .memory_data(memory_read_data),

        .pc_plus4(pc_plus4),

        .imm_out(imm_out),

        .ResultSrc(ResultSrc),

        .write_back_data(write_back_data)

    );


    branch_adder branch_add(

        .pc_current(pc_current),

        .immediate(imm_out),

        .branch_target(branch_target)

    );
    
    
    assign jalr_target =
           (read_data1 + imm_out) & 32'hFFFFFFFE;


    branch_unit bu(

        .Branch(Branch),

        .Jump(Jump),

        .JALR(JALR),

        .funct3(funct3),

        .zero(zero),

        .negative(negative),
        
        .unsigned_less(unsigned_less),

        .pc_src(pc_src)

    );


    pc_mux next_pc_mux(

        .pc_plus4(pc_plus4),

        .branch_target(branch_target),

        .jalr_target(jalr_target),

        .pc_src(pc_src),

        .pc_next(pc_next)

    );

endmodule