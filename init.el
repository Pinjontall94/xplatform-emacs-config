(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;;   =====================================
;;  == Quality of life improvements... ==
;; =====================================


;; Maximize startup, disable menu and toolbars, enable parens & visible bell
(add-to-list 'default-frame-alist '(fullscreen . maximized))
(electric-pair-mode 1)
(setq-default visible-bell t)
(tool-bar-mode -1) (scroll-bar-mode -1) (blink-cursor-mode -1) (menu-bar-mode -1)
(column-number-mode 1)
(load-theme 'deeper-blue)

;; Set the config folder
(setq-default emacs-conf-folder
	      (expand-file-name "~/code/emacslisp/xplatform-emacs-config"))
(add-to-list 'load-path (expand-file-name "pinjontall94/" emacs-conf-folder))

;; Autoscroll compilation window
(setq-default compilation-scroll-output t)

;; Enable lines
(defun enable-lines () (display-line-numbers-mode t))
(add-hook 'prog-mode-hook #'enable-lines)

;; Config autosave files
(setq
 backup-by-copying t      ; don't clobber symlinks
 backup-directory-alist
 '(("." . "~/.saves/"))    ; don't litter my fs tree
 delete-old-versions t
 kept-new-versions 6
 kept-old-versions 2
 version-control t)       ; use versioned backups

(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook))

;; Set exec-path to match $PATH environment variable
(use-package exec-path-from-shell
  :ensure t
  :init (setq exec-path-from-shell-arguments nil)
  :config
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize)))

;; Git integration
(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status)))

;; M-x VS Code
;; Autocompletion and language servers
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

;; Code snippets so you don't have to type as much
(use-package yasnippet
  :ensure t
  :config
  (add-to-list 'load-path "~/.emacs.d/plugins/yasnippet")
  (yas-global-mode 1))

(use-package yasnippet-snippets
  :after yasnippet
  :ensure t)

;; Autoformatting
(use-package format-all
  :defer t
  :commands format-all-mode
  :hook (prog-mode . format-all-mode)
  :config
  (setq-default format-all-formatters
                '(("C"     (clang-format "--style=Microsoft"))
                  ("Shell" (shfmt "-i" "4" "-ci"))
		  ("HTML"  prettier))))

;; Custom global keybindings
(global-set-key (kbd "M-<return>") #'recompile)

;;   =====================
;;  == EVIL Config >:3 ==
;; =====================

(use-package evil
  :ensure t
  :init (setq evil-want-keybinding nil)
  :config (evil-mode 1))

(use-package evil-collection
  :after evil
  :ensure t
  :config (evil-collection-init))

;;   ===============
;;  == Languages ==
;; ===============
;; NOTE: use M-x treesit-install-language-grammar for new languages

;; Elisp 📝
(use-package elisp-mode :defer t)

;; C 📖
(use-package c-ts-mode
  :after format-all
  :hook ((c-ts-mode . eglot-ensure))
  :mode (("\\.c\\'" . c-ts-mode))
  :config
  (setq-default c-ts-mode-indent-style "linux"
		c-ts-mode-indent-offset 4))

;; Load the rest of the langs so we don't clog up init.el ;3
(require 'extra-langs)

;; keybindings
(global-set-key (kbd "M-RET") #'recompile)

;;   ======================
;;  == No touch zone ;3 ==
;; ======================
