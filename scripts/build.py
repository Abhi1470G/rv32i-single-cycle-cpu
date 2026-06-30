import subprocess
from pathlib import Path
import sys

ROOT = Path(__file__).resolve().parent.parent

ASM_DIR = ROOT / "asm"
BUILD_DIR = ROOT / "build"
MEM_DIR = ROOT / "mem"

BUILD_DIR.mkdir(exist_ok=True)
MEM_DIR.mkdir(exist_ok=True)

if len(sys.argv) != 2:
    print("\nUsage:")
    print("    python build.py <assembly_file_name>\n")
    print("Example:")
    print("    python build.py memory_test\n")
    sys.exit(1)

name = sys.argv[1]

asm_file = ASM_DIR / f"{name}.S"

if not asm_file.exists():
    print(f"\nERROR: {asm_file.name} not found inside asm folder.\n")
    sys.exit(1)

obj_file = BUILD_DIR / f"{name}.o"
elf_file = BUILD_DIR / f"{name}.elf"
bin_file = BUILD_DIR / f"{name}.bin"
lst_file = BUILD_DIR / f"{name}.lst"

program_mem = MEM_DIR / "program.mem"

print("\n")
print("Assembling")

subprocess.run(
    [
        "riscv-none-elf-as",
        str(asm_file),
        "-o",
        str(obj_file)
    ],
    check=True
)

print("\n")
print("Linking")

subprocess.run(
    [
        "riscv-none-elf-ld",
        str(obj_file),
        "-Ttext=0x0",
        "-o",
        str(elf_file)
    ],
    check=True
)

print("\n")
print("Generating Binary")

subprocess.run(
    [
        "riscv-none-elf-objcopy",
        "-O",
        "binary",
        str(elf_file),
        str(bin_file)
    ],
    check=True
)

print("\n")
print("Generating Listing")

with open(lst_file, "w") as listing:
    subprocess.run(
        [
            "riscv-none-elf-objdump",
            "-d",
            str(elf_file)
        ],
        stdout=listing,
        check=True
    )

print("\n")
print("Generating program.mem")

data = bin_file.read_bytes()

with open(program_mem, "w") as mem:

    for i in range(0, len(data), 4):

        word = data[i:i+4]

        while len(word) < 4:
            word += b'\x00'

        value = int.from_bytes(word, byteorder="little")

        mem.write(f"{value:08x}\n")

print("\n")
print("BUILD SUCCESSFUL")

print(f"\nAssembly : {asm_file.name}")
print(f"Object   : {obj_file.name}")
print(f"ELF      : {elf_file.name}")
print(f"Binary   : {bin_file.name}")
print(f"Listing  : {lst_file.name}")
print(f"Program  : {program_mem}")

print("\nReady for Vivado simulation.\n")