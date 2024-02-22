	#Software Assignment 5 part 2
	
.data	#for testing purposes
ARRAY:  .word 0x37bb8058, 0x5f62e73d, 0x51b65779, 0x5171037c, 0x7cc45e5d, 0xffffffff,0xb0edfd45, 0xb951fec2, 0x389e3e3c, 0x5fdc9f5d, 0x62d2abf7, 0x5b497b03, 0xded4cdc8, 0xb7cb388b, 0x4ac7d922, 0x3232b528, 0xa778fb66, 0xaf00ec90, 0x5e77321a, 0x863c7279, 0x8d9e1680	
	
	
.text 
	lui s0, 0x11000		#MMIO pointer
	li  sp, 0x10000		#stack pointer
	li  s1, 0xffffffff	#first loop comparator
	addi  s2, sp, 0		#second loop comparator
	#la  s3, ARRAY		#array for quick testing
	
Load:	
	lw  t0, 0(s0)		#grabs switches
	#lw  t0, 0(s3)		#testing purposes grabs from array
	beq t0, s1, Display
	addi sp, sp, -4		#increment the stack pointer
	sw  t0, 0(sp)		#Push to stack complete
	#addi s3, s3, 4		#testing array
	j Load
	
	
Display:
	beq sp, s2, END
	lw t0, 0(sp)
	addi sp, sp, 4		#pop from stack
	sw t0, 0x20(s0)		#send the pop'd data to LED's
	#addi s0, s0, 4		#testing purposes changes where it send
	j Display
	
END:
	#nothing here just ends the code