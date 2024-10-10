#第二回 例題演習3
    .data   #データ領域
A:  .word   5, 4, 3, 2, 1

    .text   #プログラム領域
    .globl main
main:
    la		$a0, A  #a0 = *A

    lw		$t0, 0($a0)
    lw      $t1, 4($a0)

    sw		$t1, 0($a0)
    sw		$t0, 4($a0)
    #4,5,3,2,1

    lw		$t0, 4($a0)
    lw      $t1, 8($a0)

    sw		$t1, 4($a0)
    sw		$t0, 8($a0)
    #4,3,5,2,1

    lw		$t0, 8($a0)
    lw      $t1, 12($a0)

    sw		$t1, 8($a0)
    sw		$t0, 12($a0)
    #4,3,2,5,1

    lw		$t0, 12($a0)
    lw      $t1, 16($a0)

    sw		$t1, 12($a0)
    sw		$t0, 16($a0)
    #4,3,2,1,5

    li      $v0, 10
    syscall
    jr      $ra