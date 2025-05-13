;;; lisp-conf.el --- my common lisp setup -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:
;; Common Lisp 👽
(use-package slime :defer
  :config
  (add-to-list 'load-path "~/.emacs.d/elpa/slime/")
  (require 'slime-autoloads)
  (setq inferior-lisp-program "sbcl")
  (setq-default slime-contribs '(slime-fancy slime-company))
  (setq-default slime-lisp-implementations
		`((sbcl ("sbcl" "--core" "sbcl.core-for-slime"))
		  (ecl ("ecl"))))
  (setf slime-default-lisp 'sbcl))

  ;; Automatically connect to slime when opening a lisp file
  ;; (add-hook 'slime-mode-hook
  ;;                (lambda ()
  ;;                  (unless (slime-connected-p)
  ;;                    (save-excursion (slime)))))
  )

(provide 'lisp-conf)
;;; lisp-conf.el ends here
