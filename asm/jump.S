addi x1,x0,16

jal x5,FUNC

addi x2,x0,99

ecall

FUNC:

addi x3,x0,123

jalr x0,x5,0