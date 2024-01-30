	lui  x30, 0x11000
	lw   x5, 0(x30) 		# load the switches in to memory
	li   x6, 0xfffffffc		# or value for multiple of 4 check
	li   x7, 0xfffffffe		# or value for odd check
	li   x8, 4095			# value added if !multiple4 and odd

	or   x9, x5, x6 		# or with x6 value to check for multiple4
	beq  x9, x6, isMultiple	# true if x5 is multiple of 4
	or   x9, x5, x7			# or with x7 value to check for odd
	bne  x9, x7, isOdd		# true if x5 is odd
	
	addi x5, x5, -1 		# subtract 1 from !odd and !multiple4
	j    end
			
isMultiple:
	not  x5, x5				# store not of switches
	j    end
isOdd:
	add  x5, x5, x8
	srli x5, x5, 1			# divide by shifting 1 bits right

end:
	sw   x5, 0x40(x30)		# store to sseg