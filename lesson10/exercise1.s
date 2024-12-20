.text
        .globl  main
main:
        li      $t0, 20
        li      $s1, 16
        li      $t1, 0

outloop:
        addi    $t2, $t1, 4
        move    $t3, $t1
        lw      $t4, A($t1)
inloop:
        lw      $t8, A($t2)
        bge     $t4, $t8 , skip      #最大値の判定
        move    $t4, $t8
        move    $t3, $t2
skip:
        addi    $t2, $t2, 4
        blt     $t2, $t0, inloop

        #swap
        lw      $t4, A($t1)
        lw      $t8, A($t3)
        sw      $t8, A($t1)
        sw      $t4, A($t3)
        
        addi    $t1, $t1, 4
        blt     $t1, $s1, outloop

fin:
        li      $v0, 10
        syscall
        jr      $ra

        .data
A:      .word   9, 4, 10, 11, 7