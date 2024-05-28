(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
(electric-pair-mode 1) (column-number-mode 1)
(setq visible-bell t
      compilation-scroll-output t
      evil-want-keybinding nil
      backup-directory-alist '(("." . "~/.saves/")))
(defun enable-lines () (display-line-numbers-mode t))
(add-hook 'prog-mode-hook #'enable-lines)
(add-to-list 'load-path "~/.emacs.d/lisp/")

(use-package ansi-color :config (ansi-color-for-comint-mode-on))
(use-package evil :ensure t :config (evil-mode 1))
(use-package evil-collection :ensure t :after evil
  :config (evil-collection-init))
(use-package company :ensure t :config (global-company-mode 1))
(use-package dashboard :ensure t :config (dashboard-setup-startup-hook))
(add-to-list 'load-path "~/.emacs.d/plugins/yasnippet")
(use-package doom-modeline :ensure t
  :hook (after-init . doom-modeline-mode))
(use-package yasnippet :ensure t :config (yas-global-mode 1))
(use-package yasnippet-snippets :ensure t :after yasnippet)
(use-package which-key :ensure t :config (which-key-mode 1))
(use-package format-all :ensure t
  :hook ((format-all-mode . format-all-ensure-formatter)
	 (prog-mode . format-all-mode)))
(use-package magit :ensure t :bind (("C-x g" . magit-status)))
(use-package flycheck :ensure t :init (global-flycheck-mode))
(require 'extra-langs)

;; keybindings
(global-set-key (kbd "M-<return>") #'recompile)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(flycheck magit yasnippet-snippets doom-modeline yasnippet which-key format-all evil-collection dashboard company)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
