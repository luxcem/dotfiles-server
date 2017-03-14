;; Editing preference

;; Always use unicode
(set-language-environment "UTF-8")

;; Reload edtied file
(global-auto-revert-mode 1)
(setq auto-revert-check-vc-info t)

;; Highlight region
(transient-mark-mode nil)

;; Syntax highlighting
(setq global-font-lock-mode t)
(setq font-lock-maximum-size t)
(setq font-lock-maximum-decoration t)

;; Indentation mode
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80))

(setq c-default-style "bsd"
      c-block-comment-prefix ""
      c-basic-offset 4)

;; Remowe trailing whitespace on save
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Fill Column indicator
;; https://www.emacswiki.org/emacs/FillColumnIndicator
(require 'fill-column-indicator)
(setq-default fill-column 80)
;; Add fill column to all modes
(add-hook 'after-change-major-mode-hook 'fci-mode)

(setq fci-rule-width 1)
(setq fci-rule-color "white")
(setq fci-rule-column 80)

;;workaround for bug between company mode and fill-column-indicator
(defvar-local company-fci-mode-on-p nil)

(defun company-turn-off-fci (&rest ignore)
  (when (boundp 'fci-mode)
    (setq company-fci-mode-on-p fci-mode)
    (when fci-mode (fci-mode -1))))

(defun company-maybe-turn-on-fci (&rest ignore)
  (when company-fci-mode-on-p (fci-mode 1)))

(add-hook 'company-completion-started-hook 'company-turn-off-fci)
(add-hook 'company-completion-finished-hook 'company-maybe-turn-on-fci)
(add-hook 'company-completion-cancelled-hook 'company-maybe-turn-on-fci)

;; Always use abbrev mode
(add-hook 'text-mode-hook (lambda () (abbrev-mode 1)))


;; Multiples cursors
(require 'multiple-cursors)
(global-set-key (kbd "C-c m m") 'mc/edit-lines)
(global-set-key (kbd "C-c m n") 'mc/mark-next-like-this)
(global-set-key (kbd "C-c m p") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c m a") 'mc/mark-all-like-this)
