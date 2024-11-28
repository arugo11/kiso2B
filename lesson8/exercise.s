        .text
        .globl  main
main:
    # 定数の定義
    li  $s0, 0x30        #asciiの0
    li  $s1, 0x0a        #改行

    # 入力
    li  $v0, 5
    syscall
    move $a0, $v0       #$a0に入力

    addi    $sp, $sp, -4
    sw      $ra, 0($sp)
main_loop:
    addi    $sp, $sp,-4 #push
    sw      $a0, 0($sp)
    jal     Linedisp    #$a0回$a0の文字を出力
    lw      $a0, 0($sp)     #pop
    addi    $sp, $sp, 4
    addi    $a0, $a0, -1
    bne     $a0, $zero, main_loop

exit:
    lw      $ra, 0($sp)
    addi    $sp, $sp, 4
    li      $v0, 10
    syscall
    jr      $ra

Linedisp:
    # move    $t3, $zero

    add     $t2, $s0, $a0   #出力文字を$t2に
Linedisp_loop:
    sb		$t2, A($t3)
    addi    $t3, $t3, 1
    bne     $t3, $a0, Linedisp_loop
print:
    sb      $s1, A($t3)
    addi    $t3, $t3, 1
    sb      $zero,A($t3)
    move    $t3, $zero
    #出力処理
    li  $v0, 4
    la  $a0, A
    syscall

    jr  $ra

    .data
A:  .space 10



