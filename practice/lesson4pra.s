        .text
        .globl  main
main:
        # 配列のベースアドレスの取得
        la      $a0, A
        la      $a1, B

        # 定数の初期化
        li      $s0, 8      #配列サイズ
        li      $t0, 0      #ループカウンタ
        li      $s2, 0      #B[0]:合計値初期化
        li      $s3, 0      #全要素の論理和用
        li      $s4, 0      #B[1]用のカウンタ
        li      $s5, 0      #B[2]の最大値の初期値

loop_start:
        # 現在の要素の取得
        sll     $t1, $t0, 2     #インデックス x 4
        add     $t1, $a0, $t1   #配列のアドレス計算
        lw      $t2, 0($t1)     #現在の要素読み込み


        # 1
        sll     $t3, $t2, 3     #3bit左シフトした値を計算
        xor     $t3, $t2, $t3   #XOR計算
        add     $s2, $t3, $s2   #B[0]に加算

        # 2
        andi    $t3, $t2, 0xF0      #0XF0との論理積
        li      $t9, 0xF0           #beq用
        bne     $t3, $t9, cnt_skip  #論理積が0xFと等しい場合カウントスキップ
        addi    $s4, $s4, 1         #B[1]の値を加算
cnt_skip:
        # 3
        srl     $t3, $t2, 1         #1bit右シフト
        ori     $t3, $t3, 0x0F      #0x0Fとの論理和
        ble     $t3, $s5, max_skip  #$t3 <= $s5(最大値がTrue)ならmax_skip
        add     $s5, $t3, $zero     #最大値の更新
max_skip:
        # ループカウンタの更新
        addi    $t0, $t0, 1
        bne     $t0, $s0, loop_start

        # 結果を配列Bに格納
        sw      $s2, 0($a1)
        sw      $s4, 4($a1)
        sw      $s5, 8($a1)

        #プログラムの終了
        li      $v0, 10
        syscall
        jr      $ra



.data
A:      .word   0x55, 0xAA, 0x33, 0xCC, 0x0F, 0xF0, 0x99, 0x66
B:      .space  12