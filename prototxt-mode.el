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
;; prototxt are the files generated from google::protobuf::TextFormat::ParseFromString
;; For more information see google/protobuf/text_format.h
;;
;; Note that this mode inherits from `perl-mode', hence one could
;; customize the indentation level by placing the following in .emacs:
;;
;; (add-hook 'prototxt-mode-hook
;;	  (lambda()
;;	    (setq perl-indent-level 2)))  ;; use 2-space indentation
;;
;; I have found it useful to use `hs-minor-mode' for code folding:
;;
;; (add-hook 'prototxt-mode-hook
;;	  (lambda()
;;	    (local-set-key (kbd "C-c <right>") 'hs-show-block)
;;	    (local-set-key (kbd "C-c <left>" ) 'hs-hide-block)
;;	    (local-set-key (kbd "C-c <up>"   ) 'hs-hide-level)
;;	    (local-set-key (kbd "C-c <down>" ) 'hs-show-all)
;;	    (hs-minor-mode 1)))

;; Quick start:
;;
;; add (require 'prototxt-mode) to your .emacs

;;; Code:

(defvar prototxt-mode-font-lock-keywords
  '(("\\(.*\\)\s*{" . (1 font-lock-function-name-face))
    ("^\s*.+:" . (0 font-lock-variable-name-face))
    (":\s*\\(.*\\)" . (1 font-lock-type-face))))

(defvar prototxt-mode-font-lock-syntax-table
  (let ((st (make-syntax-table)))
    (modify-syntax-entry ?#  "< b" st)
    (modify-syntax-entry ?\n ">#b" st)
    st)
  "Syntax table for `prototxt-mode'.")

;;;###autoload
;; we could inherit from json-mode instead of perl-mode but I don't like the
;; default indentation of comments in json-mode
(define-derived-mode prototxt-mode perl-mode "prototxt" ;; reuse indentation
  (setq font-lock-defaults '(prototxt-mode-font-lock-keywords))
  (set (make-local-variable 'comment-start) "#") ;; required to use M-;
  (set-syntax-table prototxt-mode-font-lock-syntax-table))

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.prototxt\\'" . prototxt-mode))

(provide 'prototxt-mode)

;;; prototxt-mode.el ends here
