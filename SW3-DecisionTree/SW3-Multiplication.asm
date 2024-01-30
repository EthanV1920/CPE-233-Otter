    # Setup registers 
    lui     x5, 0x00000 # Output value from multiplication
    lui     x11, 0x11000 # Define Address for switch input
    lui     x9, 0x00000 # Current place counter
    addi    x10, x0, 0x00000010 # Number of places to multiply

    # Recive user input and format
    lw      x6, 0(x11) # Load switch values to x6
    add     x7, x0, x6 # Load switch values to x7
    srli    x7, x7, 16 # Isolate second number

multiplyStep:
    # Begin multiplication
    bge     x9, x10, end # If x9 >= x10 then end
    andi    x13, x6, 1 # Check is LSB is 1
    beqz    x13, isZero # Branch if LSB is 0
    
    # Add shifted value to running total and then shift 
    # registers and increment index
    add     x5, x5, x7
    srli    x6, x6, 1
    slli    x7, x7, 1
    addi    x9, x9, 1
    j       multiplyStep

isZero:
    # Shift registers and increment index
    srli    x6, x6, 1
    slli    x7, x7, 1
    addi    x9, x9, 1
    j       multiplyStep
    

end:
    sw      x5, 0x40(x11) # Store final value