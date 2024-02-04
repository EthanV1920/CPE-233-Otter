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
    .space 40

.text
    # Initialize registers
    li      t0, 0           # Counter for loops
    li      t1, 0           # Counter for bubble sort 
    li      t2, 40          # Condition for finishing switch read
    lui     s0, 0x11000     # Load io address
    la      s1, sortArray   # Load array address

    # Read in switches from 0x11000000
readSwitches:
    bge     t0, t2, endLoad
    lw      t6, 0(s0)       # Read the swithches in to a t6 temporary
    sw      t6, 0(s1)       # Store the switch value in .data
    addi    s1, s1, 4       # Iterate to the next addres
    addi    t0, t0, 4       # Iterate the loop variable
    j       readSwitches

endLoad:
    la      s1, sortArray   # Reset array address
    li      t0, 4           # Reset counter for loop

    bge     t0, t2, bubbleEnd   # Bubble Sort end
    bge     t1, t2, TODO
    lw      t4, 0(s1)           # Load j
    lw      t5, -4(s1)          # Load j + 1
    bge     t4, t5, noSwap      # If left number is greater, swap
    sw      t5, 0(s1)
    sw      t4, -4(s1)

bubbleEnd:
