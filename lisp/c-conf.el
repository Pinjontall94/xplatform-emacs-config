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
  :hook (c-ts-mode . (lambda ()
		       (setq-default format-all-formatters
			     '(("C" (clang-format))))))
  :config
  (setq-default c-ts-mode-indent-offset 4)
  ;; Call clang-format whenever c-indent-region is called
  (fset 'c-indent-region 'format-all-buffer))

(use-package c++-ts-mode
  :after format-all
  :hook (c++-ts-mode . (lambda ()
		       (setq-default format-all-formatters
			     '(("C" (clang-format))))))
  :config
  (setq-default c++-ts-mode-indent-offset 4)
  ;; Call clang-format whenever c-indent-region is called
  (fset 'c-indent-region 'format-all-buffer))


(provide 'c-conf)
;;; c-conf.el ends here
