    .globl  main

    .text

main:
    li      $s0, 10
L1:
    addi    $t0, $t0, 1     #足し込んでいく値(1, 2, 3, 4, ...)を$t0に格納
    add     $s4, $s4, $t0   #$s4に足し込んでいく(AX)
    addi    $t2, $t2, 1     #ループを回る数をカウントし$t2に
    bne     $t2, $s0, L1

    li      $v0, 10
    syscall
    jr      $ra

    .data