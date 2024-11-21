        .text
        .globl  main
main:
loop:
        lb      $t0,    A($t2)  #配列Aからロード
        beq     $t0,    $zero,  get_reverse
        addi    $t2,    $t2,    1
        j		loop				# jump to loo@
get_reverse:
        lb      