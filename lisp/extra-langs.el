;;; extra-langs.el --- Sammi's Emacs Extra Language Configs -*- lexical-binding: t -*-
;;; Commentary:
;;; This file contains extra language specific configs to keep from overpopulating init.el
;;; Code:
(require 'format-all)


;; Cmake 🔺
(use-package cmake-mode :ensure t :defer t)

;; Go 🐿️
(use-package go-mode :ensure t :defer t)

;; C# 🪟
(use-package csharp-mode :ensure t :defer t)


;; Unix shell 🐚
(use-package sh-mode :defer t
  :hook (sh-mode . (lambda ()
		     (setq format-all-formatters
			   '(("Shell" (shfmt "-i" "4" "-ci")))))))

;; HTML/CSS 🌐
(use-package mhtml-mode :ensure t :defer t
  :hook (mhtml-mode . (lambda ()
			(setq format-all-formatters
			      '(("HTML" prettier))))))
;; zig 🦎
(use-package zig-mode :ensure t :defer t)

;; Rust 🦀
(use-package rust-ts-mode :ensure t :defer t)


;; Java ☕
(use-package java-ts-mode
  :ensure t :after format-all
  :hook ((java-ts-mode . eglot-ensure))
  :mode (("\\.java\\'" . java-ts-mode)))


;; Python 🐍
(use-package python
  :after format-all
  :hook ((python-ts-mode . eglot-ensure)
	 (python-ts-mode . (lambda ()
			     (setq format-all-formatters
				   '(("Python" black))))))
  :mode (("\\.py\\'" . python-ts-mode))
  :interpreter ("ipython" . python-ts-mode))

(use-package conda
  :ensure t :after python-ts-mode
  :config
  (setq-default conda-env-home-directory
		(expand-file-name "~/miniforge3")))

(use-package pyvenv :ensure t :after python-ts-mode)


;; Scheme λ
(use-package geiser-guile :ensure t :defer t)
(use-package geiser-chicken :ensure t :defer t)
(use-package geiser-mit :ensure t :defer t)
(use-package geiser-chez :ensure t :defer t)
(use-package geiser-racket :ensure t :defer t)


;; Verilog ⚒️
(use-package verilog-mode
  :ensure t :after format-all
  :hook ((verilog-mode . eglot-ensure)
	 (verilog-mode . (lambda ()
			   (setq format-all-formatters
				 '(("Verilog" verible-verilog-format))))))
  :mode ("\\.v\\'" "\\.sv\\'")
  :config
  (setq verilog-compiler "verilator")
  (setq verilog-tool verilog-compiler))

;; fish 🐠
(use-package fish-mode :ensure t :defer t
  :mode "\\.fish\\'")

(use-package wat-ts-mode :ensure t :defer t
  :mode "\\.wat\\'")

(use-package docker-compose-mode :ensure t :defer t)

(use-package php-mode :ensure t :defer t
  :init (with-eval-after-load 'eglot
	  (add-to-list 'eglot-server-programs
		       '(foo-mode . ("fools" "--stdio"))))
  :hook ((php-mode . (lambda ()
		       (setq format-all-formatters
			     '(("php" (prettier "--write")))))))
  :mode ("\\.php\\'" . php-mode))


(message "loaded extra-langs.el! :3")
(provide 'extra-langs)
;;; extra-langs.el ends here
