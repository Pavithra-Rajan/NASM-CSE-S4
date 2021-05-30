# NASM-CSE-S4
Few programs written in Nasm <br/>

## Assembling
nasm -f elf sample.asm <br/>
This creates an object file, sample.o in the current directory. <br/>
## Creation of executable file
ld -melf_i386 sample.o -o test_file <br/>
This creates an executable file of the name test_file. <br/>
## Program execution
./test_file <br/>
For example, if the program to be run is palindrome.asm <br/>
nasm -f elf palindrome.asm <br/>
ld palindrome.o -o test <br/>
./test <br/>
