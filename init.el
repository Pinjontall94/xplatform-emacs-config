(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;;   =====================================
;;  == Quality of life improvements... ==
;; =====================================

;; Maximized on startup
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; Use (set-frame-font "IBM Plex Mono" nil t) or similar to interactively change font
(set-face-attribute 'default nil :font "IBM Plex Mono" :height 100)

;; Disable splash screen, menu and toolbars; turn on buffer autocompletion
(setq-default inhibit-splash-screen t)
(setq-default visible-bell t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(blink-cursor-mode -1)

;; Set the config folder
(setq-default emacs-conf-folder (expand-file-name "~/code/emacslisp/xplatform-emacs-config"))
(add-to-list 'load-path (expand-file-name "custom/" emacs-conf-folder))

;; Parens completion (Emacs native)
(electric-pair-mode 1)

;; Autoscroll compilation window
(setq-default compilation-scroll-output t)

;; Turn on line numbers in all prog/text modes
(defun enable-line-numbers ()
  "Enable line numbers in a major mode."
  (display-line-numbers-mode t))
(add-hook 'prog-mode-hook #'enable-line-numbers)

;; Config autosave files
(setq
 backup-by-copying t      ; don't clobber symlinks
 backup-directory-alist
 '(("." . "~/.saves/"))    ; don't litter my fs tree
 delete-old-versions t
 kept-new-versions 6
 kept-old-versions 2
 version-control t)       ; use versioned backups

;; Nice modeline, dashboard, themes
(use-package doom-modeline
  :ensure t
  :hook (after-init . doom-modeline-mode))

(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook))

;; Set exec-path to match $PATH environment variable
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
  :preface
  (defun format-code ()
    "Auto-format whole buffer."
    (interactive)
    (format-all-buffer))
  :config
  (global-set-key (kbd "M-F") #'format-code)
  (add-hook 'prog-mode-hook #'format-all-ensure-formatter)
  (add-hook 'before-save-hook #'format-code)
  (setq-default format-all-formatters '(("C" (clang-format "--style=Microsoft")))))

;; Custom global keybindings
(global-set-key (kbd "M-<return>") #'recompile)

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

;; Elisp 📝
(use-package elisp-mode :defer t :config (flycheck-mode -1))

;; C 📖
(use-package c-ts-mode
  :hook ((c-ts-mode . eglot-ensure))
  :mode (("\\.c\\'" . c-ts-mode))
  :config
  (setq-default c-ts-mode-indent-style "k&r"
		c-ts-mode-indent-offset 4))

;; Load the rest of the langs so we don't clog up init.el ;3
(require 'extra-langs)

;;   ======================
;;  == No touch zone ;3 ==
;; ======================
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("7b8f5bbdc7c316ee62f271acf6bcd0e0b8a272fdffe908f8c920b0ba34871d98" "be84a2e5c70f991051d4aaf0f049fa11c172e5d784727e0b525565bb1533ec78" "e3daa8f18440301f3e54f2093fe15f4fe951986a8628e98dcd781efbec7a46f2" "0c83e0b50946e39e237769ad368a08f2cd1c854ccbcd1a01d39fdce4d6f86478" "7e377879cbd60c66b88e51fad480b3ab18d60847f31c435f15f5df18bdb18184" "56044c5a9cc45b6ec45c0eb28df100d3f0a576f18eef33ff8ff5d32bac2d9700" "e4a702e262c3e3501dfe25091621fe12cd63c7845221687e36a79e17cf3a67e0" "aec7b55f2a13307a55517fdf08438863d694550565dee23181d2ebd973ebd6b8" "80214de566132bf2c844b9dee3ec0599f65c5a1f2d6ff21a2c8309e6e70f9242" default))
 '(package-selected-packages
   '(smart-tabs-mode format-all catppuccin pyvenv yasnippet-snippets yasnippet verilog-ext verilog-ts-mode conda magit flycheck evil which-key catppuccin-theme company)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(provide 'init)
