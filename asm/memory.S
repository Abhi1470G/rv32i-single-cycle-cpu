addi x1,x0,100
addi x2,x0,200
addi x3,x0,0

sw x1,0(x3)
sw x2,4(x3)

lw x4,0(x3)
lw x5,4(x3)

add x6,x4,x5

ecall