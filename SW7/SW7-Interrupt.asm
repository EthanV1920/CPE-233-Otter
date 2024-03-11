SETUP:
	la    t0, ISA
	csrrw x0, mtvec, t0   #set ISA prog add
	li    s1, 0x11000000  #set mmio
	li    t0, 8
	csrrw x0, mstatus, t0 #enable interrupts
	li    s0, 0           #set up flag count
	li    sp, 0x10000     #initialize the stacker
LOOP:
	beqz  s0, NOFLAG      #check for flag count
	call  TOGGLE
NOFLAG:
	j     LOOP
TOGGLE:
	addi  sp, sp, -8      #push t0, t1 to stack
	sw    t0, (sp)
	sw    t1, 4(sp)
	lw    t0, (s1)        #load switches
	lw    t1, 0x20(s1)    #load leds
FLAGLOOP:
	xor   t0, t0, t1      #toggle leds
	addi  s0, s0, -1      #decrement flag count
	bnez  s0, FLAGLOOP    #loop for all flag count

	sw    t0, 0x20(s1)    #store toggled leds
	lw    t0, (sp)        #pop t0, t1 from stack
	lw    t1, 4(sp)
	addi  sp, sp, 8
	ret
ISA:
	addi  s0, s0, 1       #increment flag count
	mret
