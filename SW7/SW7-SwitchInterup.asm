# Author: Ethan Vosburg 
# Date: 3/4/2024 
# Description: This program reads swtiches to the leds and when an interupt
# is triggerd, it will check the value of the past two interupts and change the
# status of the leds if needed.

# Initialize the registers

	lui 	s0, 0x11000			# Load the address of the switches into s0
	li 		s1, 0x0				# Intr curent value reg
	li 		s2, 0x1 			# Intr prev value reg
	la		t0, ISR
	csrrw	x0, mtvec, t0 		# Load ISR address
	li		t0, 8
	csrrw 	x0, mstatus, t0

MAIN:
	lw 		t0, 0(s0)			# Read switches

	# Check if past two interupts are same
	xor 	t1, s1, s2			# Check if past == pres
	# bgt		t1, zero, ISBLANK	# Branch if past != pres
	seqz	t5, t1				# Flag if prev == past
	# li		t5, 0x1				# Flag is prev == pres

	# Check if reset button is pressed
	lw 		t6, 200(s0)			# Get Button value rst if 1
	# neg 	t6, t6

# ISBLANK:
	beqz	t6, NOTRESETDISPLAY	# Reset if button pushed
	li 		t6, 0x0
	sw		zero, 0x200(s0)
	li		t1, 8
	csrrw	zero, mstatus, t1
	li 		s1, 0x0				# Intr curent value reg
	li 		s2, 0x1 			# Intr prev value reg

NOTRESETDISPLAY:
	beqz	t5, DISPLAY			# Blank display is same
	# Blank display
	li		t1, 0
	csrrw	zero, mstatus, t1
	sw		zero, 20(s0)
	j		MAIN
	

DISPLAY:
	sw		t0, 20(s0)
	j 		MAIN


ISR:
	add 	s2, s1,	zero 
	lw		s1, 0(s0)
	mret
