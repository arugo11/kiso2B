# バブルソート・プログラム
    .text
    .globl	main
main:

    li      $t0, 0
    lw      $t1, N($t0)
    sll     $t1, $t1, 2         # Convert to Bite

loop1:
    addi    $t1, $t1, -1
    beq     $t1, $zero, fin
    li      $t2, 0
    li      $t4, 4
loop2:
    lw      $t3, A($t4)
    lw      $t0, A($t2)
    bgt     $t3, $t0, skip # $t3 > $t0 = 右 > 左
    
    sw      $t3, A($t2)
    sw      $t0, A($t4)
skip:
    addi    $t2, $t2, 4
    addi    $t4, $t4, 4
    blt		$t0, $t1, loop2	# if $t0 < $t1 then goto loop2
    j       loop1
fin:
    # 終了処理
    li		$v0, 10		# exit syscall
    syscall
    jr		$ra

    .data
A:  .word   3,4,1,5,2
N:  .word   5