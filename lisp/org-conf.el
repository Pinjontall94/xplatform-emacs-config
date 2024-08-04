(use-package simple-httpd :ensure t)
(use-package htmlize :ensure t)
(setq-default org-html-validation-link nil            ;; Don't show validation link
	      org-html-head-include-scripts nil       ;; Use our own scripts
	      org-html-head-include-default-style nil ;; Use our own styles
	      org-html-head "<link rel=\"stylesheet\" href=\"https://cdn.simplecss.org/simple.min.css\" />")
(provide 'org-conf)
