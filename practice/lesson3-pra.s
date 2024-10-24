.text
.globl main

main:
    # ソースアドレスの取得
    la      $a0 A
    la      $a1 B

    # 定数初期化
    li      $s0, 10     #配列サイズ
    li      $s1, 70     #B[1] : 合格点(70)
    li      $s2, 90     #B[2] : 90点
    # 変数初期化
    li      $t0, 0      #ループカウンタ
    li      $t3, 0      #B[0] : 合格者数
    li      $t4, 0      #B[1] : 不合格者の合計点数
    li      $t5, 0      #B[2] : 90点以上の学生数
    li      $t6, 0      #B[1] : 不合格者数


loop_start:
    # 現在の位置を計算
    sll     $t1, $t0, 2
    add     $t1, $a0, $t1
    lw      $t2, 0($t1)

    # 1.合格者数を加算
    blt     $t2, $s1, cnt_pass_skip     #t2 < s1(70) : 合格していないならスキップ
    addi    $t3, $t3, 1

cnt_pass_skip:
    # 2.不合格者の点数を加算
    bge     $t2, $s1, sum_fail_skip     #t2 >= s1 : 合格してればスキップ
    addi    $t6, $t6, 1
    add     $t4, $t4, $t2
sum_fail_skip:

    # 3.90点以上の学生数を加算
    blt     $t2, $s2, cnt_90_skip
    addi    $t5, $t5, 1
cnt_90_skip:
    # ループ処理
    addi    $t0, $t0, 1
    bne     $t0, $s0, loop_start

    # 平均点の計算
    div     $t4, $t6
    mflo    $t7

    # データの格納
    sw      $t3, 0($a1)
    sw      $t7, 4($a1)
    sw      $t5, 8($a1)


    #終了処理
    addi	$v0, $0, 10		# System call 10 - Exit
    syscall					# execute
    jr      $ra

.data
A:  .word   65, 82, 73, 45, 90, 88, 78, 55, 95, 70
B:  .space  12