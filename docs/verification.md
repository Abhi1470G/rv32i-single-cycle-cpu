# Verification

## Overview

Verification is one of the most important stages of processor development.

Rather than verifying functionality solely through waveform inspection, this project uses a combination of custom RISC-V assembly programs, an automated build system, and a reusable Verilog testbench to validate processor behaviour.

Every major instruction category implemented by the processor was individually tested before executing a final regression program containing all supported instruction types.

---

# Verification Strategy

The verification flow consists of five stages.

1. Write a RISC-V Assembly Program

2. Assemble the program using the GNU RISC-V Toolchain

3. Automatically generate the instruction memory using the Python build script

4. Simulate the processor using AMD Vivado

5. Compare the final register and memory contents against expected values

This workflow significantly reduced manual testing effort and allowed new assembly programs to be verified in only a few seconds.

---

# Testbench

The Verilog testbench performs the following tasks.

- Generates the processor clock.
- Applies reset.
- Monitors processor execution.
- Displays instruction traces.
- Detects ECALL termination.
- Dumps the complete register file.
- Dumps data memory contents.
- Reports instruction count.
- Reports cycle count.
- Calculates CPI.

This provides a complete overview of processor execution after every simulation.

---

# Assembly Verification Programs

Several dedicated assembly programs were written during development.

## Arithmetic Verification

Tests

- ADD
- ADDI
- SUB

---

## Logical Verification

Tests

- AND
- OR
- XOR

Immediate variants

- ANDI
- ORI
- XORI

---

## Shift Verification

Tests

- SLL
- SLLI
- SRL
- SRLI
- SRA
- SRAI

---

## Comparison Verification

Tests

- SLT
- SLTI
- SLTU
- SLTIU

---

## Memory Verification

Tests

- LW
- SW
- LB
- LBU
- LH
- LHU
- SB
- SH

Memory contents are verified after execution.

---

## Branch Verification

Tests

- BEQ
- BNE
- BLT
- BGE
- BLTU
- BGEU

Both branch taken and branch not taken cases were tested.

---

## Jump Verification

Tests

- JAL
- JALR

Correct program counter updates and return addresses were verified.

---

## ECALL Verification

The ECALL instruction is used as the processor halt instruction.

When executed, the processor:

- Stops fetching instructions.
- Halts execution.
- Dumps register values.
- Dumps memory contents.
- Terminates simulation.

---

# Final Regression Test

The final verification program combines every supported instruction category into a single assembly program.

Successful execution confirms that the complete processor datapath operates correctly.

---

# Verification Status

| Component | Status |
|-----------|--------|
| ALU | PASS |
| Register File | PASS |
| Immediate Generator | PASS |
| Control Unit | PASS |
| Branch Unit | PASS |
| Data Memory | PASS |
| Instruction Memory | PASS |
| Jump Logic | PASS |
| Write Back | PASS |
| ECALL | PASS |

---

# Future Improvements

Future verification work will include

- Random instruction generation
- Self-checking testbench
- Functional coverage
- Assertion-based verification
- Automated regression suite