# Define variables for source, object, and executable files
sources := "demo.s"
objects := "demo.o"
executable := "demo"

# Define the build rule
build:
    @echo "Assembling..."
    nasm -f elf64 -g -F dwarf {{sources}} -o {{objects}}
    @echo "Linking..."
    ld -o {{executable}} {{objects}}

# Define the run rule
run: build
    @echo "Running the program..."
    ./{{executable}}

# Define the clean rule
clean:
    @echo "Cleaning up..."
    rm -f {{objects}} {{executable}}

# Default rule
default: build
