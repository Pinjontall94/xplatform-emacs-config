(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;;   =====================================
;;  == Quality of life improvements... ==
;; =====================================

(add-to-list 'default-frame-alist '(fullscreen . maximized))
(add-to-list 'load-path "~/.emacs.d/custom/")

;; Use (set-frame-font "IBM Plex Mono" nil t) or similar to interactively change font
(set-face-attribute 'default nil :font "IBM Plex Mono" :height 100)

(setq-default inhibit-splash-screen t)
(setq-default visible-bell t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(blink-cursor-mode -1)
(electric-pair-mode 1)
(setq-default compilation-scroll-output t)

(setq-default xplatform-conf (expand-file-name "~/code/emacslisp/xplatform-emacs-config"))

(defun enable-line-numbers ()
  "Enable line numbers in a major mode."
  (display-line-numbers-mode t))
(add-hook 'prog-mode-hook #'enable-line-numbers)

(setq
   backup-by-copying t      ; don't clobber symlinks
   backup-directory-alist
    '(("." . "~/.saves/"))    ; don't litter my fs tree
   delete-old-versions t
   kept-new-versions 6
   kept-old-versions 2
   version-control t)       ; use versioned backups

(use-package doom-modeline
  :ensure t
  :hook (after-init . doom-modeline-mode))

(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook))

(use-package doom-themes
  :ensure t
  :config
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-xcode t)
  (doom-themes-visual-bell-config)
  (setq doom-themes-treemacs-theme "doom-colors") ; use "doom-colors" for less minimal icon theme
  (doom-themes-treemacs-config)
  (doom-themes-org-config))

(use-package exec-path-from-shell
  :ensure t
  :config
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize)))

(use-package magit
  :ensure t
  :init
  (message "Loading Magit!")
  :config
  (message "Loaded Magit!")
  :bind (("C-x g" . magit-status)))

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

(use-package which-key
  :ensure t
  :config
  (which-key-mode))

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

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

;; Elisp 📝
(use-package elisp-mode :defer t :config (flycheck-mode -1))

;; C 📖
(use-package c-ts-mode
  :hook ((c-ts-mode . eglot-ensure))
  :mode (("\\.c\\'" . c-ts-mode)
	 ("\\.l\\'" . c-ts-mode))
  :bind (:map c-ts-mode-map
	      ("<f5>" . recompile)
	      ("<f6>" . eglot-format))
  :config
  (setq-default c-default-style "linux"
		c-basic-offset 4))

(load (expand-file-name "extra-langs.el" xplatform-conf))
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
   '("7e377879cbd60c66b88e51fad480b3ab18d60847f31c435f15f5df18bdb18184" "56044c5a9cc45b6ec45c0eb28df100d3f0a576f18eef33ff8ff5d32bac2d9700" "e4a702e262c3e3501dfe25091621fe12cd63c7845221687e36a79e17cf3a67e0" "aec7b55f2a13307a55517fdf08438863d694550565dee23181d2ebd973ebd6b8" "80214de566132bf2c844b9dee3ec0599f65c5a1f2d6ff21a2c8309e6e70f9242" default))
 '(package-selected-packages
   '(catppuccin pyvenv yasnippet-snippets yasnippet verilog-ext verilog-ts-mode conda magit flycheck evil which-key catppuccin-theme company)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(provide 'init)
