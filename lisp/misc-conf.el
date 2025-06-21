;;; misc-conf.el --- Miscellaneous (Stuff I don't want to clog up the init.el)

;;; Commentary:

;;; Code:
;; show the readme in dired buffers
(use-package dired-auto-readme :ensure t
  :hook ((dired-mode . dired-auto-readme-mode)))

(use-package impatient-mode :ensure t :defer t)
(use-package simple-httpd :ensure t :defer t)
(use-package hl-todo :ensure t
  :config
  (global-hl-todo-mode t))

(defun config-emacs ()
  "This opens the Emacs config folder for easy editing."
  (interactive)
  (dired "~/.emacs.d/"))

(defun shruggie ()
  "Prints a shruggie and puts it in ur kill-ring."
  (interactive)
  (princ (format "¯\\_(ツ)_/¯"))
  (kill-new (format "¯\\_(ツ)_/¯")))

(defun post ()
  (interactive)
  (let ((txt (read-from-minibuffer "Post body: ")))
    (princ (format "%s" txt))
    (kill-new (format "%s" txt))))

(provide 'misc-conf)
;;; misc-conf.el ends here.
