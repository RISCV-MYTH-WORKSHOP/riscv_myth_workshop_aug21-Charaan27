[![Open in Visual Studio Code](https://classroom.github.com/assets/open-in-vscode-f059dc9a6f8d3a56e377f745f24479a46679e63a5d9fe6f495e02850cd0d8118.svg)](https://classroom.github.com/online_ide?assignment_repo_id=5453736&assignment_repo_type=AssignmentRepo)


# RISC-V_MYTH_Workshop

This repository contains all the information required to build your own RISC-V Pipelined Core Processor. The proposed design supports the RV32I Base Integer Instruction Set, and is built using TL-Verilog on [Makerchip IDE](https://www.makerchip.com) Platform. This repository is intended for those who look forward to start learning the RISC-V Instruction Set Architecture.
</br>

# What is RISC-V?
The RISC-V ISA is a standard Instruction Set Architecture which is open-sourced and free to use. It was developed at the University of California, Berkely in the early 2010s. The RISC-V is open sourced and thus it enables anyone to use it in their designs easily, which is not possible through commercial ISAs available. The [RISC-V international](https://riscv.org) - a global not-for-profit organization, defines RISC-V as a _completely open ISA that is freely available to academia and industry_. 

## Features:
The RISC-V ISA is fundamentally a base integer ISA, that must be present in almost every implementation along with a few optional extensions to the base ISA. The base of RISC-V ISA is restricted to a minimal set of instructions which is sufficient to provide a reasonable target for linkers, compilers, assemblers and operating systems. Hence it provides a convenient ISA and around which more customized processor ISAs can be built. The interesting features of RISC-V ISA are:
</br>
* Supports the revised 2008 IEEE-754 floating-point standard.
* Not restricted to only simulations or binary translation. It supports direct native hardware implementation too.
* It is essentially a load-store architecture, similar to the RISC ISA.
* It supports for highly-parallel multicore or manycore implementations, including heterogeneous multiprocessors.
* Each base integer instruction set is characterized by the width of the integer registers and the corresponding size of the user address space. The base integer instruction sets use a two’s-complement representation for signed integer values.
* There are two primary base integer variants, RV32I and RV64I, which provide 32-bit or 64-bit user-level address spaces respectively. There's also a 128bit base integer variant called RV32128I.
* Optional variable-length instructions to both expand available instruction encoding space and to support an optional dense instruction encoding for improved performance, static code size, and energy efficiency.
</br>

# Day 1 - Introduction to RISC-V ISA and GNU Compiler Toolchain:
The introdcution to RISC-V ISA was given, and the demonstration on how the high-level languages present in the applications running on the machine were converted to assembly level languages which gets abstracted into the chip layout was shown. The high-level language (say a C program that contains the code of the functioning of a stopwatch) generated from the Operating System, is first passed to a compiler which compiles the code into a set of instructions(.exe file). In this case the instructions comply with the RISC-V standards, defined in the CPU core. This file is now passed to an assembler which translates all the instructions to binary and it is sent to the hardware for processing. The hardware required for processing the assembly code is synthesised through an RTL netlist. Now we are introduced to the type of instructions present in the RISC-V ISA which are 

* pseudo instructions
* **Base Integer Instructions RV64I**
* Multiply Extension RV64M
* Base and Multiply Extension RV64IM
* Single and Double Precision Floating Point Extension RV64F and RV64D

## Lab - 1: C Program To Compute Sum From 1 to N

* We first write a C program which calculates the sum from 1 to n, where n can be any natural number defined by the user. We save it as sum1ton.c
* In order to run the program we enter the following commands:

  ```
  $ gcc sum1ton.c
  ```
  ```
  $ ./a.out
  ```
</br>

## GNU Compiler Toolchain:
The GNU Compiler Toolchain is a suite of compiler tools that can be used to compile code and create programs and libraries. The various components of this toolchain are preprocessor, compiler, assembler and linker.

We are going to specifically look at the RISC-V toolchain which is used to compile the above C program.

## Lab - 2: RISC-V Toolchain:
* The RISC-V compiler can be invoked by entering any one of the following commands

  ```
  $ riscv64-unknown-elf-gcc -O1 -mabi=lp64 -march=rv64i -o sum1ton.o sum1ton.c
  ```
  
  ```
  $ riscv64-unknown-elf-gcc -Ofast -mabi=lp64 -march=rv64i -o sum1ton.o sum1ton.c
  ```
  
* To disassemble the code and view the object file, enter the following command

  ```
  $ riscv64-unknown-elf-objdump -d sum1ton.o | less
  ```

* To run the SPIKE simualtor on the risc-v object file enter the following command

  ```
  $ spike pk sum1ton.o
  ```
  
* To use Spike as a debugger, enter the following command

  ```
  $ spike -d pk sum1ton.o
  ```
  
* You can run the debugger using the command ```until pc 0 <reg_no>```
</br>

## Lab - 3: Integer Number Representation:
Before looking into the integer representations, let us get famiiliarized with some terminologies.

* 1 byte = 8 bits
* 1 word = 32 bits = 4 bytes
* 1 doubleword = 64 bits = 8 bytes

* RISC-V Doubleword can represent 0 - (2<sup>64</sup>-1) unsigned integers or positive numbers
* RISC-V Doubleword can represent -2<sup>63</sup> to (2<sup>63</sup>-1) signed integers or positive/negative numbers

The RISC-V instructions which work on the numbers defined above are called as **Base Integer Instruction RV64I**.

# Day - 2 - Introduction to ABI and Basic Verification Flow

In day 2, we extend our discussion of assembly level codes and we are also introduced to the Application Binary Interface(ABI). It is an interface established between two binary program modules, most often it is an interface between the Operating System of the machine and the user program. Here the interface is between codes which are usually low-level and hardware-dependent (assembly level) unlike the API(Application Program Interface), which is an interface between high-level and human-readable codes. It is also called as a System Call Interface and it utilizes the hardware resources.

As the name suggests, the application program tries to access the registers present in the hardware design through System Calls. For RISC-V ISA, the number of registers present is 32, and the width of the register is defined by a keyword called **X_LEN** which is:

* 32bit for RV32
* 64bit for RV64

## Lab - 1 - Rewrite C program using ASM language
* We first write a C program 1to9_custom.c which prints the sum of numbers from 1 to 9. 
* Then we write an asm code load.S which contains assembly level instructions which are used to perform the operations mentioned in the C program.
* 
</br>

![asm code](https://github.com/RISCV-MYTH-WORKSHOP/riscv_myth_workshop_aug21-Charaan27/blob/master/Day2/main_code.PNG)

</br>

* Command used to compile the asm code is

  ```
  $ riscv64-unknown-elf-gcc -Ofast mabi=lp64 -march=rv64i -o 1to9_custom.o 1t09_custom.c load.S
  ```
  
* Command used to view the object file is

  ```
  $ riscv64-unknown-elf-objdump -d 1t09_custom.o | less
  ```
</br>

![obj code](https://github.com/RISCV-MYTH-WORKSHOP/riscv_myth_workshop_aug21-Charaan27/blob/master/Day2/objdump.PNG)

</br>
