(defun hello ()
  (interactive)
  (princ "hello! :3"))

(defun zen ()
  (interactive)
  (if (or tool-bar-mode menu-bar-mode)
      (progn ;; (tool-bar-mode 0)
	     (menu-bar-mode 0))
    (progn ;; (tool-bar-mode 1)
	   (menu-bar-mode 1))))

(provide 'hello)
