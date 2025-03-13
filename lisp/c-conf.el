;;; c-conf -- My C/C++ mode config -*- lexical-binding: t; -*-
;;; Commentary:

;;; Code:
;; C 📖
(add-to-list 'major-mode-remap-alist '(c-mode . c-ts-mode))
(add-to-list 'major-mode-remap-alist '(c++-mode . c++-ts-mode))
(add-to-list 'major-mode-remap-alist
	     '(c-or-c++-mode . c-or-c++-ts-mode))

(use-package c-ts-mode
  :after format-all
  :hook ((c-ts-mode . eglot-ensure)
	 (c-ts-mode . (lambda ()
		       (setq format-all-formatters
			     '(("C" (clang-format "--style=Microsoft"))))))
	 (c-ts-mode . c-ts-mode-toggle-comment-style))
  :config
  (setq c-ts-mode-indent-offset 2)
  ;; Call clang-format whenever c-indent-region is called
  (fset 'c-indent-region 'format-all-buffer))

(use-package c++-ts-mode
  :after format-all
  :hook ((c++-ts-mode . eglot-ensure)
	 (c++-ts-mode . (lambda ()
		       (setq format-all-formatters
			     '(("C" (clang-format "--style=Microsoft"))))))
	 (c++-ts-mode . c++-ts-mode-toggle-comment-style))
  :config
  (setq c++-ts-mode-indent-offset 2)
  ;; Call clang-format whenever c-indent-region is called
  (fset 'c-indent-region 'format-all-buffer))


(provide 'c-conf)
;;; c-conf.el ends here
