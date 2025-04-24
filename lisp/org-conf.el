;;; org-conf --- My org mode configuration (incl. static blogging) -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:
(use-package org
  :config
  (setq-default org-capture-templates
	'(("t" "Todo" entry (file+headline "~/org/todo.org" "Tasks")
	   "* TODO %?\n  %i\n  %a")
	  ("j" "Journal" entry (file+olp+datetree "~/org/journal.org")
	   "* %?\nEntered on %U\n  %i\n  %a"))))

(use-package simple-httpd :ensure t)
(use-package htmlize :ensure t)
(setq-default org-html-validation-link nil            ;; Don't show validation link
	      org-html-head-include-scripts nil       ;; Use our own scripts
	      org-html-head-include-default-style nil ;; Use our own styles
	      org-html-head "<link rel=\"stylesheet\" href=\"https://cdn.simplecss.org/simple.min.css\" />")

;; Org Static Blog
(use-package org-static-blog :ensure t :defer t
  :config
  (setq org-static-blog-publish-title "deathto.vc"
	org-static-blog-publish-url "https://staging.deathto.vc/"
	org-static-blog-publish-directory "~/org/public/blog"
	org-static-blog-posts-directory "~/org/public/blog/posts"
	org-static-blog-drafts-directory "~/org/public/blog/drafts"
	org-static-blog-enable-tags t
	org-export-with-toc nil
	org-export-with-section-numbers nil
	org-static-blog-page-header
	"<meta name=\"author\" content=\"deathto.vc\">
         <meta name=\"viewport\" content=\"initial-scale=1,width=device-width,minimum-scale=1\">
         <link rel=\"stylesheet\" href=\"https://cdn.simplecss.org/simple.min.css\" />
         <link rel=\"icon\" href=\"static/favicon.png\">")

  ;; This preamble is inserted at the beginning of the <body> of every page:
  ;;   This particular HTML creates a <nav> with a simple linked headline
  (setq org-static-blog-page-preamble
	"<nav class=\"header\">
           <a href=\"https://staging.deathto.vc\">home</a>
         </nav>")

  ;; This postamble is inserted at the end of the <body> of every page:
  ;;   This particular HTML creates a <nav> with a link to the archive page
  ;;   and a licensing stub.
  (setq org-static-blog-page-postamble
	"<nav id=\"archive\">
           <a href=\"https://staging.deathto.vc/archive.html\">other posts</a>
         </nav>")

  ;; This HTML code is inserted into the index page between the preamble and
  ;;   the blog posts
  ;; (setq org-static-blog-index-front-matter
  ;; 	"<h1>staging.deathto.vc</h1>\n"))
  )
(provide 'org-conf)
;;; org-conf.el ends here

