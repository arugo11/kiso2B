.text
        .globl  main
main:
        li      $v0, 5
        syscall
        move 	$s0, $v0		# $s0 = v01
        la      $a0, A
        li      $s1, 0x2A       # '*'
        li      $s2, 0x0A       # 改行
        li      $t1, 0          # 行カウンタ
        li      $t7, 0          # メモリ位置

loop:
        addi    $t1, $t1, 1
        bgt     $t1, $s0, exit

        li      $t2, 0          # 列カウンタ
draw:
        sb      $s1, A($t7)     # '*'
        addi    $t7, $t7, 1
        addi    $t2, $t2, 1
        blt     $t2, $t1, draw

        sb      $s2, A($t7)
        addi    $t7, $t7, 1
        j       loop

        li      $v0, 4
        la      $a0, A
        syscall

exit:


        li      $v0, 10
        syscall
        jr      $ra

.data
A:      .space  54