	lui  x30, 0x11000
	lw   x5, 0(x30) 		# load the switches in to memory
	li   x6, 0x00008000 	# load the comparison number in to memory

	bge  x5, x6, isGreater 	# check is number in switches is >= 32768
	slli x5, x5, 1  		# multiply by 2 doing a shift 1 bit
	j    end
	
isGreater:
	srli x5, x5, 2			# divide by shifting 2 bits right

end:
	sw   x5, 0x40(x30)		# store to sseg
