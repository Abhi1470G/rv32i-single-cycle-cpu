# RV32I Single-Cycle RISC-V Processor

<p align="center">

![Verilog](https://img.shields.io/badge/Language-Verilog-blue)
![Vivado](https://img.shields.io/badge/Tool-AMD%20Vivado%202025.2-red)
![Architecture](https://img.shields.io/badge/Architecture-RV32I-green)
![License](https://img.shields.io/badge/License-MIT-yellow)
![Status](https://img.shields.io/badge/Status-Completed-success)

</p>

---

## Table of Contents

- [About](#about)
- [Project Motivation](#project-motivation)
- [Processor Features](#processor-features)
- [Architecture](#architecture)
- [Supported RV32I Instructions](#supported-rv32i-instructions)
- [Directory Structure](#directory-structure)
- [Verification](#verification)
- [RTL Analysis](#rtl-analysis)
- [Synthesis Results](#synthesis-results)
- [Resource Utilization](#resource-utilization)
- [Benchmarks](#benchmarks)
- [Future Improvements](#future-improvements)
- [Learning Outcomes](#learning-outcomes)
- [Documentation](#documentation)
- [License](#license)

---

# About

This repository contains a complete **32-bit Single-Cycle RISC-V Processor** designed completely from scratch using **Verilog HDL**.

The processor implements the **RV32I Base Integer Instruction Set Architecture**, including arithmetic, logical, memory access, branching, jumping and system instructions.

The entire processor was simulated, verified using multiple assembly programs and synthesized using **AMD Vivado 2025.2**.

---

# Project Motivation

This processor was developed during my **Summer Break 2026**.

Instead of only learning Computer Architecture theoretically, I wanted to understand what happens inside a processor by designing one from scratch.

This project helped me gain practical experience with:

- RTL Design
- Processor Datapaths
- Control Logic
- Digital Logic Design
- Hardware Verification
- FPGA Synthesis
- Assembly Programming
- Computer Architecture
- RISC-V ISA

---

# Processor Features

- 32-bit RV32I Processor
- Single-Cycle Datapath
- Harvard Architecture
- 32 General Purpose Registers
- Immediate Generator
- ALU
- ALU Control Unit
- Branch Unit
- Program Counter
- Branch Address Generator
- Instruction Memory
- Data Memory
- Write Back Multiplexer
- ECALL Support
- EBREAK Support

---

# Architecture

## Datapath

> *(Insert your RTL schematic here)*

```text
docs/images/rtl_schematic.png
```

---

## RTL Viewer

> *(Insert synthesized RTL screenshot here)*

```text
docs/images/rtl_view.png
```

---

# Supported RV32I Instructions

| Category | Instructions |
|-----------|-------------|
| Arithmetic | ADD SUB SLT |
| Logical | AND OR XOR |
| Shift | SLL SRL SRA |
| Immediate | ADDI ANDI ORI XORI SLTI SLLI SRLI SRAI |
| Memory | LW SW |
| Branch | BEQ BNE BLT BGE BLTU BGEU |
| Jump | JAL JALR |
| System | ECALL EBREAK |

---

# Directory Structure

```
asm/
build/
docs/
mem/

risc-v.srcs/
scripts/

README.md
LICENSE
BENCHMARKS.md
CHANGELOG.md
```

---

# Verification

The processor was verified using independent assembly programs.

| Test | Status |
|------|--------|
| Addition | PASS |
| Subtraction | PASS |
| Branch | PASS |
| Jump | PASS |
| Memory | PASS |

More information is available in:

➡️ **[BENCHMARKS.md](BENCHMARKS.md)**

---

# RTL Analysis

RTL Analysis was performed using AMD Vivado.

Generated Artifacts

- RTL Viewer
- Hierarchy Viewer
- RTL Schematic

---

# Synthesis Results

The design synthesizes successfully.

Target FPGA

- Artix-7 xc7a12tcpg238-1

Tool

- AMD Vivado 2025.2

---

# Resource Utilization

| Resource | Used | Available | Utilization |
|----------|-----:|----------:|------------:|
| LUTs | 334 | 8000 | 4.18% |
| Registers | 30 | 16000 | 0.19% |
| BRAM | 0 | 20 | 0% |
| DSP | 0 | 40 | 0% |

Implementation was intentionally not completed because the processor exports numerous internal debug signals for verification, resulting in more top-level I/O ports than are available on the selected FPGA package.

---

# Benchmarks

Detailed benchmark results are available here:

➡️ **[BENCHMARKS.md](BENCHMARKS.md)**

---

# Future Improvements

- Five Stage Pipeline
- Hazard Detection Unit
- Forwarding Unit
- Branch Prediction
- Cache Memory
- CSR Instructions
- Interrupt Handling
- Exceptions
- AXI Interface
- FPGA Demonstration

---

# Learning Outcomes

This project significantly improved my understanding of:

- RTL Design
- Processor Datapaths
- RTL Verification
- FPGA Synthesis
- Hardware Debugging
- RISC-V ISA
- Computer Architecture

---

# Documentation

| Document | Description |
|-----------|------------|
| [README.md](README.md) | Project Overview |
| [BENCHMARKS.md](BENCHMARKS.md) | Verification Results |
| [CHANGELOG.md](CHANGELOG.md) | Project History |
| [LICENSE](LICENSE) | MIT License |

---

# License

This project is licensed under the MIT License.

See **[LICENSE](LICENSE)** for details.

---

## Author

**Abhinav**

Engineering Student

VIT Chennai

Summer Break Project • 2026
