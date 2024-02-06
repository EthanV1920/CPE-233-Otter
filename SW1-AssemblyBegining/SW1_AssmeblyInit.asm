lui x5, 0x11000
lh  x6, 0(x5)
lh  x7, 0(x5)
lh  x8, 0(x5)
add x9, x6, x7
add x9, x9, x8
sh  x9, 0x20(x5)