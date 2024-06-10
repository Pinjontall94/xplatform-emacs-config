(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)


;;   =====================================
;;  == Quality of life improvements... ==
;; =====================================

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
 initial-scratch-message
 ";; This buffer is dedicated, in respect and admiration,\12;; to the spirit that lives in the computer~ UwU...\12\12"
 viper-mode t		      ; toggle with C-z (see viper-change-state-*)
 viper-expert-level 1
 viper-inhibit-startup-message t
 use-package-always-defer t)  ; use ":demand t" to explicitly load packages

;; Enable parens matching & column numbers
(electric-pair-mode 1) (column-number-mode 1)

;; Load user lisp projects to the autoload path
(add-to-list 'load-path "~/.emacs.d/lisp/")

;; Enable lines
(defun enable-lines () (display-line-numbers-mode t))
(add-hook 'prog-mode-hook #'enable-lines)

;; Nice theme, dashboard, and modeline for the modern era ;3
(use-package catppuccin-theme :ensure t :demand t
  :config
  (catppuccin-load-flavor 'frappe)) ;; or 'latte, 'macchiato, or 'mocha
   
;; (use-package dashboard :ensure t :demand t :config (dashboard-setup-startup-hook))
(use-package doom-modeline :ensure t :hook (after-init . doom-modeline-mode))

;; Set exec-path to match $PATH environment variable
(use-package exec-path-from-shell :ensure t :demand t
  :init (setq exec-path-from-shell-arguments nil)
  :config
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize)))

;; Git integration
(use-package magit :ensure t :bind (("C-x g" . magit-status)))

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
	      ("C-c d" . eldoc)
	      ("C-c a" . eglot-code-actions)
	      ("C-c r" . eglot-rename))
  :config
  (add-to-list 'eglot-server-programs
	       '(verilog-mode . ("hdl_checker" "--lsp"))))

;; Which key does what again?
(use-package which-key :ensure t :demand t :config (which-key-mode))

;; Syntax checking
(use-package flycheck :ensure t :init (global-flycheck-mode))

;; Code snippets so you don't have to type as much
(use-package yasnippet :ensure t :demand t
  :config
  (add-to-list 'load-path "~/.emacs.d/plugins/yasnippet")
  (yas-global-mode 1))

(use-package yasnippet-snippets :ensure t :after yasnippet)

;; Autoformatting
(use-package format-all :ensure t
  :commands format-all-mode
  :hook (prog-mode . format-all-mode))

;; Custom global keybindings
(global-set-key (kbd "M-<return>") #'recompile)


;;   ===============
;;  == Languages ==
;; ===============
;; NOTE: use M-x treesit-install-language-grammar for new languages

;; Elisp 📝
(use-package elisp-mode)

;; C 📖
(use-package c-ts-mode
  :after format-all
  :hook (c-ts-mode . (lambda ()
			(setq format-all-formatters
			      '(("C" (clang-format "--style=Microsoft"))))))
  :mode (("\\.c\\'" . c-ts-mode))
  :config
  (setq-default c-ts-mode-indent-style "linux"
		c-ts-mode-indent-offset 4))

;; Load the rest of the langs so we don't clog up init.el ;3
(require 'extra-langs)

;; keybindings
(global-set-key (kbd "M-RET") #'recompile)
