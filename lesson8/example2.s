        .text
        .globl      main
main:
#OSからの戻り番地を$raにスタックしてpushして保存する
        addi        $sp, $sp, -4        #SPを4下げてそこが先頭
        sw          $ra, 0($sp)         #push
        li          $a0, 5              #第一引数
        li          $a1, 3              #第二引数
        jal		    MBA
        move        $t0, $v0            #戻り値を$t0に格納
        li          $a0, 7              #第一引数
        li          $a1, 2              #第二引数
        jal         MBA
        add         $s0, $t0, $v0
# スタックにセーブしてあったOSへの戻り番地を,popして$raに戻す
        lw          $ra, 0($sp)         #pop
        addi        $sp, $sp, 4         #SPを戻す

        li          $v0, 10
        syscall
        jr          $ra


#関数MBA(x,y)
MBA:    addi        $a1, $a1, -1        #第二引数をループカウンタにする
        move        $v0, $a0            #v0を直接アキュムレータにする
loop:   addi        $a1, $a1, -1
        add         $v0, $v0, $a0
        bgt         $a1, $zero, loop      #$a1 > 0ならloop続行
        jr          $ra
        .data