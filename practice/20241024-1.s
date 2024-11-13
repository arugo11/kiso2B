        .text
        .globl  main
main:
    # 定数の初期化
    li      $s0, 3      #配列サイズ

    # 変数の初期化
    li      $t0, 0      #ループカウンタ

    # アドレスの読み出し
    la      $a0, X
    la      $a1, Y
    la      $a2, Z

loop_start:
    # 現在の要素の取得
    sll     $t1, $t0, 2
    add     $t2, $a0, $t1
    add     $t3, $a1, $t1
    add     $t4, $a2, $t1
    lw      $t2, 0($t2)
    lw      $t3, 0($t3)

    # 配列計算
    sub     $t5, $t2, $t3

    # データのストア
    sw      $t5, 0($t4)

    #ループカウンタのカウント
    addi $t0, $t0, 1
    bne $t0, $s0, loop_start

    li  $v0, 10
    syscall
    jr $ra

.data
X:  .word   10, 20, 30
Y:  .word   2, 4, 6
Z:  .space  12