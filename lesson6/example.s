        .text
        .globl  main
main:
        la      $a0,    msg
        li      $s0,    0x41    #A
        li      $s1,    0x51    #Z

loop:
        lb      $t0,    msg($t2)
        