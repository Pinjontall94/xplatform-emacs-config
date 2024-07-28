;; What follows is basically emacs' environment variables
(setq-default
 visible-bell t
 compilation-scroll-output t  ; autoscroll the compilation window
 backup-by-copying t          ; don't clobber symlinks
 backup-directory-alist
 '(("." . "~/.saves/"))       ; don't litter my fs tree
 delete-old-versions t
 kept-new-versions 6
 kept-old-versions 2
 version-control t            ; use versioned backups
 inhibit-splash-screen t
 org-agenda-files '("~/org")  ; Org(anize) your life, girl
 initial-scratch-message
 ";; This buffer is dedicated, in respect and admiration,\12;; to the spirit that lives in the computer~ UwU...\12\12")

;; Enable parens matching, column numbers, and tab-bar
(electric-pair-mode 1) (column-number-mode 1) (tab-bar-mode 1)

;; Enable lines
(add-hook 'prog-mode-hook
	  (lambda ()
	    (display-line-numbers-mode t)))

;; Nice ligatures
(add-hook 'prog-mode-hook #'prettify-symbols-mode)

(provide 'emacs-conf)
