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
 org-agenda-files '("~/org")  ; Org(anize) your life, girl
 initial-scratch-message
 ";; This buffer is dedicated, in respect and admiration,\12;; to the spirit that lives in the computer~ UwU...\12\12")

;; Enable parens matching, column numbers, and tab-bar
(electric-pair-mode 1) (column-number-mode 1) (tab-bar-mode 1)

;; Load user lisp projects to the autoload path
(add-to-list 'load-path "~/.emacs.d/lisp/")

;; Enable lines
(add-hook 'prog-mode-hook
	  (lambda ()
	    (display-line-numbers-mode t)))

;; Nice ligatures
(add-hook 'prog-mode-hook #'prettify-symbols-mode)

;; Nice theme, dashboard, and modeline for the modern era ;3
(use-package catppuccin-theme :ensure t
  :config
  (catppuccin-load-flavor 'latte)) ;; 'latte, 'macchiato, 'frappe or 'mocha
(use-package doom-modeline :ensure t :hook (after-init . doom-modeline-mode))

;; Set exec-path to match $PATH environment variable
(use-package exec-path-from-shell :ensure t
  :init (setq exec-path-from-shell-arguments nil)
  :config
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize)))

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
	      ("C-c d" . eldoc)
	      ("C-c a" . eglot-code-actions)
	      ("C-c r" . eglot-rename))
  :config
  (add-to-list 'eglot-server-programs
	       '(verilog-mode . ("hdl_checker" "--lsp"))))

;; Which key does what again?
(use-package which-key :ensure t :config (which-key-mode))

;; Syntax checking
(use-package flycheck :ensure t :defer t :init (global-flycheck-mode))

;; Code snippets so you don't have to type as much
(use-package yasnippet :ensure t
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


;;   =====================
;;  == EVIL Config >:3 ==
;; =====================
;; Highlight the following lines, run
;; `Alt-x uncomment-region`, save and reload to enable vim-keybindings

(use-package evil :ensure t
  :init (setq evil-want-keybinding nil)
  :config (evil-mode 1))

(use-package evil-collection :ensure t :after evil
  :config (evil-collection-init))

(use-package treemacs-evil :ensure t :after (treemacs evil))

;;   ===============
;;  == Languages ==
;; ===============
;; NOTE: use M-x treesit-install-language-grammar for new languages

;; C 📖
(use-package c-ts-mode
  :after format-all
  :hook (c-ts-mode . (lambda ()
			(setq format-all-formatters
			      '(("C" (clang-format "--style=Microsoft"))))))
  :mode (("\\.c\\'" . c-ts-mode))
  :config
  (setq-default c-ts-mode-indent-style "linux"
		c-mode-indent-style "inux"
		c-ts-mode-indent-offset 4
		c-mode-indent-offset 4))

;; Load the rest of the langs so we don't clog up init.el ;3
(require 'extra-langs)

;;   ==============
;;  == Treemacs ==
;; ==============
(use-package treemacs :ensure t
  :bind
  (:map global-map
	("M-0"       . treemacs-select-window)
	("C-x t 1"   . treemacs-delete-other-windows)
	("C-x t t"   . treemacs)
	("C-x t d"   . treemacs-select-directory)
	("C-x t B"   . treemacs-bookmark)
	("C-x t C-t" . treemacs-find-file)
	("C-x t M-t" . treemacs-find-tag)))
(use-package treemacs-projectile :ensure t :after (treemacs projectile))
(use-package treemacs-icons-dired :ensure t
  :hook (dired-mode . treemacs-icons-dired-enable-once))
(use-package treemacs-magit :ensure t :after (treemacs magit))
(use-package treemacs-tab-bar :ensure t :after (treemacs))

;; keybindings
(global-set-key (kbd "M-RET") #'recompile)
(global-set-key (kbd "C-c l") #'org-store-link)
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(wat-ts-mode zig-mode yasnippet-snippets which-key treemacs-projectile treemacs-magit treemacs-icons-dired treemacs-evil pyvenv markdown-mode go-mode geiser-racket geiser-mit geiser-guile geiser-chicken geiser-chez format-all flycheck fish-mode exec-path-from-shell evil-collection doom-modeline dashboard conda company cmake-mode catppuccin-theme)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
