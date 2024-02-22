# file: SW5-StackOperation.asm 
# brief: Assembly code for stack operations 
# 
# This file contains the assembly code for loading the stack with values and
# then popping them off and displaying them on the LED's.
# 
# author: Ethan Vosburg
# date: 02-16-2024	
	
	lui s0, 0x11000		        # Declare MMIO base address 
	li  s1, 0xffffffff	        # Declare comparison value
	li  sp, 0x10000		        # Declare stack pointer
	li  s2, 0x10000		        # Declare end of stack
	
valueLoad:	
	lw  t0, 0(s0)		        # Get values from switches 
	beq t0, s1, valueDisplay    # Branch if value is 0xffffffff 
	addi sp, sp, -4		        # Increment the stack pointer
	sw  t0, 0(sp)		        # Push the value onto the stack
	j valueLoad
	
	
valueDisplay:
	beq sp, s2, END             # Branch if the stack is empty
	lw t0, 0(sp)                # Get the value from the stack
	addi sp, sp, 4		        # Pop the value off the stack 
	sw t0, 0x20(s0)		        # Display the value on the LED
	j valueDisplay
	
END: