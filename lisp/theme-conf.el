;; Nice theme and modeline for the modern era ;3
(use-package adwaita-dark-theme :ensure t
  :config
  (load-theme 'adwaita-dark t))

(use-package doom-modeline :ensure t :hook (after-init . doom-modeline-mode))

(provide 'theme-conf)
