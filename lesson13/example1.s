        .text
        .globl  main
main:
        li.s    $f0, -0.75

        la      $a0, A
        s.s     $f0, 0($a0)

        li      $v0, 10
        syscall
        jr      $ra


        .data
A:      .space  12
