(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("83faf27892c7119f6016e3609f346d3dae3516dede8fd8a5940373d98f615b4e" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Load 'load-directory' function
(load "~/.emacs.d/load-directory")
;; Load packages before anything else
(load "~/.emacs.d/packages")
;; Load all ".el" files under ~/.emacs.d/config directory.
(load-directory "~/.emacs.d/config")

(ido-mode t)

;; Fix git bug
(setq vc-handled-backends ())



