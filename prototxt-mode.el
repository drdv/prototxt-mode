;;; prototxt-mode.el --- Major mode for editing prototxt files

;; Copyright (C) 2018 Dimitar Dimitrov

;; Author: Dimitar Dimitrov <mail.mitko@gmail.com>
;; URL: https://github.com/drdv/prototxt-mode
;; Package-Version: 20180428.1
;; Package-X-Original-Version: 20180428.1
;; Package-Requires: ((emacs "24.3"))
;; Keywords: convenience, usability

;; This file is not part of GNU Emacs.

;;; License:

;; Licensed under the same terms as Emacs.

;;; Commentary:

;; Package tested on:
;; GNU Emacs 25.3.1 (x86_64-apple-darwin17.0.0)
;;
;; prototxt are the files generated from google::protobuf::TextFormat::PrintToString
;; For more information see google/protobuf/text_format.h
;;
;; The default indentation is 2 spaces, however, one could customize the
;; indentation level by placing the following in .emacs:
;;
;; (add-hook 'prototxt-mode-hook
;;	  (lambda()
;;	    (setq prototxt-mode-indentation-level 4))) ;; use 4-space indentation
;;
;; I have found it useful to use `hs-minor-mode' for code folding:
;;
;; (add-hook 'prototxt-mode-hook
;;	  (lambda()
;;	    (local-set-key (kbd "C-c <right>") 'hs-show-block)
;;	    (local-set-key (kbd "C-c <left>" ) 'hs-hide-block)
;;	    (local-set-key (kbd "C-c <up>"   ) 'hs-hide-level)
;;	    (local-set-key (kbd "C-c <down>" ) 'hs-show-all)
;;	    (local-set-key (kbd "C-c c" ) 'hs-hide-all-comments)
;;	    (hs-minor-mode 1)))
;;
;; hs-hide-all-comments: https://www.emacswiki.org/emacs/HideShow

;; Quick start:
;;
;; add (require 'prototxt-mode) to your .emacs

;;; Code:

(defvar prototxt-mode-font-lock-keywords
  (list
   ;; message
   '("\\(.*\\)\s*{" . (1 font-lock-function-name-face))
   ;; key
   '("\\(^\s*.*?\\):" . (0 font-lock-variable-name-face))
   ;; value
   '(":\s*\\(.*\\)" . (1 font-lock-type-face))))

(defvar prototxt-mode-font-lock-syntax-table
  (let ((st (make-syntax-table)))
    (modify-syntax-entry ?# "<" st)
    (modify-syntax-entry ?\n ">" st)
    st)
  "Syntax table for `prototxt-mode'.")

(defvar prototxt-mode-indentation-level 2
  "Specify the indentation level (default: 2).")

(defun prototxt-mode-indent-line ()
  "Indent the current line according to depth of parentheses."
  (interactive)
  (let ((parse-status
	 (save-excursion (syntax-ppss (point-at-bol)))))
    (indent-line-to (* prototxt-mode-indentation-level
		       (nth 0 parse-status)))))

;;;###autoload
(define-derived-mode prototxt-mode fundamental-mode "prototxt"
  (setq font-lock-defaults '(prototxt-mode-font-lock-keywords))
  (setq indent-line-function 'prototxt-mode-indent-line)
  (set (make-local-variable 'comment-start) "#") ;; required to use M-;
  (set-syntax-table prototxt-mode-font-lock-syntax-table))

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.prototxt\\'" . prototxt-mode))

(provide 'prototxt-mode)

;;; prototxt-mode.el ends here
