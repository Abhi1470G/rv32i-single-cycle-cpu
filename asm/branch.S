addi x1,x0,10
addi x2,x0,20

beq x1,x2,FAIL

addi x3,x0,1

bne x1,x2,LABEL

addi x3,x0,99

LABEL:

blt x1,x2,LESS

addi x4,x0,99

LESS:

bge x2,x1,GREATER

addi x5,x0,99

GREATER:

addi x6,x0,123

ecall

FAIL:
addi x7,x0,111
ecall