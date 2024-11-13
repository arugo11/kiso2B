        .text
        .globl  main
main:
        la      $a0,    msg
        li      $s1,    0x41    #0x41 is "A"
        li      $s2,    0x5a    #0x5a is "Z"
        li      $s3,    0x61    #0x61 is "a"
        li      $s4,    0x71    #0x71 is "z"

loop:
        add     $t2, $a0, $t1   #t2 : msgの先頭からn文字目
        lb      $t0, 0($t2)
        beq     $t0, $zero, exit#null文字なら終了
        blt     $t0, $s1, next  #"A"より小さいときアルファベットでないためパス
        ble     $t0, $s2, upper #大文字のため大文字変換へ
        blt     $t0, $s3, next  #アルファベットでない
        bgt     $t0, $s4, next  #アルファベットでない
upper:
        xor      $t0, $t0, 0x20 #大文字と小文字の変換
next:
        sb      $t0, 0($t2)     #msgに上書き
        addi    $t1, $t1, 1     #インクリメント
        j       loop
exit:
        li      $v0, 4
        la      $a0, msg
        syscall

        li      $v0, 10
        syscall
        jr      $ra
        .data
msg:    .ascii "OmIyA8\n"