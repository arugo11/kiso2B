#第1回 演習問題 課題1
        .text
        .globl main
main:
        li		$s0, 6		# $s0 = 6
        li		$s1, 13		# $s1 = 13
        li		$s2, 72		# $s2 = 72
        li		$s3, -4		# $s3 = -4
        add		$t0, $s1, $s2		# $t0 = $s1 + $s2
        add		$t1, $t0, $s3		# $t1 = $t0 + $s3
        sub		$s4, $s0, $t1		# $s4 = $ts0- $t1
        #終了処理
        li		$v0, 10		# $vi = 10
        syscall
        jr		$ra					# jump to $ra
        