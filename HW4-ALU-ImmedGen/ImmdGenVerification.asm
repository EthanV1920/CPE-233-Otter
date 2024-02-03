# This is the file that will be used to generate the instructions
# used to test that the immediate generateor is working correctly.
ZEROLABLE:
# Testing U-Type Immediate Generation
lui t0, 0x00000
lui t1, 0xaaaaa
lui t2, 0x55555
lui t3, 0xfffff

ONELABLE:
# Testing I-Type Immediate Generation
andi t0, t2, 0x000
andi t1, t0, 0x2aa
andi t2, t1, 0x555
andi t3, t3, 0x7ff

TWOLABLE:
# Testing S-Type Immediate Generation
sb t0, 0x000(t0)
sb t0, 0x2aa(t0)
sb t0, 0x555(t0)
sb t0, 0x7ff(t0)

THREELABLE:
# Testing J-Type Immediate Generation
jal x0, ZEROLABLE 
jal x0, ONELABLE  
jal x0, TWOLABLE 
jal x0, THREELABLE 

# Testing B-Type Immediate Generation
bge t2, t2, ZEROLABLE
bge t2, t2, ONELABLE
bge t2, t2, TWOLABLE
bge t2, t2, THREELABLE