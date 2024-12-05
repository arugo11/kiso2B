        .text
        .globl      main
main:
        lw  $t0, 0($sp)
        lw  $t1, 4($sp)
        lw  $t2, 8($sp)
### R8  [t0] = 1
### R9  [t1] = 2147481645
### R10 [t2] = 0
        li  $v0, 10
        syscall
        jr  $ra
.data