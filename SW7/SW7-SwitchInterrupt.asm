# Author: Ethan Vosburg 
# Date: 3/4/2024 
# Description: This program reads switches to the LEDs and when an interrupt
# is triggered, it will check the value of the past two interrupts and change the
# Status of the LEDs if needed.

	lui 	s0, 0x11000			# Load the address of the switches into s0
	li 		s1, 0x0				# Intr curent value reg
	li 		s2, 0x1 			# Intr prev value reg
	la		t0, ISR
	csrrw	x0, mtvec, t0 		# Load ISR address
	li		t0, 8
	csrrw 	x0, mstatus, t0		# Allow interrupts

MAIN:
	lw 		t0, 0(s0)			# Read switches

	# Check if the past two interrupts are the same
	xor 	t1, s1, s2			# Check if past == pres
	seqz	t5, t1				# Flag if prev == past

	# Check if the reset button is pressed
	lw 		t6, 0x200(s0)			# Get Button value rst if 1

	# Reset display if triggered
	beqz	t6, NOTRESETDISPLAY	# Reset if button pushed
	li 		t6, 0x0
	sw		zero, 0x200(s0)		# Reset Button
	li		t1, 8
	csrrw	zero, mstatus, t1	# Allow Interupts 
	li 		s1, 0x0				# Intr curent value reg
	li 		s2, 0x1 			# Intr prev value reg

NOTRESETDISPLAY:
	beqz	t5, DISPLAY			# Blank display if same
	li		t1, 0
	csrrw	zero, mstatus, t1	# Prevent interrupts
	sw		zero, 20(s0)		# Blankc LEDs
	j		MAIN
	

DISPLAY:
	sw		t0, 20(s0)			# Display switch values on LEDs
	j 		MAIN


ISR:
	add 	s2, s1,	zero 		# Move current val to past val
	lw		s1, 0(s0)			# Get current val
	mret
