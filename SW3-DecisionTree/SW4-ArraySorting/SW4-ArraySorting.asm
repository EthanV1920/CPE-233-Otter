# file: SW4-ArraySorting.asm
# brief: Assembly code for sorting an array.
# 
# This file contains the assembly code for sorting an array of 10 32-bit
# unsigned numbers. The sorting algorithm that was implemented in this 
# project is bubble sort.
# 
# author: Ethan Vosburg
# date: 02-03-2024

.data
sortArray:
    # Create space in an array for 10 32-bit unsigned numbers
    .space 40

.text
    # Initialize registers
    li      t0, 0               # Counter for loops
    li      t1, 0               # Counter for bubble sort 
    li      t2, 40              # Condition for finishing switch read
    li      t3, 36              # Condition for Bubble sort pass
    lui     s0, 0x11000         # Load io address
    la      s1, sortArray       # Load array address

readSwitches:
    # Read in switches from 0x11000000
    bge     t0, t2, endLoad     # Check if loading from switches is done
    lw      t6, 0(s0)           # Read the switches in to a t6 temporary
    sw      t6, 0(s1)           # Store the switch value in sortArray
    addi    s1, s1, 4           # Iterate to the next address
    addi    t0, t0, 4           # Iterate the loop variable
    j       readSwitches

endLoad:
    li      t0, 4               # Reset counter for loop

bubbleBegin:
    bgeu    t0, t2, bubbleEnd   # Check if bubble sort is done 
    la      s1, sortArray       # Reset array address for next pass
    li      t1, 0               # Reset the pass counter

passBegin:
    bgeu    t1, t3, passDone    # Check is the current pass is done
    lw      t4, 0(s1)           # Load j
    lw      t5, 4(s1)           # Load j + 1
    bleu    t4, t5, noSwap      # If the left number is greater, swap
    # Swap the values
    sw      t5, 0(s1)
    sw      t4, 4(s1)

noSwap:
    addi    s1, s1, 4           # Iterate the index counter
    addi    t1, t1, 4           # Iterate index count
    j       passBegin

passDone:
    addi    t0, t0, 4           # Iterate pass count
    j       bubbleBegin
bubbleEnd:

    li      t0, 0               # Counter for loops
    la      s1, sortArray       # Reset array address for write-out 

writeSwitches:
    # Wtite to the switches at 0x11000020
    bge     t0, t2, endWrite    # Check is writing out switches is done
    lw      t6, 0(s1)           # Read Read the switch value in sortArray
    sw      t6, 0x20(s0)        # Write t6 to the switches
    addi    s1, s1, 4           # Iterate to the next address
    addi    t0, t0, 4           # Iterate the loop variable
    j       writeSwitches

endWrite:
# Program Done