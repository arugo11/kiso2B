.text
.globl  main
main:
    la      $a0, A
    la      $a1, B
    li      $s0, 8
    li      $t4, 8
    li      $t2, 0
    #総和加算用
    li      $t9, 0

    #最大値と最小値の初期化
    li      $s5, 0      #max
    li      $s6, 50     #min

L1:
    #配列のアドレス読み出し
    sll     $t3, $t2, 2
    add     $t1, $a0, $t3
    lw      $s1, 0($t1)



    #最大値
    ble		$s1, $s5, L6	# if $s1 <= $s5, jump to L2
    add     $s5, $s1, 0
L6:
    #最小値
    bge		$s1, $s6, L2    # if $s1 >= $s6, jump to L2
    add     $s6, $s1, 0


    j		L2				# jump to L2
L2:
    #平均点のために総和を求める
    add    $t9, $s1,$t9

    #インクリメント
    addi   $t2, $t2, 1
    bne    $t2, $s0, L1
L3:
    #平均割り算
    div		$t9, $s0			# $t9 / $s0
    mflo	$t5					# $t5 = floor($t2 / $s0) 
    mfhi	$t6					# $t6 = $t2 % $s0 

    li      $s7, 10
    mult	$t6, $s7			# $t6 *101 =  and Lo registers
    mflo	$t7					# copy Lo to $t7

    #小数点第一位
    div		$t7, $t4			# $t7 / $41
    mflo	$t8

    bge		$t8, 5, L4	# if $t8 >5t1 then goto target
    sw      $t5,    0($a1)
    j       L5

L4:
    addi    $t5,    1
    sw      $t5,    0($a1)
    j       L5
L5:

    #最大値をB[1]に格納
    sw  $s5, 4($a1)
    #最小値をB[2]に格納
    sw  $s6, 8($a1)
    li      $v0, 10
    syscall
    jr      $ra


.data
A:  .word   9, 7, 9, 10, 7, 10, 2, 8
B:  .space  12