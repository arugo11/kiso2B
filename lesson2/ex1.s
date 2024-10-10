#第二回 例題演習1
    .data   #データ領域
A:  .word   5, 10, 15

    .text   #プログラム領域
    .globl main
main:
    la		$a0, A  # $a0 = *A
    lw		$t0, 0($a0)
    lw      $t1, 4($a0)
    lw		$t2, 8($a0)


    li      $v0, 10
    syscall
    jr      $ra