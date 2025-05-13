;; -*- lexical-binding: t -*-

;; Basically Environment Variables for Emacs
(setf visible-bell t
      compilation-scroll-output t
      org-agenda-files (list "~/org" "~/.notes" "~/work")
      inhibit-splash-screen t
      initial-scratch-message
      ";; This buffer is dedicated, in respect and admiration,\12;; to the spirit that lives in the computer~ UwU...\12\12"
      inferior-lisp-program "/usr/local/bin/sbcl"
      )
(setopt use-short-answers t)

;; Misc Configuration
(add-hook 'prog-mode-hook
	  #'(lambda () (display-line-numbers-mode t)))
(electric-pair-mode 1)
(push "~/.emacs.d/lisp" load-path)

;; Packages
(let ((simple-includes '(magit
			 slime
			 evil
			 company
			 exec-path-from-shell
			 geiser-guile
			 geiser-mit
			 geiser-chibi
			 with-editor
			 )))
  (mapcar #'(lambda (pkg-name)
	       (unless (package-installed-p pkg-name)
		 (message "calling package-install %s" pkg-name)
		 (package-install pkg-name)))
	  simple-includes))

;; Lisp
(add-to-list 'load-path "~/.emacs.d/elpa/slime-2.31/")
(require 'slime-autoloads)

;; JS
(add-to-list 'auto-mode-alist '("\\.ts[mx]?\\'" . typescript-ts-mode))
(require 'eglot)
(add-to-list 'eglot-server-programs '((js-mode typescript-ts-mode) . (eglot-deno "deno" "lsp")))

(defclass eglot-deno (eglot-lsp-server) ()
  :documentation "A custom class for deno lsp.")

(cl-defmethod eglot-initialization-options ((server eglot-deno))
  "Passes through required deno initialization options"
  (list :enable t
	:lint t))

;; Keybindings
(global-set-key (kbd "C-c l l") #'eglot)
(global-set-key (kbd "C-x g") #'magit)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(company evil exec-path-from-shell geiser-chibi geiser-guile
	     geiser-mit magit slime)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
