;;; init.el --- Emacs init script -*- lexical-binding: t -*-
;;; Commentary:
;;; This file loads when Emacs first boots up
;;; Code:
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;;; bootstrap use-package (from gavin freeborn config)
;; (setq use-package-always-ensure t)
;; (unless (package-installed-p 'use-package)
;;   (package-refresh-contents)
;;   (package-install 'use-package))

;; (eval-when-compile
;;   ;; Following line is not needed if use-package.el is in ~/.emacs.d
;;   ;; (add-to-list 'load-path "<path where use-package is installed>")
;;   (require 'use-package))

;; Bootstrap Straight.el
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))
(straight-use-package 'use-package)


;;;   =====================================
;;;  == Quality of life improvements... ==
;;; =====================================

;;; Set font with broad unicode support
(set-face-attribute 'default nil :family "FiraCode Nerd Font" :height 100)

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
(straight-use-package 'catppuccin-theme)
(load-theme 'catppuccin :no-confirm)

;;; Better Modeline (from Doom project)
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :config
  (setq doom-modeline-buffer-encoding nil))

;;; Use modern icons
(use-package all-the-icons
  :ensure t)

(use-package nerd-icons
  :ensure t)

;;; Enable line numbers for all prog/text modes
(defun enable-line-numbers ()
  "Enable line numbers in a major mode."
  (display-line-numbers-mode t))
(add-hook 'prog-mode-hook #'enable-line-numbers)

;;; Disable menu and toolbars
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

;;; Maximize on startup
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;;; Tree File Explorer
(use-package treemacs
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :config
  (progn
    (setq treemacs-collapse-dirs                   (if treemacs-python-executable 3 0)
          treemacs-deferred-git-apply-delay        0.5
          treemacs-directory-name-transformer      #'identity
          treemacs-display-in-side-window          t
          treemacs-eldoc-display                   'simple
          treemacs-file-event-delay                2000
          treemacs-file-extension-regex            treemacs-last-period-regex-value
          treemacs-file-follow-delay               0.2
          treemacs-file-name-transformer           #'identity
          treemacs-follow-after-init               t
          treemacs-expand-after-init               t
          treemacs-find-workspace-method           'find-for-file-or-pick-first
          treemacs-git-command-pipe                ""
          treemacs-goto-tag-strategy               'refetch-index
          treemacs-header-scroll-indicators        '(nil . "^^^^^^")
          treemacs-hide-dot-git-directory          t
          treemacs-indentation                     2
          treemacs-indentation-string              " "
          treemacs-is-never-other-window           nil
          treemacs-max-git-entries                 5000
          treemacs-missing-project-action          'ask
          treemacs-move-forward-on-expand          nil
          treemacs-no-png-images                   nil
          treemacs-no-delete-other-windows         t
          treemacs-project-follow-cleanup          nil
          treemacs-persist-file                    (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
          treemacs-position                        'left
          treemacs-read-string-input               'from-child-frame
          treemacs-recenter-distance               0.1
          treemacs-recenter-after-file-follow      nil
          treemacs-recenter-after-tag-follow       nil
          treemacs-recenter-after-project-jump     'always
          treemacs-recenter-after-project-expand   'on-distance
          treemacs-litter-directories              '("/node_modules" "/.venv" "/.cask")
          treemacs-project-follow-into-home        nil
          treemacs-show-cursor                     nil
          treemacs-show-hidden-files               t
          treemacs-silent-filewatch                nil
          treemacs-silent-refresh                  nil
          treemacs-sorting                         'alphabetic-asc
          treemacs-select-when-already-in-treemacs 'move-back
          treemacs-space-between-root-nodes        t
          treemacs-tag-follow-cleanup              t
          treemacs-tag-follow-delay                1.5
          treemacs-text-scale                      nil
          treemacs-user-mode-line-format           nil
          treemacs-user-header-line-format         nil
          treemacs-wide-toggle-width               70
          treemacs-width                           35
          treemacs-width-increment                 1
          treemacs-width-is-initially-locked       t
          treemacs-workspace-switch-cleanup        nil)

    ;; The default width and height of the icons is 22 pixels. If you are
    ;; using a Hi-DPI display, uncomment this to double the icon size.
    ;;(treemacs-resize-icons 44)

    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t)
    (treemacs-fringe-indicator-mode 'always)
    (when treemacs-python-executable
      (treemacs-git-commit-diff-mode t))

    (pcase (cons (not (null (executable-find "git")))
                 (not (null treemacs-python-executable)))
      (`(t . t)
       (treemacs-git-mode 'deferred))
      (`(t . _)
       (treemacs-git-mode 'simple)))

    (treemacs-hide-gitignored-files-mode nil))
  :bind
  (:map global-map
        ("M-0"       . treemacs-select-window)
        ("C-x t 1"   . treemacs-delete-other-windows)
        ("C-x t t"   . treemacs)
        ("C-x t d"   . treemacs-select-directory)
        ("C-x t B"   . treemacs-bookmark)
        ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag)))

(use-package treemacs-evil
  :after (treemacs evil)
  :ensure t)

(use-package treemacs-projectile
  :after (treemacs projectile)
  :ensure t)

(use-package treemacs-icons-dired
  :hook (dired-mode . treemacs-icons-dired-enable-once)
  :ensure t)

(use-package treemacs-magit
  :after (treemacs magit)
  :ensure t)

(use-package treemacs-persp ;;treemacs-perspective if you use perspective.el vs. persp-mode
  :after (treemacs persp-mode) ;;or perspective vs. persp-mode
  :ensure t
  :config (treemacs-set-scope-type 'Perspectives))

(use-package treemacs-tab-bar ;;treemacs-tab-bar if you use tab-bar-mode
  :after (treemacs)
  :ensure t
  :config (treemacs-set-scope-type 'Tabs))

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
	 (c-mode . lsp)
	 (c++-mode . lsp)
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

;; Scheme
(use-package geiser-guile :ensure t)
(use-package geiser-chibi :ensure t)

;; Common Lisp
(use-package sly
  :ensure t
  :config
  (setq sly-lisp-implementations
	;; Set path strings to the appropriate absolute paths to your roswell executable
         '((sbcl ("/home/linuxbrew/.linuxbrew/bin/ros" "-L" "sbcl" "-Q" "run") :coding-system utf-8-unix))))
;;(load (expand-file-name "c:/Users/soeba/.roswell/helper.el"))
(setq inferior-lisp-program "ros -Q run")

;;;   =======================
;;;  == NO TOUCH ZONE >:3 ==
;;; =======================

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("37768a79b479684b0756dec7c0fc7652082910c37d8863c35b702db3f16000f8"
     default))
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
