.data
	ARRAY: .word 0 # 0x6000
		.word 1 # 0x6004
		.space 92 # 92 bytes = 23 words


.text
	li t0, 0
	li t6, 92 # conditional change to 92 when submitting
	la s0, ARRAY # Fn-2 Address
	la s1, ARRAY # Fn-1 Address
	li s2, 0x11000020 # LEDs address
	
	CreateFibo:     bge t0, t6, EndCreate
			lw t3, 0(s0) # Fn-2 Pointer
			lw t4, 4(s1) # Fn-1 Pointer
			add t5, t3, t4 # creates the next number in the Fibonacci sequence
			addi s0, s0, 4 # increments to the next Fn-2
			addi s1, s1, 4 # increments to the next Fn-1
			sw t5, 4(s0) # stores Fn into the next address of the array
			addi t0, t0, 4 # increments to the next word address
	j CreateFibo
	
	EndCreate: # now we get ready to subtract the Fibo numbers and store them to LEDs
		 li t0, 12
		 li t6, 100 # conditional change to 100 when submitting
		 
		 # resetting our address pointers
		 sub s0, s0, t6
		 addi s0, s0, 8 # s0 points to Fn-3 initialized to 0
		 sub s1, s1, t6
		 addi s1, s1, 20 # s1 points to Fn initialized t0 12

		
	SubFibo: bge t0, t6, end
		 lw t3, 0(s0) # Fn-3 Pointer
		 lw t4, 0(s1) # Fn Pointer
		 sub t5, t4, t3 # creates the next value to store into LEDs
		 addi s0, s0, 4 # increments to the next Fn-3
		 addi s1, s1, 4 # increments to the next Fn
		 sw t5, 0(s2) # stores our value into the LEDs
		 addi t0, t0, 4
	j SubFibo
	
	end: nop