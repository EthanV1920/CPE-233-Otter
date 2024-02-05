# file: SW4-ArraySorting.asm
# brief: Assembly code for sorting an array.
# 
# This file contains the assembly code for sorting an array using a specific algorithm.
# The sorting algorythm that was implemented in this project is bubble sort.
# 
# author: Ethan Vosburg
# date: 02-03-2024

.data
sortArray:
    # .space 40
    .word 9
    .word 80
    .word 700
    .word 6
    .word 5
    .word 4
    .word 3
    .word 2
    .word 1
    .word 0

.text
    # Initialize registers
    li      t0, 0               # Counter for loops
    li      t1, 0               # Counter for bubble sort 
    li      t2, 40              # Condition for finishing switch read
    li      t3, 36              # Condition for Bubble sort pass
    lui     s0, 0x11000         # Load io address
    la      s1, sortArray       # Load array address

j endLoad

    # Read in switches from 0x11000000
readSwitches:
    bge     t0, t2, endLoad
    lw      t6, 0(s0)           # Read the swithches in to a t6 temporary
    sw      t6, 0(s1)           # Store the switch value in sortArray
    addi    s1, s1, 4           # Iterate to the next addres
    addi    t0, t0, 4           # Iterate the loop variable
    j       readSwitches

endLoad:
    li      t0, 4               # Reset counter for loop

bubbleBegin:
    bge     t0, t2, bubbleEnd   # Check if bubble sort is done 
    la      s1, sortArray       # Reset array address for next pass
    li      t1, 0               # Reset the pass counter

passBegin:
    bge     t1, t3, passDone
    lw      t4, 0(s1)           # Load j
    lw      t5, 4(s1)           # Load j + 1
    ble     t4, t5, noSwap      # If left number is greater, swap
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
    la      s1, sortArray       # Reset array address for write out 

writeSwitches:
    # Wtite to the switches at 0x11000020
    bge     t0, t2, endWrite
    lw      t6, 0(s1)           # Read Read the switch value in sortArray
    sw      t6, 0x20(s0)          # Write t6 to the swithches
    addi    s1, s1, 4           # Iterate to the next addres
    addi    t0, t0, 4           # Iterate the loop variable
    j       writeSwitches

endWrite:
# Program Done