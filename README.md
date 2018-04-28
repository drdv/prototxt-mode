# prototxt-mode for Emacs

`prototxt-mode` is a major mode for editing prototxt files (i.e., files
generated from google::protobuf::TextFormat::ParseFromString).

# Installation:

Ensure that `prototxt-mode.el` is in a directory on your load-path, and add `(require 'prototxt-mode)`
to your `~/.emacs` or `~/.emacs.d/init.el`.

# Notes:

Note that this mode inherits from `perl-mode`, hence one could customize the
indentation level by placing the following in `~/.emacs` or
`~/.emacs.d/init.el`:

	(add-hook 'prototxt-mode-hook
		(lambda()
			(setq perl-indent-level 2)))  ;; use 2-space indentation
