
        .text
        .globl  main
main:
        la  $a0, msg
        li  $s1, 0x41   #A in ascii
        li  $s2, 0x5a   #Z in ascii

loop_start:
    add     $t2, $a0, $t1   # t2 : 頭から何文字目か
    lb      $t0, 0($t2)
    beq     $t0, 0x00, exit # t2 == null => exit
    blt     $t0, 0x41, next # t2 < A => next : not large
    bgt     $t0, 0x5A, next # t2 > Z => next : not large
    addi    $s0, $s0, 1     # 大文字と判定

next:
    addi    $t1, $t1, 1
    j       loop_start

exit:
    li      $v0, 10
    syscall
    jr      $ra

.data
msg:        .ascii  "Hello, World!\n"