# 加算と減算のプログラム
        .text   # テキスト(プログラム)領域の開始
        .globl main
main:
        li      $s0, 7      # $s0 = 7
        li      $s1, 3      # $s1 = 3
        li      $s2, 5      # $s2 = 5
        add     $t0, $s0, $s1       # $t0 = $s0 + $s1
        sub     $t1, $s0, $s1       # $t1 = $s0 - $s1
        sub     $t2, $s2, $s0       # $t2 = $s2 - $s0
# 終了処理
        li      $v0, 10     # $v0 = 10
        syscall
        jr      $ra         # jump to $ra