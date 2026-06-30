# Benchmarks

## Processor Summary

| Feature | Value |
|----------|-------|
| ISA | RV32I |
| Architecture | Single-Cycle |
| Data Width | 32-bit |
| Registers | 32 General Purpose Registers |
| HDL | Verilog |
| Development Tool | AMD Vivado 2025.2 |
| Verification | Assembly Programs + Verilog Testbench |

---

# Instruction Verification

## Arithmetic Instructions

| Instruction | Status |
|------------|--------|
| ADD |  PASS |
| SUB |  PASS |
| SLT |  PASS |

---

## Logical Instructions

| Instruction | Status |
|------------|--------|
| AND | PASS |
| OR | PASS |
| XOR | PASS |

---

## Shift Instructions

| Instruction | Status |
|------------|--------|
| SLL | PASS |
| SRL | PASS |
| SRA | PASS |

---

## Immediate Instructions

| Instruction | Status |
|------------|--------|
| ADDI | PASS |
| ANDI | PASS |
| ORI | PASS |
| XORI | PASS |
| SLTI | PASS |
| SLLI | PASS |
| SRLI | PASS |
| SRAI | PASS |

---

## Memory Instructions

| Instruction | Status |
|------------|--------|
| LW | PASS |
| SW | PASS |

---

## Branch Instructions

| Instruction | Status |
|------------|--------|
| BEQ | PASS |
| BNE | PASS |
| BLT | PASS |
| BGE | PASS |
| BLTU | PASS |
| BGEU | PASS |

---

## Jump Instructions

| Instruction | Status |
|------------|--------|
| JAL | PASS |
| JALR | PASS |

---

## System Instructions

| Instruction | Status |
|------------|--------|
| ECALL | PASS |

---

# Functional Verification

| Component | Status |
|-----------|--------|
| Program Counter | PASS |
| Instruction Memory | PASS |
| Control Unit | PASS |
| Immediate Generator | PASS |
| Register File | PASS |
| ALU | PASS |
| ALU Control | PASS |
| Branch Unit | PASS |
| Branch Address Generator | PASS |
| PC Multiplexer | PASS |
| Data Memory | PASS |
| Write-Back Multiplexer | PASS |

---

# Verification Programs Executed

| Test Program | Result |
|--------------|--------|
| Addition Program | PASS |
| Subtraction Program | PASS |
| Branch Program | PASS |
| Jump Program | PASS |
| Memory Program | PASS |

---

# Assembly Verification Results

## Addition Test

**Expected**

```
100 + 200 = 300
```

**Observed**

```
x3 = 300
```

**Status**

 PASS

---

## Subtraction Test

**Expected**

```
300 - 100 = 200
```

**Observed**

```
Destination register = 200
```

**Status**

 PASS

---

## Branch Test

**Expected**

Conditional branch taken correctly.

**Observed**

Program counter followed the correct branch path.

**Status**

 PASS

---

## Jump Test

**Expected**

JAL/JALR updated both PC and return register correctly.

**Observed**

Correct jump target reached and return address stored.

**Status**

 PASS

---

## Memory Test

**Program**

```
Store 100
Store 200
Load 100
Load 200
Add loaded values
```

**Observed Register Values**

| Register | Value |
|----------|------:|
| x4 | 100 |
| x5 | 200 |
| x6 | 300 |

**Observed Memory**

| Address | Value |
|---------|------:|
| MEM[0] | 100 |
| MEM[1] | 200 |

**Status**

 PASS

---

# Synthesis Results

| Metric | Value |
|---------|------:|
| Slice LUTs | 334 |
| LUT as Logic | 286 |
| LUT as Memory | 48 |
| Slice Registers | 30 |
| Block RAM | 0 |
| DSP Blocks | 0 |
| Clock Buffers (BUFG) | 1 |

---

# Resource Utilization

| Resource | Used | Available | Utilization |
|----------|-----:|----------:|------------:|
| LUTs | 334 | 8000 | 4.18% |
| Registers | 30 | 16000 | 0.19% |
| BRAM | 0 | 20 | 0% |
| DSP | 0 | 40 | 0% |

---

# Timing Summary

Implementation was intentionally **not performed** because the CPU exposes numerous internal debug signals as top-level outputs for simulation, resulting in 131 I/O ports, which exceeds the 112 available user I/O pins of the selected FPGA package.

Therefore:

| Metric | Value |
|---------|-------|
| Worst Negative Slack | N/A |
| Total Negative Slack | N/A |
| Maximum Frequency | N/A |

---

# Simulation Statistics

| Metric | Value |
|---------|------:|
| Clock Cycles | 8 |
| Instructions Executed | 8 |
| Final PC | 0x00000020 |
| Halt Instruction | ECALL |

---

# Overall Verification Status

| Category | Status |
|----------|--------|
| Arithmetic | PASS |
| Logical | PASS |
| Shift | PASS |
| Immediate | PASS |
| Memory | PASS |
| Branch | PASS |
| Jump | PASS |
| System | PASS |
| Functional Modules | PASS |
| Assembly Verification | PASS |
| RTL Simulation | PASS |
| Synthesis | PASS |

---

# Overall Result

> **The 32-bit Single-Cycle RV32I RISC-V Processor was successfully designed, simulated, synthesized, and functionally verified.**
>
> All implemented RV32I instructions operated correctly across arithmetic, logical, shift, memory, branch, jump, and system instruction categories. RTL simulation and assembly-based verification confirmed correct datapath operation and control signal generation. Resource utilization after synthesis remained low, demonstrating an efficient FPGA implementation suitable for educational and research purposes.