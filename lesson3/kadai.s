.text
.globl  main

main:
    # 配列のベースアドレスの取得
    la      $a0, A
    la      $a1, B

    # 定数の初期化
    li      $s0, 8  #配列サイズ
    li      $t0, 0  #ループカウンタ
    li      $t2, 0  #合計値初期化

    # 最大値・最小値の初期化
    lw      $s3, 0($a0) # max = 最初の要素
    lw      $s4, 0($a0) # min = 最初の要素

loop_start:
    # 現在の要素の取得
    sll     $t1, $t0, 2     #インデックス * 4
    add     $t1, $a0, $t1   #配列のアドレス計算
    lw      $t2, 0($t1)    #現在の要素読み込み

    # 合計値の更新
    add     $s2, $s2, $t2

    # 最大値の更新
    bge     $s3, $t2, check_min     #$s3 >= $t2 -> check_min
    add     $s3, $t2, $zero         #新しい最大値
check_min:
    # 最小値の更新
    ble     $s4, $t2, next
    add     $s4, $t2, $zero

next:
    # ループカウンタの更新
    addi    $t0, $t0, 1
    bne     $t0, $s0, loop_start

    # 平均値の計算
    div     $s2, $s0        # 合計 / 8
    mflo    $t3             #商を取得
    mfhi    $t4             #余りを取得

    # 小数点第一位の計算
    li      $t5, 10
    mult    $t4, $t5
    mflo    $t4             #余り * 10
    div     $t4, $s0
    mflo    $t4             #小数点第一位

    #四捨五入の計算
    li      $t5, 10
    blt     $t4, $t5, store_results
    addi    $t3, $t3, 1     #切り上げ

store_results:
    #結果を配列Bに格納
    sw      $t3, 0($a1)     #B[0] = 平均値
    sw      $s3, 4($a1)     #B[1] = 最大値
    sw      $s4, 8($a1)     #B[2} = 最小値

    # プログラムの終了
    li      $v0, 10
    syscall
    jr      $ra

.data
A:  .word   8, 6, 10, 5, 7, 4, 6, 3
B:  .space  12