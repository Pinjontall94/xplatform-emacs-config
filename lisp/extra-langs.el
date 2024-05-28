(use-package c-ts-mode
  :after format-all
  :hook (c-ts-mode . (lambda ()
		       (setq format-all-formatters
			     '(("C" (clang-format "--style=Microsoft"))))))
  :mode (("\\.c\\'" . c-ts-mode))
  :config
  (setq-default c-ts-mode-indent-style "linux"
		c-ts-mode-indent-offset 4))

(provide 'extra-langs)
