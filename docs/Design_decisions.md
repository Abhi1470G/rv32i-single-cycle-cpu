# Design Decisions

## Why a Single-Cycle Processor?

A single-cycle architecture was selected to provide a clear understanding of the complete instruction execution flow before introducing pipelining and hazard handling.

Although not optimized for performance, it provides an excellent platform for learning processor architecture.

---

## Why Modular RTL?

Every major hardware block was implemented as an independent module.

Benefits include:

- Easier debugging
- Better readability
- Independent verification
- Simplified future upgrades

---

## Why Harvard Architecture?

Separate instruction and data memories simplify processor control and eliminate structural hazards in the single-cycle design.

---

## Why an Automated Build Workflow?

Manually editing instruction memory after every assembly change is inefficient.

A Python-based workflow automatically assembles programs and generates the instruction memory used during simulation, improving productivity and repeatability.

---

## Why Verify Using Assembly Programs?

Assembly programs validate the processor from the software perspective.

Instead of only checking individual signals, complete instruction execution paths can be verified under realistic conditions.

This approach also makes future regression testing significantly easier.