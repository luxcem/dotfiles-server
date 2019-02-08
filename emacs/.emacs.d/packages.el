(require 'package)

(setq package-list '(company company-quickhelp
                             fill-column-indicator multiple-cursors
                             haml-mode labburn-theme))
                                        ; ("marmalade" . "https://marmalade-repo.org/packages/")
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")
                         ("org" . "http://orgmode.org/elpa/" )))

(package-initialize)

                                        ; Fetch the list of packages available
(unless package-archive-contents
  (package-refresh-contents))

(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))
