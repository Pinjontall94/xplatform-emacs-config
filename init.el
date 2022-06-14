;;; init.el --- Emacs init script
;;; Commentary:
;;; This file loads when Emacs first boots up
;;; Code:
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;;; bootstrap use-package (from gavin freeborn config)
(setq use-package-always-ensure t)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  ;; Following line is not needed if use-package.el is in ~/.emacs.d
  ;; (add-to-list 'load-path "<path where use-package is installed>")
  (require 'use-package))



;;;   =====================================
;;;  == Quality of life improvements... ==
;;; =====================================

;;; Set font with broad unicode support
(set-face-attribute 'default nil :family "Noto Sans Mono" :height 110)

;;; Disable splash screen
(setq inhibit-splash-screen t)

;;; Use a more traditional "undo"
(use-package undo-fu)

;;; Show which keybindings do what action
(use-package which-key
  :config
  (which-key-mode))

;;; Better menus
(use-package vertico
  :init
  (vertico-mode))

;;; Nice theme
(use-package nord-theme
  :config
  (load-theme 'nord t))

;;; Better Modeline (from Doom project)
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

;;; Use modern icons
(use-package all-the-icons
  :ensure t)

;;; Enable line numbers globally
(global-linum-mode)

;;; Disable menu and toolbars
(tool-bar-mode -1)
(menu-bar-mode -1)

;;; Maximize on startup
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;;; Projects
(use-package projectile
  :config
  (projectile-mode +1)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map))

;;; Magit for git integration
(use-package magit
  :init
  (message "Loading Magit!")
  :config
  (message "Loaded Magit!")
  :bind (("C-x g" . magit-status)
         ("C-x C-g" . magit-status)))

;;; Parens completion (Emacs native)
(electric-pair-mode 1)

;;; Completion
(use-package company
  :config
  (setq company-idle-delay 0.3)
  (global-company-mode t))

;;; M-x VS Code
(use-package lsp-mode
  :ensure t
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c l")
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
         (XXX-mode . lsp)
         ;; if you want which-key integration
         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)

;; Use lsp-mode's ui
(use-package lsp-ui
  :requires lsp-mode
  :commands lsp-ui-mode)

;; Integrate lsp-mode with treemacs
(use-package lsp-treemacs
  :requires (lsp-mode treemacs)
  :commands lsp-treemacs-errors-list)

;;; Syntax checking
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))



;;;   =====================
;;;  == EVIL Config >:3 ==
;;; =====================

;;; Vim bindings
(use-package evil
  :demand t
  :bind (("<escape>" . keyboard-escape-quit))
  ;; allows for using cgn
  ;; (setq evil-search-module 'evil-search)
  :init
  (setq evil-want-keybinding nil)
  ;; no vim insert bindings
  (setq evil-undo-system 'undo-fu)
  :config
  (evil-mode 1))

;;; Vim bindings everywhere in Emacs
(use-package evil-collection
  :after evil
  :config
  (setq evil-want-integration t)
  (evil-collection-init))



;;;   ===============
;;;  == Languages ==
;;; ===============

;; Common Lisp
(use-package sly
  :ensure t
  :config
  (setq sly-lisp-implementations
         '((sbcl ("C:/Users/soeba/scoop/shims/ros.exe" "-L" "sbcl" "-Q" "run") :coding-system utf-8-unix)
           (clisp ("C:/Users/soeba/scoop/shims/ros.exe" "-L" "clisp" "-Q" "run"))
           (clozure-cl ("C:/Users/soeba/scoop/shims/ros.exe" "-L" "ccl-bin" "-Q" "run"))
           (cmucl ("C:/Users/soeba/scoop/shims/ros.exe" "-L" "cmu-bin" "-Q" "run"))
           (ecl ("C:/Users/soeba/scoop/shims/ros.exe" "-L" "ecl" "-Q" "run") :coding-system utf-8-unix)
           (abcl ("C:/Users/soeba/scoop/shims/ros.exe" "-L" "abcl-bin" "-Q" "run")))))
;;(load (expand-file-name "c:/Users/soeba/.roswell/helper.el"))
(setq inferior-lisp-program "ros -Q run")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("37768a79b479684b0756dec7c0fc7652082910c37d8863c35b702db3f16000f8" default))
 '(package-selected-packages
   '(projectile which-key vertico use-package undo-fu nord-theme gruvbox-theme evil-collection doom-modeline all-the-icons)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
