        .text
        .globl  main
main:


        li      $a0, 5      #nの値の設定

        addi    $sp, $sp, -4
        sw      $ra, 0($sp)

        jal     Func

        move    $s1, $v0

        lw      $ra, 0($sp)
        addi    $sp, $sp, 4

        #終了処理
        li      $v0, 10
        syscall
        jr      $ra


Func:
        # スタックフレーム作成
        addi    $sp, $sp, -8
        sw      $ra, 0($sp)
        sw      $a0, 4($sp)


        beq     $a0, $zero, initial_term   #初項の計算

        # ひとつ前の項へ
        addi    $a0, $a0, -1

        jal     Func
        # スタックから元のnを復帰
        lw      $a0, 4($sp)

        # 4n-3を計算
        sll     $t0, $a0, 2      # 4n
        addi    $t0, $t0, -3     # 4n-3
        add     $v0, $v0, $t0    # A_n-1 + 4n-3

        j       func_return

initial_term:
        li      $v0, 0

func_return:
        # スタックフレームの解放
        lw      $ra, 0($sp)
        addi    $sp, $sp, 8
        jr      $ra