;;   ====================================
;;  == Treemacs (nerdtree for emacs!) ==
;; ====================================
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

(provide 'treemacs-conf)
