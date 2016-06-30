;; font
;; Mac

;; デフォルトでは Menlo
;; Menlo も似ているが、Monaco の方が好み。
;; (Monaco の方がカワイイ系で、少しデカい)
;; iTerm でも Monaco を使用している。

;; ちなみに、サイズは細かく設定した所で、もともとないサイズだと丸められるので注意。
;; 110 (11pt) とか 120 (12pt) とか
;; フォントによって、画面のサイズすら変わるのは何なのだ。よく分からない。
;; それゆえ、同じサイズでも見た目が違う

;; COMMENT: [May 23, 2016]
;; かなり状況が改善した。
;; set-fontset-font で、日本語フォントのサイズと、
;; ascii フォントのサイズを別々に設定している。
;; 行儀が良いのかはわからないけれど、これが一番良い！

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; japanese font

;; 明朝は少し違う。角ゴがデフォルトと思う。
;; 丸ゴもほとんど同じだが、良く見ると確かに丸い。
;; Sans は角ゴと変わらんというか、謎。

(cl-flet ((choose-font
           (v)
           (cond ((= v 0) "Hiragino Kaku Gothic ProN") ; 角ゴ
                 ((= v 1) "Hiragino Maru Gothic ProN") ; 丸ゴ
                 ((= v 2) "Hiragino Mincho ProN")      ; 明朝
                 ((= v 3) "Hiragino Sans")             ; 詳細不明
                 )))
  (set-fontset-font
   nil
   'japanese-jisx0208
   (font-spec :family (choose-font 0)
              :size 12)))

;; TODO: [May 23, 2016]
;; set-fontset-font というのと、set-face-attribute
;; というのがあって、この違いが謎。set-fontset-font だけでも行けそうで、
;; こちらのほうが直感的に分かりやすいので、こうする。
;; いつか
;; REF: http://lioon.net/emacs-change-font-size-quickly

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ascii font

;; (2). Menlo
;; デフォルト
;; 結構慣れてきている感じがある。
;; l の感じが多分好きじゃない。
;; (1). Monaco
;; mac-patch のときのデフォルト
;; カワイイ系で、割とデカい。
;; iTerm 等で使用中。Emacs で使うには少し煩いのかもしれない
;; (0). Inconsolata
;; 人気のフリーフォント
;; Consolas に似せているとか。数字の感じがちょっと違和感？
;; l の感じは好き！

;; [May 25, 2016] Monaco も少し使ってみるかあ。Inconsolata やっぱり
;; 数字だけフォントを変えるという荒業もあろうが、1 と l の区別が曖昧に
;; なったりしかねない。


;; flet は common lisp の関数由来と思われるが、
;; cl-lib という標準 ? のライブラリがあり、そこに含まれる cl-flet
;; を使っている。つまり (require 'cl) は不要ということだろう。
;; Emacs lisp では普通の let ではこういうものは書けないらしい。

;; フォントを変えやすく [May 23, 2016]
;; サイズは割と相対的なもののようなので、ちょうど良いサイズとの
;; コンスセルを作っておく。
(cl-flet ((choose-font
           (v)
           (cond ((= v 0) '("Inconsolata" . 14)) ; prefered!!
                 ((= v 1) '("Monaco" . 11))
                 ((= v 2) '("Menlo" . 12))       ; default
                 )))
  ;; you can customize HERE:
  (let ((chosen-font (choose-font 0)))
    (set-fontset-font
     nil
     'ascii
     (font-spec :family (car chosen-font)
                :size (cdr chosen-font)))))

;; 実験の結果、
;; Monaco 11pt, Inconsolata 14pt
;; がほぼ同じ大きさ！
;; Menlo 12pt とは少しずれるが、これくらいがちょうど！