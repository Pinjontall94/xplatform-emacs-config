;;; misc-conf.el --- Miscellaneous (Stuff I don't want to clog up the init.el)

;;; Commentary:

;;; Code:
;; show the readme in dired buffers
(use-package dired-auto-readme :ensure t
  :config
  (dired-auto-readme-mode 1))

(use-package impatient-mode :ensure t :defer t)
(use-package simple-httpd :ensure t :defer t)
(use-package hl-todo :ensure t
  :config
  (global-hl-todo-mode t))

(defun config-emacs ()
  "This opens the Emacs config folder for easy editing."
  (interactive)
  (dired "~/.emacs.d/"))

(provide 'misc-conf)
;;; misc-conf.el ends here.
