        .text
        .globl  main
main:
        li      $a0, 2          # n = 2
        li      $a1, 4          # k = 4
# 関数呼び出しを行う際の準備
        addi    $sp, $sp, -4    # SPを4減らす
        sw      $ra, 0($sp)     # push
        jal		mySUM			# 最終の計算結果が$v0
# スタックにセーブしてあったOSへの戻り番地を,popして$raに戻す
        lw      $ra, 0($sp)     # pop
        addi    $sp, $sp, 4     # SPを戻す
        move    $s1, $v0        # 最終的な答えを$s1に格納する

        li      $v0, 10         # exit
        syscall
        jr      $ra

mySUM:
        bne     $a0, $a1, Recursive     # n! = k なら Recursiveに飛ぶ
        move    $v0 $a1                # $a1の値(kの値)を$v0に代入
        jr      $ra

Recursive:
        addi    $sp, $sp, -8    # スタックフレームの作成
        sw      $a0, 4($sp)     # 新$spから4バイト戻った番地に#a0をセーブ
        sw      $ra, 0($sp)     # 新$spの番地に$raをセーブ
        addi    $a0, $a0, 1     # $a0(=nの値)を1増やす
        jal     mySUM           # 再起

### 再帰から戻る処理(jr $raでここに戻ってくる)
        lw      $a0, 4($sp)     # スタックフレームに格納してあった$a0を復元
        add     $v0, $v0, $a0   #(4+3)+2を順に計算
        lw      $ra, 0($sp)     # スタックフレームに格納してあった$raを復元
        addi    $sp, $sp, 8     # spを戻す(スタックフレームを1個解消)
        # ここでスタックフレームに格納してあった$raアドレスを次々呼び出す
        jr      $ra

.data