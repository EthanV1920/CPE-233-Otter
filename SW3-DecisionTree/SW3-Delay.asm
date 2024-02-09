    # Setup registers 
    lui     x11, 0x11000    # Define the Address for the switch input
    lui     x5, 0x00000     # Output value from multiplication

    li      x6, 5000        # Define delay time by cycle count
    # Calculation of the cycle count:
    # Each instruction takes 40ns noting that there are 4 
    # instructions in the count loop this means that one loop
    # takes 160ns. Divideing 0.5 seconds by the 160ns results
    # in 3,125,000 cycles.

    # Recive user input and format
    lw      x9, 0(x11)      # Load switch values to x9

countLoop:
    # Count up until the desired time is met and the move
    # forward in the program
    bge     x5, x6, end
    addi    x5, x5, 1       # Increment loop counter
    nop
    j       countLoop

end:
    sw      x9, 0x40(x11)   # Store final value