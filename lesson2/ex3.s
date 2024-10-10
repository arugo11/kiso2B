#第二回 例題演習3
    .data   #データ領域
A:  .word   5, 10, 15

B:  .space  12

    .text   #プログラム領域
    .globl main
main:
    la		$a0, A  #a0 = *A
    la		$a1, B  #a1 = *B

    lw		$t0, 0($a0)
    lw      $t1, 4($a0)
    lw		$t2, 8($a0)

    addi	$t0, $t0, 2			# $t0 = $t0 + 2
    addi	$t1, $t1, 2			# $t1 = $t1 + 2
    addi	$t2, $t2, 2			# $t2 = $t2 + 2

    sw		$t0, 0($a1)
    sw		$t1, 4($a1)
    sw		$t2, 8($a1)

    li      $v0, 10
    syscall
    jr      $ra