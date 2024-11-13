
        .text
        .globl  main
main:
        la      $a0,    A
        la      $a1,    B
        li      $s1,    0x20    #空白文字のascii


loop:
        add     $t2, $a0, $t1   #t2:ラベルAの何文字目か
        add     $t4, $a1, $t3   #t3:ラベルBの何文字目か
        lb      $t0, 0($t2)  #t0に文字を格納
        beq     $t0, $zero, exit
        beq     $t1, $s1,   count
        sb      $t0, 0($t4)
        addi    $t3, $t3, 1

count:
        addi    $t1, $t1, 1
        j       loop
exit:
        li      $v0, 4
        la      $a0, B
        syscall
        li      $v0, 10
        syscall
        jr      $ra
        .data
A:      .asciiz "He llo, W orl d!\n"
B:      .space 17