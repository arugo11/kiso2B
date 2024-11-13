    .text
    .globl  main

main:
    la  $a0, msg        #adress for msg label
    lb  $t0, 0($a0)     #H?
    lb  $t1, 1($a0)     #e?
    lb  $t2, 2($a0)     #l?
    lb  $t3, 3($a0)     #l?
    lb  $t4, 4($a0)     #o?
    lb  $t5, 5($a0)     #,?

    #exit
    li  $v0, 10
    syscall
    jr  $ra
    .data
msg:    .asciiz "Hello, World!\n"
