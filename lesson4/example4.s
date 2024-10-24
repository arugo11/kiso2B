    .text
    .globl  main
main:
    li      $s1, 3      #元のデータ
    sll     $s1, $s1, 2 #s1 x 4
    addi    $s1, $s1, 1 #s1 x 4 + 1

    li      $v0, 10
    syscall
    jr      $ra

    .data
