# Design Challenges

Developing a processor from scratch involves much more than implementing individual hardware modules. Every component must interact correctly with the rest of the datapath while following the RISC-V ISA specification.

This document summarizes some of the major engineering challenges encountered during the development of this project and the approaches taken to address them.

---

# 1. Understanding the RV32I Instruction Set

The first challenge was becoming familiar with the RV32I instruction set architecture.

Unlike implementing isolated digital circuits, a processor requires understanding how multiple instruction formats interact with a common datapath.

The following instruction formats were implemented:

- R-Type
- I-Type
- S-Type
- B-Type
- U-Type
- J-Type

Each instruction format stores its immediate fields differently, requiring careful implementation of the Immediate Generator.

---

# 2. Control Unit Design

The Control Unit acts as the brain of the processor.

A single incorrect control signal can cause the processor to:

- Write incorrect register values
- Access memory unintentionally
- Branch to the wrong address
- Skip instructions

Developing and debugging the control logic required extensive simulation using multiple assembly programs.

---

# 3. Immediate Generation

Generating immediates proved to be one of the most interesting parts of the processor.

Different instruction formats store immediate bits in different locations.

The Immediate Generator was designed to correctly extract and sign-extend:

- I-Type immediates
- S-Type immediates
- B-Type branch offsets
- U-Type upper immediates
- J-Type jump offsets

---

# 4. Branch and Jump Logic

Correct program flow depends on accurate branch target calculation.

Special attention was required when implementing:

- BEQ
- BNE
- BLT
- BGE
- BLTU
- BGEU
- JAL
- JALR

Debugging these instructions involved observing program counter updates throughout simulation.

---

# 5. Memory Access

Supporting byte, halfword, and word accesses introduced additional complexity.

Load instructions required proper:

- Sign extension
- Zero extension
- Address decoding

Store instructions required correct byte selection and memory updates.

---

# 6. Register File

The register file was designed with:

- Two asynchronous read ports
- One synchronous write port

Special care was taken to ensure that register x0 always remains zero as required by the RV32I specification.

---

# 7. Verification Strategy

Rather than relying solely on waveform inspection, a structured verification strategy was adopted.

Individual assembly programs were created for:

- Arithmetic
- Logic
- Memory
- Branch
- Jump

Finally, a complete regression program was developed to validate the processor as a whole.

---

# 8. Automating the Verification Workflow

Repeatedly modifying instruction memory manually quickly became inefficient.

To streamline testing, a Python build script was developed to automate the process of:

Assembly Source

↓

GNU RISC-V Toolchain

↓

Binary Generation

↓

program.mem

↓

Vivado Simulation

This reduced verification time significantly and made experimentation much easier.

---

# Lessons Learned

Building this processor provided valuable experience in:

- RTL Design
- Computer Architecture
- Hardware Verification
- Verilog HDL
- Simulation and Debugging
- FPGA Development Workflow
- Automation using Python

The project also demonstrated the importance of modular design and systematic verification when developing complex digital systems.