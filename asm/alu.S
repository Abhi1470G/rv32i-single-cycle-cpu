addi x1, x0, 25
addi x2, x0, 10

add  x3, x1, x2      # 35
sub  x4, x1, x2      # 15

and  x5, x1, x2      # 8
or   x6, x1, x2      # 27
xor  x7, x1, x2      # 19

sll  x8, x2, x0      # 10 << 0 =10
slli x8, x2, 2       # 40

srli x9, x8, 1       # 20
srai x10,x8,2        # 10

slt  x11,x2,x1       # 1

ecall