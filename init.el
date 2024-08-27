(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

;; Load user lisp projects to the autoload path
(add-to-list 'load-path "~/.emacs.d/lisp/")


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

;; Enable parens matching
(electric-pair-mode 1)

;; GUI configuration (toolbars, etc.)
(require 'gui-conf)

;; Enable lines
(add-hook 'prog-mode-hook
	  (lambda ()
	    (display-line-numbers-mode t)))

;; Nice ligatures
(add-hook 'prog-mode-hook #'prettify-symbols-mode)

;; Since Emacs 29, `yes-or-no-p' will use `y-or-n-p'
(setopt use-short-answers t)

(require 'theme-conf)  ;; includes modeline

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
  (setq eglot-report-progress nil)
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

(require 'extra-langs)		;; Load the rest so we don't clog up init.el ;3
(require 'evil-conf)		;; run `Alt-x evil-mode <ENTER>` to toggle vim-keybindings
(require 'treemacs-conf)	;; nerdtree (C-x t t)
(require 'org-conf)             ;; org mode configuration
(require 'misc-conf)

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
 '(custom-safe-themes
   '("d77d6ba33442dd3121b44e20af28f1fae8eeda413b2c3d3b9f1315fbda021992" "ee0785c299c1d228ed30cf278aab82cf1fa05a2dc122e425044e758203f097d2" default))
 '(org-agenda-files '("/home/sammi/org/notes.org" "/home/sammi/org/todo.org") t)
 '(package-selected-packages
   '(emmet-mode org-static-blog web-mode php-mode htmlize docker-compose-mode simple-httpd dired-auto-readme wat-ts-mode zig-mode yasnippet-snippets which-key treemacs-projectile treemacs-magit treemacs-icons-dired treemacs-evil pyvenv markdown-mode go-mode geiser-racket geiser-mit geiser-guile geiser-chicken geiser-chez format-all flycheck fish-mode exec-path-from-shell evil-collection doom-modeline dashboard conda company cmake-mode catppuccin-theme))
 '(sql-connection-alist
   '(("primafleur-dev-empty"
      (sql-product 'mysql)
      (sql-user "root")
      (sql-database "primafleur")
      (sql-server "localhost")))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
