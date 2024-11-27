To run the code follow the following steps
once the code is written 
 nasm -f elf64 filename.asm -o filename.o :Converts the human-readable assembly code (filename.asm) into an object file (filename.o) containing machine instructions.
 ld filename.o -o filename :Produces an executable file (filename) from the object file.
 ./filename :Executes the compiled assembly program. If your program expects input or produces output, this is where it interacts with the user.
