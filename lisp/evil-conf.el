(use-package evil :ensure t
  :init (setq evil-want-keybinding nil)
  :config (evil-mode 1))

(use-package evil-collection :ensure t :after evil
  :config (evil-collection-init))

(use-package treemacs-evil :ensure t :after (treemacs evil))

(provide 'evil-conf)
