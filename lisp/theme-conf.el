;; Nice theme and modeline for the modern era ;3
(use-package catppuccin-theme :ensure t
  :config
  (load-theme 'catppuccin :no-confirm)
  (catppuccin-load-flavor 'latte))

(use-package doom-modeline :ensure t :hook (after-init . doom-modeline-mode))

(provide 'theme-conf)
