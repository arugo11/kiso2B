        .text
        .globl      main
main:
        #定数の初期化
        li      $s0, 0x41       #A
        li      $s1, 0x5A       #Z
        li      $s2, 0x61       #a
        li      $s3, 0x7A       #z
        li      $s4, 0x20       #空白
        li      $s5, 1          #space_flag用

        #入力処理
        li      $v0, 8
        la      $a0, A
        li      $a1, 101       #末尾にnull
        syscall

        # #変数の初期化
        # li      $t0, 0          #配列Aのインデックスレジスタ : 全体のインデックスレジスタ
        # li      $t2, 0          #インデックスが示している文字
        # li      $t3, 0          #space_flag
        # li      $t4, 0          #配列Bのインデックスレジスタ

loop:
        #単語をロード
        lb      $t2, A($t0)

        #NULL文字ならexit
        beq     $t2, $zero, exit

        #文の先頭なら"先頭処理"へ
        beq     $t0, $zero, head

        #空白文字なら"空白文字の処理"へ
        beq     $t2, $s4, is_space
        beq     $t3, $s5, head

        #大文字Aより小さい = 大文字でない場合"格納処理"へ
        blt     $t2, $s0, store
        #大文字Zより大きい = 大文字でない場合"格納処理"へ
        bgt     $t2, $s1, store
        #大文字小文字変換
        xori     $t2, $t2, 0x20

store:
        sb      $t2, B($t4)     #Bにストア
        addi    $t0, $t0, 1     #配列Aのインデックスレジスタのカウントアップ
        addi    $t4, $t4, 1     #配列Bのインデックスレジスタのカウントアップ

        j       loop
        #先頭処理
head:
        blt     $t2, $s2, store2
        bgt     $t2, $s3, store2
        #大文字小文字変換
        xori     $t2, $t2, 0x20
store2:
        sb      $t2, B($t4)
        move    $t3, $zero
        addi    $t0, $t0, 1     #配列Aのインデックスレジスタのカウントアップ
        addi    $t4, $t4, 1     #配列Bのインデックスレジスタのカウントアップ

        j       loop


is_space:

        sb      $t2, B($t4)
        move    $t3, $s5        #space_flag <- 1
        addi    $t0, $t0, 1     #配列Aのインデックスレジスタのカウントアップ
        addi    $t4, $t4, 1     #配列Bのインデックスレジスタのカウントアップ
        j       loop

exit:
        sb      $zero B($t4)
        #表示処理
        li      $v0, 4
        la      $a0, B
        syscall

        #終了処理
        li      $v0, 10
        syscall
        jr      $ra
.data
A:  .space  101
B:  .space  101