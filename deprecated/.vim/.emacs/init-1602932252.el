(require 'package)
(setq package-archives
      '(("gnu" . "http://elpa.emacs-china.org/gnu/")
	("melpa" . "http://elpa.emacs-china.org/melpa/")
	("melpa-stable" . "http://elpa.emacs-china.org/melpa-stable/")
	("marmalade" . "http://elpa.emacs-china.org/marmalade/")
	("org" . "http://elpa.emacs-china.org/org/")
	("sunrise-commander-elpa" . "http://elpa.emacs-china.org/sunrise-commander/")
	("user42-elpa" . "http://elpa.emacs-china.org/user42/")))

(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)

(setq use-package-always-ensure t)

(use-package company
  :ensure t
  :init
  (global-company-mode 1))

(use-package ivy
  :init
  (ivy-mode 1))

(use-package evil
  :init
  (evil-mode 1)
  :config
  (evil-define-key 'normal emacs-lisp-mode-map (kbd "<return>") 'eval-defun))

(use-package evil-cleverparens
  :hook
  ((emacs-lisp-mode) . evil-cleverparens-mode))

(use-package dracula-theme)

(setq custom-file (expand-file-name
		   "custom.el"
		   user-emacs-directory))

(when (file-exists-p custom-file)
  (load-file custom-file))

(tool-bar-mode -1)

(when (display-graphic-p)
  (scroll-bar-mode -1))

(setq inhibit-startup-screen t)

;; coding
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
