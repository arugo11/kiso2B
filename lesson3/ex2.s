    .globl  main
    .data   #データ領域
A:  .word   1, 2, 3, 4, 5, 6, 7, 8, 9, 10
    .text   #プログラム領域

main:
    la      $a0, A          #ラベルAのアドレス取得
    li      $s0, 10         #終了条件
L1:
    sll     $t3, $t2, 2     # t2 x 4のアドレスの計算
    add     $t1, $a0, $t3   # t2 x 4 + Aの値のアドレス計算
    lw      $t0, 0($t1)
    add     $t4, $t4, $t0
    addi    $t2, $t2, 1     #ループ用インクリメント変数
    bne     $t2, $s0, L1

    li      $v0, 10
    syscall
    jr      $ra
