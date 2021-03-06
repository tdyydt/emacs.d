;; recentf

;; recentf-ext.el
(require 'recentf)
(setq recentf-save-file "~/.emacs.d/.recentf")

;; A nil value means to save the whole list.
(setq recentf-max-saved-items nil)

;; set up recentf exclusion
;; .recentf, backup files, files for editing commit message
;; via: https://www.gnu.org/software/emacs/manual/html_node/elisp/File-Name-Expansion.html
(let ((emacs-home (expand-file-name "~/\.emacs\.d/")))
  (setq recentf-exclude
        (list (concat emacs-home "\.recentf")
              (concat emacs-home "backups/.*")
;;              (expand-file-name "~/Work/intro-prog-2018/kadai.*/.*")
              ".*/\.git/COMMIT_EDITMSG")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Tuning:
;; Avoid annoying messages
;; I'm using "shut-up.el" in order to shut up recentf messages
(require 'shut-up)

;; REF: https://github.com/takaxp/emacs.d/blob/master/init.el
;; REF: http://pastelwill.jp/wiki/doku.php?id=emacs:init.el
;; REF: http://qiita.com/itiut@github/items/d917eafd6ab255629346
(defun silent-recentf-cleanup ()
  (interactive)
  (let ((message-log-max nil))
        (shut-up (recentf-cleanup)))
  (message ""))
(defun silent-recentf-save-list ()
  (interactive)
  (let ((message-log-max nil))
    (shut-up (recentf-save-list)))
  (message ""))

(setq recentf-auto-cleanup 'never)
;; clean up in every 90 secs
;; remove files which no longer exists
;; 真偽値は repeat の有無を示す．
(run-with-idle-timer 30 t 'silent-recentf-cleanup)
;; save .recentf every 30 secs (when idle)
(run-with-idle-timer 30 t 'silent-recentf-save-list)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; The following _must_ be written after (require 'recentf)
;; Otherwise, ".recentf" file will be erased !!
(require 'recentf-ext)
