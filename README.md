# Assembly Dojo Project

## Overview

This project demonstrates a simple assembly program using NASM, focusing on creating an executable with and without debugging symbols. It also covers how to verify the presence of debug information and how to run the executable in GDB for debugging purposes.

## Building the Project

### Assembling the Code with Debug Information

To assemble the code with debugging information, use the following command:

```sh
nasm -f elf64 -g -F dwarf main.asm -o main.o
```

- -f elf64: Specifies the output format as 64-bit ELF.
- -g: Includes debug information in the output file.
- -F dwarf: Specifies the DWARF format for the debug information.
- main.s: The input assembly source file.
- -o main.o: Specifies the name of the output object file.

## Assembling the Code Without Debug Information

To assemble the code without debugging information, use the following command:

```sh

nasm -f elf64 -o main.o main.asm
```

- -f elf64: Specifies the output format as 64-bit ELF.
- main.asm: The input assembly source file.
- -o main.o: Specifies the name of the output object file.

## Verifying the Object File

To verify the presence of debugging sections in the object file, use the readelf or objdump command.

Using readelf

```sh
readelf -S main.o
```

Look for sections like .debug_info, .debug_abbrev, .debug_line, etc. If these sections are present, it indicates that debugging information is included.

Using llvm-objdump

```sh

llvm-objdump -d main.o
```

This command also lists the sections in the object file, allowing you to verify the presence of debug information.

Linking the Object File
To link the object file and create the executable, use the following command:

```sh

ld -o main main.o
```

This command creates an executable named main from the object file main.o.

Running the Executable
To run the executable, simply use:

```sh

./main
```

Or build the project with `Just`(`Justfile`) by running::

```sh

just build
```

Assembles and links the source file to create the executable.

Run the project:

```sh

just run
```

Builds the project if necessary and then runs the executable.

Clean the project:

```sh

just clean
```

Removes the object and executable files.

Default action:

```sh

just
```

Executes the build rule by default.

Running GDB Debugger

To run the GDB debugger, ensure that the code is assembled with debugging information and use the following command:

```sh

gdb main
```

Once inside GDB, you can set breakpoints, run the program, and inspect variables.

Example GDB Session

Set a Breakpoint:

```sh

(gdb) break main.asm:13
```

Run the Program:

```sh

(gdb) run
```

Inspect Registers:

```sh

(gdb) info registers
```

Step Through Instructions:

```sh

(gdb) step
```

Disassemble Code:

```sh

(gdb) disassemble
```

By following these steps, you can effectively build, verify, link, and run your assembly code with or without debugging symbols. Running the GDB debugger with debugging symbols allows for a detailed inspection and debugging of your code.
