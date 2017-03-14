;; Theme
;; https://github.com/oneKelvinSmith/monokai-emacs
;; (add-to-list 'custom-theme-load-path "~/.emacs.d/themes/monokai-emacs")
;; (load-theme 'solarized-dark)
(load-theme 'labburn)

;; Font
(set-default-font "Inconsolata 14")

;; Show line number on the side
(global-linum-mode t)
;; Show column number
(column-number-mode t)
;; Show line numbers
(line-number-mode t)
;; Hide scroll bar
;; (scroll-bar-mode 0)
;; Prevent the cursor from blinking
(blink-cursor-mode 0)
;; Hide initial messages
(setq initial-scratch-message "")
(setq inhibit-startup-message t)
;; No bellx
(setq visible-bell t)
;; Inhibit startup message
(setq inhibit-startup-echo-area-message "arnaud")
;; Full screen (F11)
;; (toggle-frame-fullscreen)
;; Hide tool-bar
(tool-bar-mode 0)
;; Hide menu
;; (menu-bar-mode 0)
