(use-package simple-httpd :ensure t)
(use-package htmlize :ensure t)
(setq-default org-html-validation-link nil            ;; Don't show validation link
	      org-html-head-include-scripts nil       ;; Use our own scripts
	      org-html-head-include-default-style nil ;; Use our own styles
	      org-html-head "<link rel=\"stylesheet\" href=\"https://cdn.simplecss.org/simple.min.css\" />")

;; Org Static Blog
(use-package org-static-blog :ensure t :defer t
  :config
  (setq org-static-blog-publish-title "trannus aran's blog")
  (setq org-static-blog-publish-url "https://trannusaran.neocities.org/")
  (setq org-static-blog-publish-directory "~/org/public/blog/")
  (setq org-static-blog-posts-directory "~/org/public/blog/posts/")
  (setq org-static-blog-drafts-directory "~/org/public/blog/drafts/")
  (setq org-static-blog-enable-tags t)
  (setq org-export-with-toc nil)
  (setq org-export-with-section-numbers nil)

  ;; This header is inserted into the <head> section of every page:
  ;;   (you will need to create the style sheet at
  ;;    ~/www/trannusaran.neocities.org/static/style.css
  ;;    and the favicon at
  ;;    ~/www/trannusaran.neocities.org/static/favicon.ico)
  (setq org-static-blog-page-header
	"<meta name=\"author\" content=\"trannus aran\">
         <meta name=\"referrer\" content=\"no-referrer\">
         <meta name=\"viewport\" content=\"initial-scale=1,width=device-width,minimum-scale=1\">
         <link rel=\"stylesheet\" href=\"https://cdn.jsdelivr.net/npm/water.css@2/out/dark.css\">
         <link rel=\"icon\" href=\"static/favicon.ico\">")

  ;; This preamble is inserted at the beginning of the <body> of every page:
  ;;   This particular HTML creates a <div> with a simple linked headline
  (setq org-static-blog-page-preamble
	"<div class=\"header\">
           <a href=\"https://trannusaran.neocities.org\">home</a>
         </div>")

  ;; This postamble is inserted at the end of the <body> of every page:
  ;;   This particular HTML creates a <div> with a link to the archive page
  ;;   and a licensing stub.
  ;; (setq org-static-blog-page-postamble
  ;; 	"<div id=\"archive\">
  ;;          <a href=\"https://trannusaran.neocities.org/archive.html\">Other posts</a>
  ;;        </div>")

  ;; This HTML code is inserted into the index page between the preamble and
  ;;   the blog posts
  (setq org-static-blog-index-front-matter
	"<h1>trannusaran.neocities.org</h1>\n"))

(provide 'org-conf)
