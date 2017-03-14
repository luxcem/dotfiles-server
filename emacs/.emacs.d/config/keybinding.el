;; My emacs key binding

(defun toggle-comment-on-line ()
  "comment or uncomment current line. If current line is empty
add new comment"
  (interactive)
  (if (eq (line-beginning-position) (line-end-position))
      (comment-dwim nil)
    (comment-or-uncomment-region (line-beginning-position) (line-end-position))))

;; dwim funs beginning or end
(defun back-to-indentation-or-beginning () (interactive)
  (if (= (point) (progn (back-to-indentation) (point)))
      (beginning-of-line)))

(defun point-in-comment ()
  "Determine if the point is inside a comment"
  (interactive)
  (let ((syn (syntax-ppss)))
    (and (nth 8 syn)
         (not (nth 3 syn)))))

(defun end-of-line-or-code (arg)
  "Move point to end of line. If already there, move back to end of code.
 By 'end of code' we mean before a possible comment. Comments are
 recognized in any mode that sets syntax-ppss properly."
  (interactive "P")
  (let ((eol (save-excursion
	       (move-end-of-line arg)
               (point))))
    (cond ((= (point) eol)
           (move-end-of-line arg)
           (while (point-in-comment)
	     (backward-char))
           (skip-chars-backward " \t"))
          (t (move-end-of-line arg)))))

(defun backward-kill-line (arg)
  "Kill ARG lines backward."
  (interactive "p")
  (kill-line (- 1 arg)))

(defun duplicate-line()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (open-line 1)
  (next-line 1)
  (yank)
)

;; This comment current line
(global-set-key (kbd "H-c") 'toggle-comment-on-line)
;; This adds a comment at the end of line
(global-set-key (kbd "C-H-c") 'comment-dwim)

(global-set-key (kbd "C-c g") 'goto-line)
(global-set-key (kbd "H-g") 'goto-line)
(global-set-key (kbd "C-c k") 'kill-this-buffer)
(global-set-key (kbd "C-c r") 'replace-string)
(global-set-key (kbd "C-c b") 'bury-buffer)
(global-set-key (kbd "C-c c d") 'duplicate-line)
(global-set-key (kbd "H-o") 'other-window)

;; Moves with hyper arrow like
(global-set-key (kbd "H-r") 'forward-char)
(global-set-key (kbd "H-t") 'backward-char)
(global-set-key (kbd "H-s") 'next-line)
(global-set-key (kbd "H-d") 'previous-line)
(global-set-key (kbd "H-v") 'backward-word)
(global-set-key (kbd "H-l") 'forward-word)
(global-set-key (kbd "C-H-v") 'beginning-of-defun)
(global-set-key (kbd "C-H-l") 'end-of-defun)
(global-set-key (kbd "C-H-d") 'backward-paragraph)
(global-set-key (kbd "C-H-s") 'forward-paragraph)
(global-set-key (kbd "C-H-t") 'back-to-indentation-or-beginning)
(global-set-key (kbd "C-H-r") 'end-of-line-or-code)

;; Kill with hyper
;; Bind C-H-e and C-H-i with kill line (backward and forward)
(global-set-key (kbd "C-H-e") 'backward-kill-line)
(global-set-key (kbd "C-H-i") 'kill-line)
(global-set-key (kbd "H-e") 'backward-kill-word)
(global-set-key (kbd "H-i") 'kill-word)
(global-set-key (kbd "H-a") 'backward-kill-sexp)
(global-set-key (kbd "H-u") 'kill-sexp)

;; Remap C-a and C-e to dwim commands
(global-set-key (kbd "C-a") 'back-to-indentation-or-beginning)
(global-set-key (kbd "C-c a") 'beginning-of-buffer)
(global-set-key (kbd "C-e") 'end-of-line-or-code)
(global-set-key (kbd "C-c e") 'end-of-buffer)

;; Remap search to use regexp by default
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)

(global-set-key (kbd "C-c y") 'py-yapf-buffer)
(global-set-key (kbd "C-c t") 'delete-horizontal-space)
