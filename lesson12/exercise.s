# 演習課題 二分探索木
.text
.globl main
main:
    # OSからの戻り番地$raをスタックにpushして保存、関数を呼び出す準備
    addi $sp, $sp, -4
    sw $ra, 0($sp)          # push

    # KEYをコンソールから入力
INLOOP:
    li $v0, 4               # KEYを入力するよう表示
    la $a0, KMSG
    syscall
    li $v0, 5              # (1) KEYの値（整数値）をキーボード入力する準備
    syscall
    move $s6, $v0           # 入力されたKEYを$s6に格納
    beq $s6, $zero, ENDPRC # (2) 入力されたKEY値が0なら終了処理へ
    la $a0, first           # $a0: ラベルfirstの番地
    move $a1, $s6           # $a1: 検索するKEYの値
    jal BST
    j INLOOP

    # 終了処理
ENDPRC:
    lw $ra, 0($sp)          # スタックに退避したOSへの戻り番地をpop
    addi $sp, $sp, 4        # $spを戻す
    li $v0, 4               # 終了メッセージの表示
    la $a0, EDMSG
    syscall
    li $v0, 10
    syscall
    jr $ra                  # OSへ戻る

# 関数BST ($a0:ラベルfirstの番地, $a1:検索するKEYの値)
BST:
    lw $s1, 0($a0)          # ROOTのNODEの先頭番地を$s1に格納
    move $t3, $a0           # ROOTが無い場合first番地にNODEを追加
    move $t2, $a1           # 検索要素のKEYを$t2に格納
    beq $s1, $zero, ADDND   # NODEを追加する

LOOP:
    lw $t1, 0($s1)         # (3) 現NODEのKEYを$t1に読み出す
    move $t2, $a1           # 検索要素のKEYを$t2に格納
    beq $t1, $t2, FOUND     # KEYが一致（見つけた）！
    blt $t1, $t2, RIGHT    # (4) 現NODEのKEY<検索要素のKEYなら右をたどる
    addi $t3, $s1, 8        # 「左」ポインタが入っている番地を計算し$t3に格納
    lw $t4, 0($t3)         # (5) 現NODEの左ポインタの値（番地）を読出し$t4に格納
    j NEXT

RIGHT:
    addi $t3, $s1, 12      # (6) 「右」ポインタが入っている番地を計算し$t3に格納
    lw $t4, 0($t3)          # 現NODEの右ポインタの値（番地）を読出し$t4に格納

NEXT:
    beq $t4, $zero, ADDND   # ポインタの値がNULLならNODEを追加
    move $s1, $t4           # 次のNODEの先頭番地を$s1に設定
    j LOOP                  # 枝先に進む

# NODEの追加, NODEへのKEY値とVALUE値の格納
ADDND:
    li $v0, 9              # (7) NODEを生成するため動的メモリ割当て
    li $a0, 16             # (8) 16バイトを確保
    syscall
    move $s2, $v0           # 新NODEの先頭アドレスを$s2にセーブ
    sw $s2, 0($t3)          # 新NODEを木に追加
    sw $t2, 0($s2)          # KEY値を新NODEに格納
    li $v0, 4
    la $a0, ADDMSG          # NODE追加, VALUE値の入力を促す
    syscall
    li $v0, 5               # VALUEの値をキーボード入力
    syscall
    move $s7, $v0           # 入力されたVALUE値を$s7に格納
    sw $s7, 4($s2)         # (9) VALUE値をNODEに格納
    sw $zero, 8($s2)        # 左ポインタをNULLに設定
    sw $zero, 12($s2)       # 右ポインタをNULLに設定
    jr $ra

# 検索して木の中に見つけた場合, 木に格納されているKEYとVALUEを表示
FOUND:
    li $v0, 4               # メッセージの表示
    la $a0, FDMSG
    syscall
    # KEYとVALUEを1回ずつ$a0に格納してsyscallする！
    li $v0, 1               # 整数値の表示
    move $a0, $t1           # 現NODEのKEY値を表示
    syscall
    li $v0, 4               # 空白文字の表示
    la $a0, SPACE
    syscall
    li $v0, 1               # 整数値の表示
    lw $a0, 4($s1)         # (10) 現NODEのVALUE値を表示
    syscall
    li $v0, 4               # 改行文字の表示
    la $a0, NEWL
    syscall
    jr $ra

# データ・セグメント
.data
first:  .word 0
KMSG:   .asciiz "顧客番号を入力して下さい: "
FDMSG:  .asciiz "登録されています． 顧客番号と誕生日は: \n"
ADDMSG: .asciiz "無いので登録します．誕生日を入力して下さい: "
SPACE:  .asciiz " "
NEWL:   .asciiz "\n\n"
EDMSG:  .asciiz "プログラムを終了します．\n"