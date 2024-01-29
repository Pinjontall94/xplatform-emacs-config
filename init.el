;;; init.el --- Emacs init script -*- lexical-binding: t -*-
;;; Commentary:
;;; This file loads when Emacs first boots up
;;; Code:

;; Enable MELPA packages
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;;   =====================================
;;  == Quality of life improvements... ==
;; =====================================

;; Maximized on startup
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; Font
;; NOTE: add `:font "Fira Code"` or similar to change font
(set-face-attribute 'default t :height 100)

;; Disable splash screen, menu and toolbars
(setq inhibit-splash-screen t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(blink-cursor-mode -1)
(setq visible-bell t)

;; Parens completion (Emacs native)
(electric-pair-mode 1)

;; Enable line numbers for all prog/text modes
(defun enable-line-numbers ()
  "Enable line numbers in a major mode."
  (display-line-numbers-mode t))
(add-hook 'prog-mode-hook #'enable-line-numbers)

;; Set exec-path from shell PATH
(use-package exec-path-from-shell
  :ensure t
  :config
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize)))

;; Git integration
(use-package magit
  :ensure t
  :init
  (message "Loading Magit!")
  :config
  (message "Loaded Magit!")
  :bind (("C-x g" . magit-status)))

;; M-x VS Code
;; (Use autocompletion in all programming modes, set LSP keybindings)
(use-package company
  :ensure t
  :hook (prog-mode . company-mode)
  :config
  (setq company-idle-delay 0.1
	company-minimum-prefix-length 1))

(use-package eglot
  :bind (:map eglot-mode-map
	      ("C-c d" . eldoc)
	      ("C-c a" . eglot-code-actions)
	      ("C-c r" . eglot-rename))
  :config
  (add-to-list 'eglot-server-programs
	       '(verilog-mode . ("hdl_checker" "--lsp"))))

;; Which key does what again?
(use-package which-key
  :ensure t
  :config
  (which-key-mode))

;; Syntax checking
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

;; Snippets so you don't have to type as much
(use-package yasnippet
  :ensure t
  :config
  (add-to-list 'load-path
	       "~/.emacs.d/plugins/yasnippet")
  (yas-global-mode 1))

(use-package yasnippet-snippets
  :after yasnippet
  :ensure t)

;;   =====================
;;  == EVIL Config >:3 ==
;; =====================

(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

;;   ===============
;;  == Languages ==
;; ===============
;; NOTE: use M-x treesit-install-language-grammar for new languages

;; C 📖
(use-package c-ts-mode
  :hook ((c-ts-mode . eglot-ensure))
  :mode (("\\.c\\'" . c-ts-mode))
  :bind (:map c-ts-mode-map
	      ("<f5>" . recompile)
	      ("<f6>" . eglot-format)))

;; Rust 🦀
(use-package rust-ts-mode
  :hook ((rust-ts-mode . eglot-ensure))
  :mode (("\\.rs\\'" . rust-ts-mode)))

;; Python 🐍
(use-package python-ts-mode
  :hook ((python-ts-mode . eglot-ensure))
  :mode (("\\.py\\'" . python-ts-mode))
  :interpreter ("ipython" . python-ts-mode))

(use-package conda
  :after python-ts-mode
  :ensure t
  :config
  (setq-default conda-env-home-directory
	(expand-file-name "~/miniforge3")))

(use-package pyvenv
  :after python-ts-mode
  :ensure t)

;; Scheme λ
(use-package geiser-guile :ensure t)
(use-package geiser-chicken :ensure t)
(use-package geiser-mit :ensure t)
(use-package geiser-chez :ensure t)
(use-package geiser-racket :ensure t)

;; Verilog ⚒️
(use-package verilog-mode
  :ensure t
  :hook ((verilog-mode . eglot-ensure))
  :mode ("\\.v\\'" "\\.sv\\'")
  :config
  (setq verilog-compiler "verilator")
  (setq verilog-tool verilog-compiler))

;;   ======================
;;  == No touch zone ;3 ==
;; ======================
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(pyvenv yasnippet-snippets yasnippet verilog-ext verilog-ts-mode conda magit flycheck evil which-key catppuccin-theme company)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(provide 'init)
;;; init.el ends here
