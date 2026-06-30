# Processor Architecture

## Overview

This project implements a **32-bit RV32I Single-Cycle Processor** in Verilog HDL.

The processor follows a Harvard-style architecture with separate instruction and data memories. Each instruction is fetched, decoded, executed, accesses memory if required, and writes its result back to the register file within a single clock cycle.

The design was intentionally developed using modular RTL components so that each functional block can be independently verified and later reused in future processor implementations.

---

# High-Level Datapath

The processor consists of the following major components:

- Program Counter
- Instruction Memory
- Register File
- Immediate Generator
- Control Unit
- ALU Control
- Arithmetic Logic Unit
- Branch Unit
- Data Memory
- Write-Back Multiplexer

Together these modules implement the complete RV32I instruction execution flow.

---

# Program Counter

The Program Counter (PC) stores the address of the current instruction.

Depending on the instruction being executed, the next value of the PC may be:

- PC + 4
- Branch Target
- JAL Target
- JALR Target

The Program Counter updates once every clock cycle unless execution is halted using ECALL.

---

# Instruction Memory

Instruction memory stores the program executed by the processor.

Instructions are loaded automatically from the generated `program.mem` file.

A custom Python build script assembles RISC-V assembly programs and converts them into this memory image, allowing new programs to be tested without manually editing Verilog source files.

---

# Register File

The processor implements thirty-two 32-bit general-purpose registers.

Features:

- Two asynchronous read ports
- One synchronous write port
- Register x0 permanently tied to zero
- Register writes occur on the positive clock edge

---

# Immediate Generator

Different instruction formats within RV32I require different immediate layouts.

The Immediate Generator extracts and sign-extends immediates for:

- I-Type
- S-Type
- B-Type
- U-Type
- J-Type

This module allows the datapath to operate using a unified 32-bit immediate value.

---

# Control Unit

The Control Unit decodes the instruction opcode and generates the control signals required by the datapath.

Generated control signals include:

- Register Write Enable
- Memory Read
- Memory Write
- ALU Source Selection
- Branch Enable
- Jump Enable
- Write-Back Selection

---

# ALU Control

The ALU Control module combines:

- Opcode
- funct3
- funct7

to determine the exact ALU operation.

Supported operations include arithmetic, logical, comparison, and shift instructions.

---

# Arithmetic Logic Unit

The ALU performs all arithmetic and logical computations required by the processor.

Supported operations include:

- Addition
- Subtraction
- AND
- OR
- XOR
- Shift Left Logical
- Shift Right Logical
- Shift Right Arithmetic
- Signed Comparison
- Unsigned Comparison

The ALU also generates:

- Zero Flag
- Negative Flag
- Carry Flag
- Overflow Flag

which are used by branch instructions and debugging.

---

# Branch Unit

The Branch Unit evaluates branch conditions based on the ALU flags and instruction type.

Supported branch instructions include:

- BEQ
- BNE
- BLT
- BGE
- BLTU
- BGEU

---

# Data Memory

The Data Memory module supports:

- Byte Loads
- Halfword Loads
- Word Loads
- Byte Stores
- Halfword Stores
- Word Stores

Appropriate sign extension and zero extension are performed for load instructions where required.

---

# Write-Back Stage

The final stage selects the value written back into the register file.

Possible write-back sources include:

- ALU Result
- Data Memory
- PC + 4 (Jump Instructions)

---

# Instruction Execution Flow

Every instruction follows the same sequence:

1. Fetch instruction from Instruction Memory.
2. Decode opcode and control signals.
3. Read operands from Register File.
4. Generate immediate if required.
5. Execute ALU operation.
6. Access Data Memory if required.
7. Select write-back data.
8. Update Program Counter.

Since this is a single-cycle processor, all stages complete within one clock cycle.

---

# Design Philosophy

The processor was designed with modularity and readability in mind.

Each functional block performs a single well-defined task, making debugging, verification, and future expansion significantly easier.

This modular architecture also simplifies future upgrades such as pipelining, hazard detection, forwarding, and cache integration.