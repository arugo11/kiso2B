        .text
        .globl   main
 main:
        li      $t0, 5
        li      $t1, 10
        li      $t2, 15
  #$t0-$t2をpush
        addi    $sp, $sp, -4    #push
        sw      $t0, 0($sp)
        addi    $sp, $sp, -4    #push
        sw      $t1  0($sp)
        addi    $sp, $sp, -4    #push
        sw      $t2, 0($sp)
  #レジスタに別データを上書き
        move    $t0, $zero
        addi    $t1, $t0, 1
        sll     $t2, $t1, 1
  # $t0 - $t2をpop
        lw      $t2, 0($sp)
        addi    $sp, $sp, 4
        lw      $t1, 0($sp)
        addi    $sp, $sp, 4
        lw      $t0, 0($sp)
        addi    $sp, $sp, 4

        li      $v0, 10
        syscall
        jr      $ra
        .data
