    .text
    .globl main
main:



    li  $v0, 4      #for syscall
    la  $a0, msg
    syscall

    #exit
    li  $v0, 10
    syscall
    jr  $ra

    .data
msg:    .asciiz"Hello, World!\n"

