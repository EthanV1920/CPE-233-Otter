lui x10, 69632
addi x30, x0, 10
jump:
lh x15, 0(x10)
sra x20, x15, x30
xor x12, x20, x15
sw x12, 64(x10)
jal x0, jump