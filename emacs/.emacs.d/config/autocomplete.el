;; Enable company everywhere
(add-hook 'after-init-hook 'global-company-mode)
(setq company-minimum-prefix-length 1)
(setq company-idle-delay 0)

;; add docstring info in company
(company-quickhelp-mode 1)
