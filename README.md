[![Open in Visual Studio Code](https://classroom.github.com/assets/open-in-vscode-f059dc9a6f8d3a56e377f745f24479a46679e63a5d9fe6f495e02850cd0d8118.svg)](https://classroom.github.com/online_ide?assignment_repo_id=5453736&assignment_repo_type=AssignmentRepo)


# RISC-V_MYTH_Workshop

This repository contains all the information required to build your own RISC-V Pipelined Core Processor. The proposed design supports the RV32I Base Integer Instruction Set, and is built using TL-Verilog on [Makerchip IDE](https://www.makerchip.com) Platform. This repository is intended for those who look forward to start learning the RISC-V Instruction Set Architecture.
</br>

# Table of Contents:
- [1. What is RISC-V?](#-What-is-RISC--V?)
- [2. Day 1 - Introduction to RISC-V ISA and GNU Compiler Toolchain](#Day-1---Introduction-to-RISC--V-ISA-and-GNU-Compiler-Toolchain)
- [3. Day - 2 - Introduction to ABI and Basic Verification Flow](#Day---2---Introduction-to-ABI-and-Basic-Verification-Flow)
- [4. Day - 3 - Digital Logic with TL-Verilog and Makerchip](#Day---3---Digital-Logic-with-TL--Verilog-and-Makerchip)
- [5. Day - 4 - Basic RISC-V CPU Microarchitecture](#Day---4---Basic-RISC--V-CPU-Microarchitecture)
- [6. Day - 5 Complete Pipelined RISC-V Core](#Day---5-Complete-Pipelined-RISC--V-Core)
- [7. Author](#Author)
- [8. Aknowledgements](#Aknowledgements)


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

The ABI names which are used to access the registers of the RISC-V CPU are given in this image below:

</br>

![abi_names](https://github.com/RISCV-MYTH-WORKSHOP/riscv_myth_workshop_aug21-Charaan27/blob/master/Day2/abi_names.PNG)

</br>

## Lab - 1 - Rewrite C program using ASM language
* We first write a C program 1to9_custom.c which prints the sum of numbers from 1 to 9. 
* Then we write an asm code load.S which contains assembly level instructions which are used to perform the operations mentioned in the C program.

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


## Lab - 2 - Simulate new C program with function call

* We first compile the asm code as shown above, then we get the output of the code by invoking the spike debugger using the command below:

  ```
  $ spike pk 1to9_custom.o
  ```
  
* Then we start to debug the code by running the debugger until pc is 100b0 using the command below:

  ```
  $ spike -d pk 1to9_custom.o
  ```
  
  ```
  $ until pc 0 100b0
  ```
  
* We can now view the address of the registers a0 and a1:

  ```
  $ reg 0 a0
  ```
  
  ```
  $ reg 0 a1
  ```
  
* The addresses of the above two registers are shown below:

</br>

![lab1](https://github.com/RISCV-MYTH-WORKSHOP/riscv_myth_workshop_aug21-Charaan27/blob/master/Day2/lab1.PNG)

</br>

* Next, we look at the address of the registers a0 and a1, by running the debugger until pc is 100bc:

</br>

![lab2](https://github.com/RISCV-MYTH-WORKSHOP/riscv_myth_workshop_aug21-Charaan27/blob/master/Day2/lab2.PNG)

</br>

## Lab - 3 - Running C program on RISC-V CPU:
In this lab, we are going to load the hex format of the C program into the RISC-V CPU written in Verilog and we are going to get the output, by accessing the memory of the RISC-V CPU for the display.

* Clone the following repository by entering the command below:

  ```
  $ git clone https://github.com/kunalg123/riscv_workshop_collaterals.git
  ```
  
* Enter the following commands below:

  ```
  $ cd riscv_workshop_collaterals
  ```
  
  ```
  $ ls -ltr
  ```
  
  ```
  $ cd labs
  ```
  
  ```
  $ ls -ltr
  ```
  
* The verilog code of the RISC-V CPU can be viewed by going into the file picorv32.v. This can be done by entering ```vim picorv32.v``` or ```less picorv32.v```
* Similarly the testbench for the RISC-V CPU can also be viewed by entering the commands ```vim testbench.v```
* The scripts which convert the C program to hex format can be viewed by entering the following command:

  ```
  $ vim rv32im.sh
  ```
  
* The scripts can be viewed in the image below:

</br>

![lab3](https://github.com/RISCV-MYTH-WORKSHOP/riscv_myth_workshop_aug21-Charaan27/blob/master/Day2/lab3.PNG)

</br>

# Day - 3 - Digital Logic with TL-Verilog and Makerchip

We first get familiarized with TL-Verilog and Makerchip. Transaction-Level Verilog(TL-Verilog) is a language extension to SystemVerilog that supports Transanction-Level Design. In this context, a transaction is an entity that moves through pipelines and queues. It might be a machine instruction, a packet flit, or a read and write operation into the memory. The corresponding transaction logic, that operates on the transaction can be placed anywhere along the transaction’s flow. More details about TL-Verilog can be found [here](https://arxiv.org/ftp/arxiv/papers/1811/1811.01780.pdf#:~:text=Abstract%E2%80%8B%E2%80%8B%E2%80%94Transaction%2DLevel,is%20an%20entity%20that%20moves)

On the other hand, we have Makerchip, which is a browser application that helps us to build digital circuitry using verilog on-line. It is developed and maintained by [Redwood EDA](https://www.redwoodeda.com). It also supports the TL-Verilog extension, which we are going to use for our designs. Head over to this [link](https://www.makerchip.com), and click on 'Launch Makerchip IDE' to get your environment to code.

TL-Verilog is an easy-to-use language extension which requires lesser amount of code to design circuitry, compared to other Hardware Description Languages present out there. Here, staging becomes very easy and it does not impact the behaviour of the logic. It also supports Pipelining and Validity which aid for a better and cleaner design. It comes with automated clock-gating facility and error checking is seamless.

## Lab - 1: Calculator using Combinational Logic:

Unlike Verilog, here there is no need to define the signals which are going to be used in the design. This makes designing easy. We use a 4x1 Multiplexer which in itself is a combinational circuit, and that becomes the base of the Combinational logic Calculator. The design of the circuit along with the output waveforms can be seen below.

</br>

![comb_calc](https://github.com/RISCV-MYTH-WORKSHOP/riscv_myth_workshop_aug21-Charaan27/blob/master/Day3_5/combinational_calculator.PNG)

</br>

## Lab - 2: Counter using Sequential Logic:
A counter is a sequential circuit, which increments the incoming value to it by 1, after every clock edge. Depending on the number of states that you could get through your counter, it is also called as mod-n counter. The image below shows the implementation of a counter using sequential logic. The usage of ```>>1``` indicates that the value of the signal is one state ahead of the present signal, and hence we get a flop into this design - and thus this becomes a sequential counter.

</br>

![seq_cnt](https://github.com/RISCV-MYTH-WORKSHOP/riscv_myth_workshop_aug21-Charaan27/blob/master/Day3_5/seq_counter.PNG)

</br>

## Lab - 3: Calculator using Sequential Logic:
Now, we update one input signal of the combinational logic calculator, with the next state of the output of the calculator, just like the counter logic. The code, and output waveforms can be viewed below.

</br>

![seq_calc](https://github.com/RISCV-MYTH-WORKSHOP/riscv_myth_workshop_aug21-Charaan27/blob/master/Day3_5/seq_calculator.PNG)

</br>

## Pipelining:
Pipelining is essentially a technique which is used to divide an entire circuit into different stages, and for each stage we provide different clock pulses of different frequencies. When a circuit is intended for high performance, the frequency of the clock pulse is increased, so that more number of instructions can be executed throughout the entire period. At the same time, we cannot fit too much of logic inside a high frequency clock pulse. Therefore, we go for pipelining where we separate the circuit into different pipe-stages and provide different clock pulses of different frequencies. 


## Lab - 4: Pipelined Calculator and Counter
The pipelined sequential calculator and coutner is shown below. 

</br>

![calc_cnt_pipeline](https://github.com/RISCV-MYTH-WORKSHOP/riscv_myth_workshop_aug21-Charaan27/blob/master/Day3_5/calculator_counter_pipeline.PNG)

</br>

## Lab - 5: Pipelined error diagram:
We define a few signals which carries some error. We put these error signals under different pipe-stages, and get this diagram.

</br>

![pipeline_error](https://github.com/RISCV-MYTH-WORKSHOP/riscv_myth_workshop_aug21-Charaan27/blob/master/Day3_5/pipeline_error.PNG)

</br>

## Lab - 6: 2 - Cycle Calculator:
From the one stage sequential calculator, we now get a two staged (i.e) two cycle sequential calculator. This extra stage is helpful for calculators operating in high frequency, and it completes all the calculations within the two stage design.

</br>

![2_cycle_calc](https://github.com/RISCV-MYTH-WORKSHOP/riscv_myth_workshop_aug21-Charaan27/blob/master/Day3_5/2_cycle_calc.PNG)

</br>

## Validity:
Validity is a process in which the design is validated (i.e) checked whether it is operating under the correct circumstances and conditions. It can be imagined as a when statement (i.e) 'when' this condition is valid/true the design below this condition gets executed. Validity helps in:

* Easier debugging of code
* Cleaner design
* Better error checking mechanism
* Automated clock gating

The valid condition is defined to the ```$valid``` signal, and the when condition is given as ```?$valid```, under which the code is present. If the 'when' condition is found to be valid, the code below the condition gets executed.

## Lab - 7: 2 - Cycle Calculator with Validity and Single-Value Memory:
We now, add a valid condition ```$valid_or_reset``` to our 2-cycle calculator code. If the condition is found to be valid, then the 2-cycle calculator gets executed. Along with that, we now add a feature to store single-value memory.

</br>

![2_cycle_valid_mem](https://github.com/RISCV-MYTH-WORKSHOP/riscv_myth_workshop_aug21-Charaan27/blob/master/Day3_5/2_cycle_calc_with_validation.PNG)

</br>

# Day - 4 Basic RISC-V CPU Microarchitecture
We will now shift our focus in designing a basic RISC-V CPU using all the concepts that was introduced earlier. First, we need to know the components that make up the RISC-V CPU Core. The idea is to start designing each component individually and putting them all together in the design. 

</br>

![riscv_block](https://github.com/RISCV-MYTH-WORKSHOP/riscv_myth_workshop_aug21-Charaan27/blob/master/Day3_5/riscv_block_dig.PNG)

</br>

The components of the RISC-V CPU are given below:

* Program Counter (PC)
* Instruction Decoder
* Imem - Rd (Instruction Memory)
* Branch
* Register File Read
* Register File Write
* Arithmetic Logic Unit (ALU)

## Lab - 1: Program Counter (PC):
A program counter, is a component which holds the address of the next instruction to be executed. Each time, it increments to the next instruction to be executed. For a 64-bit machine, the program counter is incremented with 4 every time.

</br>

![next_pc](https://github.com/RISCV-MYTH-WORKSHOP/riscv_myth_workshop_aug21-Charaan27/blob/master/Day3_5/next_pc.PNG)

</br>

## Lab - 2: Fetch Logic: 
During this phase, the processor gets or fetches the instruction to be executed from the Instruction Memory(IM) based on the address present in the Program Counter. 

</br>

![fetch](https://github.com/RISCV-MYTH-WORKSHOP/riscv_myth_workshop_aug21-Charaan27/blob/master/Day3_5/fetch.PNG)

</br>

## Lab - 3: Instruction Decode:
We are now introduced to six types of instructions, which are R, I, S, B, U, J type instructions. The Instruction Format consists of opcode, immediate value, source and destination address. The processor decodes the instruction based on the type and format of instruction. 

</br>

![inst_decode](https://github.com/RISCV-MYTH-WORKSHOP/riscv_myth_workshop_aug21-Charaan27/blob/master/Day3_5/inst_decode.PNG)

</br>

## Lab - 4: Register File Read:
Next up, we have the Register File Read design. This design performs two read operations and one write operation simultaneously. 

</br>

![reg_file_read](https://github.com/RISCV-MYTH-WORKSHOP/riscv_myth_workshop_aug21-Charaan27/blob/master/Day3_5/reg_file_read.PNG)

</br>

## Lab - 5: Register File Write:

</br>

![reg_file_write](https://github.com/RISCV-MYTH-WORKSHOP/riscv_myth_workshop_aug21-Charaan27/blob/master/Day3_5/reg_file_write.PNG)

</br>

## Lab - 6: ALU
ALU(Arithmetic and Logic Unit) is a combinational digital circuit, in which the Arithmetic and Logic Operations between the binary numbers is performed. The opcode contains the operation that is performed between the operands present in the instruction.

</br>

![alu](https://github.com/RISCV-MYTH-WORKSHOP/riscv_myth_workshop_aug21-Charaan27/blob/master/Day3_5/alu.PNG)

</br>

## Lab - 7: Control Logic:
Control Logic monitors the logic transfer, when there are branches coming up like function calls and interrupts. When the instruction is decoded, the branch target address is obtained and is passed to the Program Counter. When the operands are ready to be executed, the condition for branches are checked before proceeding further.

</br>

![branches](https://github.com/RISCV-MYTH-WORKSHOP/riscv_myth_workshop_aug21-Charaan27/blob/master/Day3_5/branches.PNG)

## Lab - 8: Testbench:
Finally, we now write a testbench for our overall CPU design.

</br>

![testbench](https://github.com/RISCV-MYTH-WORKSHOP/riscv_myth_workshop_aug21-Charaan27/blob/master/Day3_5/testbench.PNG)

</br>

# Day - 5 Complete Pipelined RISC-V Core
On this day, we attempt to pipeline our RISC-V deisgn which we obtain on day 4. Additionally, we also add a Data Memory Element which supports all the base integer instruction sets, which corresponds to the Load-Store Architecture. We also added necessary logic to prevent branching hazards which arise due to pipelining. Later, we go for the testing part, by adding load-store assembly modules. Finally, we include the Jump instructions(JAL and JALR), and thus we arrive at a fully-functional, pipelined, RISC-V core.
Finally,we developed the pipelined model for the core developed on Day 4.

</br>

![pipelined_riscv_core](https://github.com/RISCV-MYTH-WORKSHOP/riscv_myth_workshop_aug21-Charaan27/blob/master/Day3_5/pipelined_riscv_core.PNG)

</br>

![pipelined_riscv_core_waveform](https://github.com/RISCV-MYTH-WORKSHOP/riscv_myth_workshop_aug21-Charaan27/blob/master/Day3_5/pipelined_waveform.PNG)

</br>

# Author
- Charaan S, Student at Madras Institute of Technology, Anna University. - kumarcharaan27@gmail.com 

# Aknowledgements
- [Kunal Ghosh](https://github.com/kunalg123), Co-founder (VSD Corp. Pvt. Ltd). 
- [Steve Hoover](https://github.com/stevehoover), Founder, Redwood EDA.
