;; -*- lexical-binding: t -*-

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'load-path "~/.emacs.d/lisp/")
(require 'hello)

;;   =====================================
;;  == Quality of life improvements... ==
;; =====================================
;; What follows is basically emacs' environment variables
(setq visible-bell t
      compilation-scroll-output t  ; autoscroll the compilation window
      inhibit-splash-screen t
      org-agenda-files (list "~/org" "~/.notes" "~/work")  ; Org(anize) your life, girl
      initial-scratch-message
      ";; This buffer is dedicated, in respect and admiration,\12;; to the spirit that lives in the computer~ UwU...\12\12")
(setopt use-short-answers t)

(add-to-list 'initial-frame-alist '(fullscreen . maximized))

;; Enable parens matching
(electric-pair-mode 1)

;; GUI configuration (toolbars, etc.)
(column-number-mode 1)
(scroll-bar-mode 0)
(tool-bar-mode 0)

;; Enable lines
(add-hook 'prog-mode-hook
	  (lambda ()
	    (display-line-numbers-mode t)))

;; Nice ligatures
(add-hook 'prog-mode-hook #'prettify-symbols-mode)


;; Git integration
(use-package magit :ensure t :defer t :bind (("C-x g" . magit-status)))

;; M-x VS Code
;; Autocompletion and language servers
(use-package company :ensure t
  :hook (prog-mode . company-mode)
  :config
  (setq company-idle-delay 0.1
	company-minimum-prefix-length 1)
  (global-company-mode))

(use-package eglot
  :bind (:map eglot-mode-map
	      ("C-c l d" . eldoc)
	      ("C-c l a" . eglot-code-actions)
	      ("C-c l r" . eglot-rename))
  :config
  (setq eglot-report-progress nil)
  (add-to-list 'eglot-server-programs
	       '(verilog-mode . ("hdl_checker" "--lsp"))))

;; Which key does what again?
(use-package which-key :ensure t :config (which-key-mode))

;; Syntax checking
(use-package flycheck :ensure t :defer t)

;; Code snippets so you don't have to type as much
(use-package yasnippet
  :config
  (add-to-list 'load-path "~/.emacs.d/plugins/yasnippet")
  (yas-global-mode 1))

(use-package yasnippet-snippets :ensure t :after yasnippet)

;; Autoformatting
(use-package format-all :ensure t)

;;   ===============
;;  == Languages ==
;; ===============
;; NOTE: use M-x treesit-install-language-grammar for new languages

(require 'c-conf)
(require 'lisp-conf)
(require 'extra-langs)		;; Load the rest so we don't clog up init.el ;3
(require 'org-conf)             ;; org mode configuration
(require 'misc-conf)

;; keybindings
(global-set-key (kbd "C-c RET") #'compile)
(global-set-key (kbd "M-RET") #'recompile)
(global-set-key (kbd "C-c o l") #'org-store-link)
(global-set-key (kbd "C-c o a") #'org-agenda)
(global-set-key (kbd "C-c o c") #'org-capture)
(global-set-key (kbd "C-c f") #'format-all-buffer)
(global-set-key (kbd "C-c z") #'zen)
(global-set-key (kbd "C-c e") #'eshell)
(global-set-key (kbd "C-c l l") #'eglot)
(global-set-key (kbd "C-c g") #'guix)
(global-set-key (kbd "C-c r") #'geiser)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(catppuccin-theme cmake-mode cobol-mode company conda
		      dired-auto-readme docker-compose-mode
		      doom-modeline emmet-mode evil-collection
		      exec-path-from-shell fish-mode flycheck
		      format-all geiser-chez geiser-chibi
		      geiser-chicken geiser-guile geiser-mit
		      geiser-racket go-mode hl-todo impatient-mode
		      magit org-static-blog php-mode pyvenv slime
		      slime-company treemacs-evil wat-ts-mode web-mode
		      yasnippet-snippets zig-mode))
 '(safe-local-variable-values
   '((geiser-guile-binary . "./guile")
     (geiser-repl-add-project-paths "module")
     (org-startup-with-inline-images . t) (standard-indent . 2))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
