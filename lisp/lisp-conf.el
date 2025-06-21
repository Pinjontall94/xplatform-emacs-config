;;; lisp-conf.el --- my common lisp setup -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:
;; Common Lisp 👽
(use-package slime :ensure t :defer
  :config
  (add-to-list 'load-path "~/.emacs.d/elpa/slime/")
  (require 'slime-autoloads)
  (setq-default inferior-lisp-program "sbcl")
  (setq-default slime-contribs '(slime-fancy slime-company))
  (setq-default slime-lisp-implementations
		`((sbcl ("sbcl" "--core" "sbcl.core-for-slime"))
		  (ecl ("ecl"))
		  (qlot ("qlot" "exec" "sbcl") :coding-system utf-8-unix)
		  (egghunt-sbcl ("~/code/lisp/keepit-egg-hunt/keepit-egg-hunt"))))
  (setq-default slime-default-lisp 'qlot))

  ;; Automatically connect to slime when opening a lisp file
  ;; (add-hook 'slime-mode-hook
  ;;                (lambda ()
  ;;                  (unless (slime-connected-p)
  ;;                    (save-excursion (slime)))))

(use-package slime-company :ensure t :defer
  :after slime)

(provide 'lisp-conf)
;;; lisp-conf.el ends here
