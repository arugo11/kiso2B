# 第13回演習課題: 小数を入力, 平均, 最大値, 最小値, 入力個数を求め出力

        .text
        .globl  main
main:
    li.s        $f10, 10.0   # 入力可能な最大個数
    li.s        $f1, 0.0    # 入力個数のカウント値
    li.s        $f2, 0.0    # 小数の総和(初期値)
    li.s        $f3, 0.0    # 最大値(初期値)
    li.s        $f4, 0.0    # 最小値(初期値)
    li.s        $f6, 0.0    # 平均値(初期値)
    li.s        $f20, 0.0   # 小数のゼロを保持
    li.s       $f21, 1.0   # 小数の1を保持

L1:
    # 入力
    c.le.s  $f10, $f1
    bc1t    L2

    li      $v0, 6
    syscall

    c.eq.s $f0, $f20
    bc1t    L2

    # 総和の更新
    add.s   $f2, $f2, $f0
    # 最大値の更新
    c.le.s  $f0, $f3
    bc1t    L3
    mov.s   $f3, $f0
L3:
    # 最小値の更新
    c.le.s  $f4, $f0
    bc1t    L4
    mov.s   $f4, $f0

L4:
    add.s   $f1, $f1, $f21
    j       L1

L2:
    c.eq.s  $f20, $f1
    bc1t    EXIT

# 平均値の計算

div.s   $f6, $f2, $f1

# 平均値の表示
    li  $v0, 4
    la  $a0, AVE

    syscall
    mov.s $f12, $f6
    la  $v0, 2

    syscall

# 最大値の表示

    li  $v0, 4
    la  $a0, MAX

    syscall
    mov.s $f12, $f3
    la  $v0, 2

    syscall

# 最小値の表示

    li  $v0, 4
    la  $a0, MIN

    syscall
    mov.s $f12, $f4
    la  $v0, 2

    syscall

# 入力したデータの個数の表示

    li  $v0, 4
    la  $a0, NUM

    syscall
    mov.s $f12, $f1
    la  $v0, 2

    syscall

# 終了処理
EXIT:
    addi	$v0, $0, 10		# System call 10 - Exit
    syscall					# execute
    jr      $ra

    .data
AVE:    .asciiz "\n Average: "
MAX:    .asciiz "\n Max: "
MIN:    .asciiz "\n Min: "
NUM:    .asciiz "\n Num: "
