`timescale 1ns / 1ps

module cpu_tb;

reg clk;
reg rst;

integer cycles;
integer instructions;

wire [31:0] pc_out;
wire [31:0] instruction_out;
wire [31:0] alu_result_out;
wire [31:0] write_back_out;
wire halt_out;

cpu uut(

    .clk(clk),
    .rst(rst),

    .pc_out(pc_out),
    .instruction_out(instruction_out),
    .alu_result_out(alu_result_out),
    .halt_out(halt_out),
    .write_back_out(write_back_out)

);


always #5 clk = ~clk;


initial
begin
    clk = 0;
    rst = 1;

    cycles = 0;
    instructions = 0;

    #20;
    rst = 0;
end


always @(posedge clk)
begin
    if(rst)
        cycles <= 0;
    else
        cycles <= cycles + 1;
end

always @(posedge clk)
begin
    if(rst)
        instructions <= 0;
    else if(!uut.halt)
        instructions <= instructions + 1;
end


always @(posedge clk)
begin

    if(!rst)
    begin

        line();

        $display("Cycle        : %0d", cycles);

        $display("PC           : %08h", uut.pc_current);

        $display("Instruction  : %08h", uut.instruction);

        $display("Opcode       : %07b", uut.opcode);

        $display("rd           : x%0d", uut.rd);
        $display("rs1          : x%0d", uut.rs1);
        $display("rs2          : x%0d", uut.rs2);

        $display("Immediate    : %08h", uut.imm_out);

        $display("ALU Ctrl     : %04b", uut.alu_ctrl);

        $display("ALU Result   : %08h", uut.alu_result);

        $display("Write Back   : %08h", uut.write_back_data);

        if(uut.RegWrite)
            $display("REGISTER WR  : x%0d <= %08h",
                     uut.rd,
                     uut.write_back_data);

        if(uut.MemWrite)
            $display("STORE        : MEM[%08h] <= %08h",
                     uut.alu_result,
                     uut.read_data2);

        if(uut.MemRead)
            $display("LOAD         : MEM[%08h] => %08h",
                     uut.alu_result,
                     uut.memory_read_data);

        $display("Branch       : %b", uut.Branch);
        $display("Jump         : %b", uut.Jump);
        $display("JALR         : %b", uut.JALR);

        $display("PC Source    : %02b", uut.pc_src);

        $display("Branch Addr  : %08h", uut.branch_target);
        $display("JALR Addr    : %08h", uut.jalr_target);

        $display("Zero         : %b", uut.zero);
        $display("Negative     : %b", uut.negative);
        $display("Carry        : %b", uut.carry);
        $display("Overflow     : %b", uut.overflow);

    end

end


always @(posedge clk)
begin

    if(uut.halt)
    begin

        line();
        $display("");
        $display("                 CPU HALTED");
        $display("");
        line();

        $display("");
        $display("============== FINAL CPU STATE ==============");
        $display("");

        $display("Final PC      : %08h", uut.pc_current);
        $display("Last Instr    : %08h", uut.instruction);

        $display("");

        $display("Cycles        : %0d", cycles);
        $display("Instructions  : %0d", instructions);

        $display("");

        dump_registers();

        dump_memory();

        line();

        $finish;

    end

end


initial
begin

    #5000;

    line();

    $display("");
    $display("************ SIMULATION TIMEOUT ************");
    $display("");

    $display("Final PC      : %08h", uut.pc_current);
    $display("Current Instr : %08h", uut.instruction);

    $display("");

    $display("Cycles        : %0d", cycles);
    $display("Instructions  : %0d", instructions);

    $display("");

    dump_registers();

    dump_memory();

    line();

    $finish;

end


task line;
begin
    $display("==============================================================");
end
endtask


task dump_registers;

integer i;

begin

    line();

    $display("REGISTER FILE");

    line();

    for(i = 0; i < 32; i = i + 1)
    begin
        $display("x%-2d : %08h (%0d)",
                 i,
                 uut.rf.registers[i],
                 uut.rf.registers[i]);
    end

    $display("");

end

endtask


task dump_memory;

integer i;

begin

    line();

    $display("DATA MEMORY");

    line();

    for(i = 0; i < 32; i = i + 1)
    begin
        $display("MEM[%02d] : %08h",
                 i,
                 uut.dmem.ram[i]);
    end

    $display("");

end

endtask

endmodule