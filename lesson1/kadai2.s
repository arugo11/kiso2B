#第1回 演習問題 課題2
        .text
        .globl main
main:
        li		$s0, 2024		# $s0 = 2024
        li		$s1, 10		# $s1 = 10
        li		$s2, 3		# $s2 = 3
        mult	$s1, $s2			# $s1 * $s2 = H1 and2Lo registers
        mflo	$t0
        sll		$t1, $t0, 1			# $t1 = $t0 << 1
        div		$s0, $t1			# $s0 / $t1
        mflo	$s3					# $s3 = floor($s0 / $t1) 
        mfhi	$s4				    # $s4 = $s0 % $t1 
        
        #終了処理
        li		$v0, 10		# $vi = 10
        syscall
        jr		$ra					# jump to $ra
        