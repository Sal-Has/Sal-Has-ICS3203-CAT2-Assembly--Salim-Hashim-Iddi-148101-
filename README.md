# Assembly Program Compilation and Execution

This guide explains how to compile and run an assembly program written in NASM.

## **Requirements**
Make sure you have the following installed on your system:
- **NASM**: The Netwide Assembler for assembling the code.
- **LD**: The GNU linker for linking the object file.

## **How to Compile and Run the Assembly Code**

Follow these steps to compile and execute your assembly program:

1. **Assemble the Code**  
   Convert the human-readable assembly code (`filename.asm`) into an object file containing machine instructions:
   ```bash
   nasm -f elf64 filename.asm -o filename.o
2. **Link the Object File**  
   Produce an executable file from the object file:
   ```bash
   ld filename.o -o filename
3. **Run the Program**  
   Execute the compiled assembly program. If your program expects input or produces output, you will interact with it at this stage:
   ```bash
   ./filename

1. **Control Flow and Conditional Logic** **Task 1**: Classifies a user-input number as "POSITIVE," "NEGATIVE," or "ZERO" using conditional and unconditional jumps.

2. **Array Manipulation with Looping and Reversal** **Task 2**: Reverses an input array of integers in place using loops without additional memory.

3. **Modular Program with Subroutines for Factorial Calculation** **Task 3**: Calculates the factorial of a number using a subroutine with stack-based register preservation.

4. **Data Monitoring and Control Using Port-Based Simulation** **Task 4**: Simulates actions like turning on a motor or triggering an alarm based on a sensor value read from memory or an input port.

