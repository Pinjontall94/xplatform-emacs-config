;;; langs.el --- Sammi's Emacs Extra Language Configs -*- lexical-binding: t -*-
;;; Commentary:
;;; This file contains extra language specific configs to keep from overpopulating init.el
;;; Code:
;; Rust 🦀
(use-package rust-ts-mode
  :defer t
  :hook ((rust-ts-mode . eglot-ensure))
  :mode (("\\.rs\\'" . rust-ts-mode)))


;; Java ☕
(use-package java-ts-mode
  :defer t
  :hook ((java-ts-mode . eglot-ensure))
  :mode (("\\.java\\'" . java-ts-mode)))


;; Python 🐍
(use-package python-ts-mode
  :defer t
  :hook ((python-ts-mode . eglot-ensure))
  :mode (("\\.py\\'" . python-ts-mode))
  :interpreter ("ipython" . python-ts-mode))

(use-package conda
  :after python-ts-mode
  :ensure t
  :config
  (setq-default conda-env-home-directory
		(expand-file-name "~/miniforge3")))

(use-package pyvenv :after python-ts-mode :ensure t)


;; Scheme λ
(use-package geiser-guile :ensure t :defer t)
(use-package geiser-chicken :ensure t :defer t)
(use-package geiser-mit :ensure t :defer t)
(use-package geiser-chez :ensure t :defer t)
(use-package geiser-racket :ensure t :defer t)


;; Verilog ⚒️
(use-package verilog-mode
  :ensure t
  :hook ((verilog-mode . eglot-ensure))
  :mode ("\\.v\\'" "\\.sv\\'")
  :config
  (setq verilog-compiler "verilator")
  (setq verilog-tool verilog-compiler))


(message "loaded langs.el! :3")
(provide 'extra-langs)
;;; extra-langs.el ends here
