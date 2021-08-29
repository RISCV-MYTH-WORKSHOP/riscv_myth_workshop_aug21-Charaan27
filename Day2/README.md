This folder contains the labwork done on Day2. This lab work is related to the Application Binary Interface (ABI).
</br>
- The main_code.png file contains the C program 1to9_custom.c and the assembly code load.S.
- The objdump.png file contains the object file generated through the commands 

  ```
  $ riscv64-unknown-elf-gcc -Ofast -mabi=lp64 -march=rv64i -o 1to9_custom.o 1to9_custom.c load.S
  ```  
  ```
  $ riscv64-unknown-elf-objdump -d 1t09_custom.o | less
  ```
- The first lab contains the register address of a0 and a1. The address is obtained by running spike debugger until PC is 100b0
- The second lab contains the register address of a0 and a1. The address is obtained by running spike debugger until PC is 100bc
- The third lab contains the contents of the rv32im.sh script
