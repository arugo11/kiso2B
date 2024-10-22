.text
.globl  main
main:
    la      $a0, A
    la      $a1, B

L1:
    #配列のアドレス読み出し
    sll     $t3, $t2, 2
    add     $t1, $a0, $t3
    lw      $s1, 0($t1)

    #剰余の計算
    li      $t1, 3
    div     $s1, $t1            # $s1 / $t1
    mfhi    $t3                 # $t3 = $s1 % $t1 

    #3の倍数判定
    beq     $t3, $zero, L2

    #ループのインクリメント
    addi    $t2, $t2, 1
    bne     $t2, $s0, L1

    li      $v0, 10
    syscall
    jr      $ra
L2:
    addi    $s3, $s3, 1
    addi    $t2, $t2, 1
    bne     $t2, $s0, L1

.data
A:  .word   8, 6, 10, 5, 7, 4, 6, 3
B:  .space  12