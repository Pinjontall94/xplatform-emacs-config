;;; lisp-conf.el --- my common lisp setup -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:
;; Common Lisp 👽
(add-to-list 'load-path "~/lisp/slime/")
;;(load (expand-file-name "~/.roswell/helper.el"))
(require 'slime-autoloads)
(setq inferior-lisp-program "ros -Q run")
(setq-default slime-contribs '(slime-fancy slime-company))
(setq-default slime-lisp-implementations
	      `((sbcl ("sbcl" "--dynamic-space-size" "4Gb" "--core" "sbcl.core-for-slime"))
		(roswell ("ros" "-L" "sbcl" "-Q" "run" "--" "--noinform" "--dynamic-space-size" "4Gb"))))
(setf slime-default-lisp 'roswell)

;; Automatically connect to slime when opening a lisp file
;; (add-hook 'slime-mode-hook
;;                (lambda ()
;;                  (unless (slime-connected-p)
;;                    (save-excursion (slime)))))

(provide 'lisp-conf)
;;; lisp-conf.el ends here
