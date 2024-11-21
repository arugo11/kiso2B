.text
        .globl  main
main:
        li      $s0, 3          # 三角形の高さ
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

exit:
        li      $v0, 4
        la      $a0, A
        syscall

        li      $v0, 10
        syscall

        jr      $ra

.data
A:      .space  54