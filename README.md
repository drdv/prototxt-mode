# prototxt-mode for Emacs

`prototxt-mode` is a major mode for editing prototxt files (i.e., files
generated from `google::protobuf::TextFormat::PrintToString`).

# Installation:

Ensure that `prototxt-mode.el` is in a directory on your load-path, and add `(require 'prototxt-mode)`
to your `~/.emacs` or `~/.emacs.d/init.el`.

# Notes:

The default indentation level is 2 spaces, however, one could customize it by
placing the following in `~/.emacs` or `~/.emacs.d/init.el`:

	(add-hook 'prototxt-mode-hook
		(lambda()
		    (setq prototxt-mode-indentation-level 4)))  ;; use 4-space indentation
