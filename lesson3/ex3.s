    .text
    .globl  main
main:
    li      $s0, 10
L1:
    addi    $t0, $t1, 1
    add     $s4, $s4, $t0
    addi    $t2, $t2, 1
    blt     $t2, $s0, L1

    li      $v0, 10
    syscall
    jr      $ra
    .data