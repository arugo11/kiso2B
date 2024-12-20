# 逆ポーランド記法
        .text
        .globl  main
main:
        li      $v0, 8                # キーボードからの入力
        la      $a0, A
        li      $a1, 30
        syscall
        li      $t3, 0                # 配列Aのインデックス$t3を初期化
        li      $t2, 0                # 配列Bのインデックス$t2を初期化
        lb      $t1, A($t3)           # 最初の文字を読み込み
        beq     $t1, $zero, PLEXT     # A[0]がNULLなら終了

### 変換処理 ###
# OSに戻るための戻り番地をスタックにPushする
        addi    $sp, $sp, -4
        sw      $ra, 0($sp)
        jal     GETC                   # 最初の文字を取得
        jal     EXP                    # 式の処理を開始
        li      $t9, 0x0A             # 0x0a is nl
        bne     $t1, $t9, EREND       # 改行文字でなければエラー
        
        li      $v0, 4                # 変換結果の出力
        la      $a0, B
        syscall

# 終了処理
        lw      $ra, 0($sp)           # 戻り番地を復元
        addi    $sp, $sp, 4
PLEXT:  
        li      $v0, 10               # プログラムの終了
        syscall
        jr      $ra

EREND:                                # エラー処理
        li      $v0, 4
        la      $a0, ERMSG           # エラーメッセージの出力
        syscall
        j       PLEXT

#### 関数 GETC: 一文字取得 ####
GETC:
        lb      $t1, A($t3)           # 配列Aから1文字読み込み
        addi    $t3, $t3, 1           # インデックスを進める
        li      $t9, 0x20             # 0x20 is space (空白文字)
        beq     $t1, $t9, GETC        # 空白文字なら次の文字へ
        jr      $ra

##### 関数 EXP: 式の処理 #####
EXP:    
        # スタックに戻り番地を保存
        addi    $sp, $sp, -4          # 領域確保
        sw      $ra, 0($sp)           # 戻り番地をpush
        
        # 最初の項を処理
        jal     TERM                   # 最初の項を処理
        
        # 加減算の処理
E0:     
        li      $t9, 0x2B             # '+'のアスキーコード
        beq     $t1, $t9, E1          # '+'ならE1へ
        li      $t9, 0x2D             # '-'のアスキーコード
        bne     $t1, $t9, EXPEND      # '-'でないならEXPENDへ
        
E1:     
        # 演算子をスタックに保存
        addi    $sp, $sp, -4          # 領域確保
        sw      $t1, 0($sp)           # 演算子をpush
        
        # 次の文字を取得して処理
        jal     GETC                   # 次の文字を取得
        
        # 次の項を処理
        addi    $sp, $sp, -4          # 領域確保
        sw      $ra, 0($sp)           # 戻り番地をpush
        jal     TERM                   # 次の項を処理
        lw      $ra, 0($sp)           # 戻り番地を復元
        addi    $sp, $sp, 4           # スタックポインタを戻す
        
        # スタックから演算子を取り出して出力
        lw      $t0, 0($sp)           # 演算子を取り出す
        addi    $sp, $sp, 4           # スタックポインタを戻す
        
        # 演算子を出力用配列に格納
        addi    $sp, $sp, -4          # 領域確保
        sw      $ra, 0($sp)           # 戻り番地をpush
        move    $t0, $t0              # 演算子を一時保存
        jal     STORE                  # 配列Bに格納
        lw      $ra, 0($sp)           # 戻り番地を復元
        addi    $sp, $sp, 4           # スタックポインタを戻す
        
        j       E0                     # 次の演算子の処理へ
        
EXPEND:
        lw      $ra, 0($sp)           # 戻り番地を復元
        addi    $sp, $sp, 4           # スタックポインタを戻す
        jr      $ra                    # 呼び出し元に戻る

#### 関数 TERM: 項の処理 ####
TERM:   
        addi    $sp, $sp, -4          # 戻り番地の退避
        sw      $ra, 0($sp)
        
        jal     FACTOR                 # 因子を処理

T0:     # 乗除算の処理
        li      $t9, 0x2A             # 0x2A is '*'
        beq     $t1, $t9, T1          # '*'なら T1へ
        li      $t9, 0x2F             # 0x2F is '/'
        bne     $t1, $t9, TERMEND     # '/'でなければ終了
        
T1:     
        addi    $sp, $sp, -4          # 演算子をスタックに退避
        sw      $t1, 0($sp)
        
        jal     GETC                   # 次の文字を取得
        jal     FACTOR                 # 次の因子を処理
        
        lw      $t0, 0($sp)           # スタックから演算子を取り出し
        addi    $sp, $sp, 4
        
        sb      $t0, B($t2)           # 演算子を出力用配列に格納
        addi    $t2, $t2, 1           # インデックスをインクリメント
        
        j       T0                     # 次の演算子の処理へ

TERMEND:
        lw      $ra, 0($sp)           # 戻り番地を復元
        addi    $sp, $sp, 4
        jr      $ra

#### 関数 FACTOR: 因子の処理 ####
FACTOR:
        li      $t9, 0x28             # 0x28 is '('
        bne     $t1, $t9, P1          # '('でなければP1へ
        
        addi    $sp, $sp, -4          # スタック領域確保
        sw      $ra, 0($sp)           # 戻り番地を退避
        
        jal     GETC                   # 次の文字を取得
        jal     EXP                    # 括弧内の式を処理
        
        li      $t9, 0x29             # 0x29 is ')'
        bne     $t1, $t9, EREND       # ')'でなければエラー
        
        jal     GETC                   # 次の文字を取得
        
        lw      $ra, 0($sp)           # 戻り番地を復元
        addi    $sp, $sp, 4           # スタックポインタを戻す
        jr      $ra

P1:     # 変数のチェック
        li      $t9, 0x41             # 0x41 is 'A'
        blt     $t1, $t9, EREND       # 'A'より小さければエラー
        li      $t9, 0x5A             # 0x5A is 'Z'
        bgt     $t1, $t9, EREND       # 'Z'より大きければエラー

        sb      $t1, B($t2)           # 変数を出力用配列に格納
        addi    $t2, $t2, 1           # インデックスをインクリメント
        
        addi    $sp, $sp, -4          # スタック領域確保
        sw      $ra, 0($sp)           # 戻り番地を退避
        
        jal     GETC                   # 次の文字を取得
        
        lw      $ra, 0($sp)           # 戻り番地を復元
        addi    $sp, $sp, 4           # スタックポインタを戻す
        jr      $ra

##### 関数 STORE: 配列Bに格納 #####
STORE:
        sb $t0, B($t2)         # 配列Bに1文字格納
        addi $t2, $t2, 1       # Bのインデックスをカウントアップ
        jr $ra

# データセグメント
        .data
A:      .space  30                    # 入力文字を格納する配列
B:      .space  30                    # 出力文字を格納する配列
ERMSG:  .asciiz "ERROR\n"            # エラーメッセージ
