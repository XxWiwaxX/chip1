<!---

This file is used to generate your project datasheet. Please fill in the information below and delete any unused
sections.

You can also include images in this folder and reference them in the markdown. Each image must be less than
512 kb in size, and the combined size of all images must be less than 1 MB.
-->

## How it works

This project is an 8-bit Synchronous Arithmetic Logic Unit (ALU). It is designed to perform various mathematical and logical operations on two input numbers ($A$ and $B$) and store the result in an internal register on every clock cycle.The ALU uses a 3-bit OpCode (operation selector) to determine the function. Because of the limited pin count on a single Tiny Tapeout tile, the inputs are split as follows:Input A: 5-bit value (using the lower bits of ui_in).Input B: 8-bit value (using the uio_in bidirectional pins).OpCode: 3-bit selector (using the upper bits of ui_in).
OpCode (Binary),Operation,Description
000,ADD,A+B
001,SUB,A−B
010,AND,Bitwise AND
011,OR,Bitwise OR
100,XOR,Bitwise XOR
101,NOT,Invert bits of A
110,SHL,Shift A left by 1 bit
111,SHR,Shift A right by 1 bit

## How to test

To test the ALU, you will need to provide a clock signal and set the input pins.Reset: Pull rst_n (Reset) Low for at least one clock cycle to clear the internal register, then pull it High to start.Set Operation: Set the top three bits of ui_in (ui[7:5]) to the desired OpCode (e.g., 000 for Addition).Provide Data: * Set the bottom five bits of ui_in (ui[4:0]) for Operand $A$.Set the eight uio_in pins for Operand $B$.Clock it: Pulse the clk pin. On the rising edge, the result of the operation will be stored and appear on the output pins uo_out[7:0].

## External hardware

No specialized external hardware is required. The design can be tested using:Dip Switches: To manually set the inputs for $A$, $B$, and the OpCode.LEDs: To visualize the 8-bit output result on uo_out.Logic Analyzer: To verify high-speed timing and transitions.
