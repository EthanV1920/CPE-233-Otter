# This is the file that will be used to generate the instructions
# used to test that the immediate generateor is working correctly.
ZEROLABLE:
# Testing U-Type Immediate Generation
lui t2, 0x00000
lui t0, 0xaaaaa
lui t1, 0x55555
lui t3, 0xfffff

# Testing I-Type Immediate Generation
andi t2, t2, 0x000
andi t0, t0, 0x2aa
andi t1, t1, 0x555
andi t3, t3, 0x7ff

# Testing S-Type Immediate Generation
sb t2, 0x000(t2)
sb t0, 0x2aa(t0)
sb t1, 0x555(t1)
sb t3, 0x7ff(t3)

# Testing J-Type Immediate Generation
jal x0, ZEROLABLE  # jump to 0x00000 and save position to ra
jal x0, ZEROLABLE  # jump to 0x00000 and save position to ra
jal x0, ZEROLABLE  # jump to 0x00000 and save position to ra
jal x0, ZEROLABLE  # jump to 0x00000 and save position to ra

# Testing B-Type Immediate Generation
bge t2, t2, ZEROLABLE
bge t2, t2, ZEROLABLE
bge t2, t2, ZEROLABLE
bge t2, t2, ZEROLABLE