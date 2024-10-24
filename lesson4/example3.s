.text
.globl  main

main:
        li      $s1, 3
        andi    $t1, $s1,1
        beq     $t0, $zero, 1 #奇数の場合
        j       L2
L1:     addi    $s2, $zero, 2
L2:     addi	$v0, $0, 10		# System call 10 - Exit
        syscall					# execute
        jr      $ra
        .data