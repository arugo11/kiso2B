.text
    .globl main
main:
    li      $s7, 6      # $s7 is a

    # 1個目のノード生成
    li      $v0, 9
    li      $a0, 8
    syscall

    move    $s1, $v0
    sw      $s1, first  # 連結リストの頭のアドレスを格納

    # データ1個目
    li      $t0, 1
    sw      $t0, 0($s1) # データ部に1を格納

    # 2個目のノード生成
    li      $v0, 9
    li      $a0, 8
    syscall

    sw      $v0, 4($s1) # 次のノードへのポインタを設定
    move    $s1, $v0

    # データ2個目
    li      $t0, 3
    sw      $t0, 0($s1)

    # 3個目のノード生成
    li      $v0, 9
    li      $a0, 8
    syscall

    sw      $v0, 4($s1)
    move    $s1, $v0

    # データ3個目
    li      $t0, 5
    sw      $t0, 0($s1)

    # 4個目のノード生成
    li      $v0, 9
    li      $a0, 8
    syscall

    sw      $v0, 4($s1)
    move    $s1, $v0

    # データ4個目
    li      $t0, 7
    sw      $t0, 0($s1)

    # 5個目のノード生成
    li      $v0, 9
    li      $a0, 8
    syscall

    sw      $v0, 4($s1)
    move    $s1, $v0

    # データ5個目
    li      $t0, 9
    sw      $t0, 0($s1)
    sw      $zero, 4($s1)   # 最後のノードの次のポインタをNULLに設定

    # 挿入ノードの生成と初期化
    li      $v0, 9
    li      $a0, 8
    syscall

    move    $s2, $v0        # 新ノードのアドレスを保存
    sw      $s7, 0($s2)     # データ部にaの値を設定
    sw      $zero, 4($s2)   # 次のポインタを初期化

    # 挿入位置の探索
    lw      $s0, first      # 現在のノード
    move    $s1, $zero      # 前のノード

FIND_POS:
    beq     $s0, $zero, INSERT_END    # リストの終端なら末尾に挿入
    lw      $t0, 0($s0)              # 現在のノードの値
    bge     $s7, $t0, NEXT

    # 挿入位置発見
    beq     $s1, $zero, INSERT_FRONT  # 先頭への挿入
    sw      $s0, 4($s2)
    sw      $s2, 4($s1)
    j       PRINT

# ノードの前を接続
INSERT_FRONT:
    sw      $s0, 4($s2)
    sw      $s2, first
    j       PRINT

NEXT:
    move    $s1, $s0
    lw      $s0, 4($s0)
    j       FIND_POS

# ノードの後を接続
INSERT_END:
    sw      $s2, 4($s1)

PRINT:
    # 結果の表示
    lw      $s0, first
PRINT_LOOP:
    beq     $s0, $zero, EXIT

    lw      $a0, 0($s0)
    li      $v0, 1
    syscall

    la      $a0, space
    li      $v0, 4
    syscall

    lw      $s0, 4($s0)
    j       PRINT_LOOP

EXIT:
    li      $v0, 10
    syscall

    .data
first:  .word   0
space:  .asciiz " "