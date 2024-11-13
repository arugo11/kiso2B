        .text
        .globl main
main:

    # 現在の位置を計算
    la      $a0, A
    la      $a1, B


    # 1
    lw      $t2, 0($a0)
    sll     $t3, $t2, 5     #32倍
    srl     $t4, $t2, 3     #1/8倍
    sub     $t5, $t3, $t4   #ans : t5

    # 2
    lw      $t2, 4($a0)
    sll     $t3, $t2, 7     #7bit左シフト
    srl     $t4, $t2, 25     #7bit右シフト
    or      $t6, $t3, $t4   #ans : t6 : 554aaab5

    # データの格納
    sw      $t5, 0($a1)
    sw      $t6, 4($a1)

    # プログラム終了
    addi	$v0, $0, 10		# System call 10 - Exit
    syscall					# execute
    jr      $ra



.data
# A:  .word   1000, 0x54aaab55
A:  .word 1000, 0xa5a5a5a5
B:  .word   8