.data
A:  .word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10

.text
.globl  main
main:
    la      $a0, A
    li      $s0, 10

L1:
    sll     $t3, $t2, 2
    add     $t1, $a0, $t3
    lw      $s1, 0($t1)

    li      $t1, 3
    div     $s1, $t1            # $s1 / $t1
    mfhi    $t3                 # $t3 = $s1 % $t1 

    beq     $t3, $zero, L2

    addi    $t2, $t2, 1
    bne     $t2, $s0, L1

    li      $v0, 10
    syscall
    jr      $ra
L2:
    addi    $s3, $s3, 1
    addi    $t2, $t2, 1
    bne     $t2, $s0, L1