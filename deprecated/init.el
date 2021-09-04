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

(use-package command-log-mode)
(use-package swiper)

(use-package ivy
  :diminish
  :bind (("C-S-s" . swiper)
	 :map ivy-minibuffer-map
	 ("TAB" . ivy-alt-done)
	 ("C-j". ivy-next-line)
	 ("C-k". ivy-previous-line)
	 :map ivy-switch-buffer-map
	 ("C-l" . ivy-done)
	 ("C-j" . ivy-next-line)
	 ("C-k" . ivy-previous-line)
	 ("C-d" . ivy-switch-buffer-kill)
	 :map ivy-reverse-i-search-map
	 ("C-k" . ivy-previous-line)
	 ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1)
  (use-package undo-tree
    :config
    (global-undo-tree-mode 1)
    (evil-set-undo-system 'undo-tree))
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-define-key 'normal emacs-lisp-mode-map (kbd "<return>") 'eval-defun))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package evil-cleverparens
  :hook
  ((emacs-lisp-mode) . evil-cleverparens-mode))

(use-package evil-terminal-cursor-changer
  :init
  (evil-terminal-cursor-changer-activate))

(use-package project
  :pin melpa)

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.3))

(use-package pyim
  :defer t
  :config
  (progn
    (use-package pyim-basedict
      :config
      (pyim-basedict-enable))
    (pyim-default-scheme 'microsoft-shuangpin)
    (pyim-isearch-mode -1)
    (setq pyim-page-style 'one-line)
    (setq ivy-re-builders-alist
	  '((t . pyim-cregexp-ivy)))
    (setq pyim-page-length 5)
    (use-package posframe
      :config
      (if (posframe-workable-p)
	  (setq pyim-page-tooltip 'posframe)
	(setq pyim-page-tooltip 'popup)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; theme setting
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (use-package plan9-theme
;;   :config
;;   (load-theme 'plan9 t))

(use-package acme-theme
  :config
  (load-theme 'acme t))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Oberon mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package oberon
  :config
  (add-to-list 'auto-mode-alist '("\\.Mod\\'" . oberon-mode))
  (autoload 'oberon-mode "oberon" nil t)
  (add-hook 'oberon-mode-hook (lambda () (abbrev-mode t))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Erlang mode for Emacs
;; (setq load-path (cons "/usr/local/lib/erlang/lib/tools-3.5/emacs" load-path))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package erlang
  :config
  (setq erlang-root-dir "/usr/local/lib/erlang")
  (setq exec-path (cons "/usr/local/bin" exec-path))
  (require 'erlang-start))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Line number settings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(column-number-mode 1)

(dolist (mode '(org-mode-hook
		term-mode-hook
		eshell-mode-hook
		command-log-mode-hook
		undo-tree-mode-hook))
  (add-hook mode (lambda ()
		   (display-line-numbers-mode -1))))

(dolist (mode '(text-mode-hook
		prog-mode-hook
		conf-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 1))))

;; 
;; (global-display-line-numbers-mode 1)
;; (add-hook 'command-log-mode-hook
;; 	  (lambda ()
;; 	    (if (equal (buffer-name) "*command-log*")
;; 		(display-line-numbers-mode -1))))
;; (dolist (mode '(org-mode-hook
;;                 term-mode-hook
;;                 eshell-mode-hook
;;                 buffer-menu-mode-hook
;;                 undo-tree-visualizer-mode-hook))
;;    (add-hook mode (lambda () (display-line-numbers-mode -1))))
;;  

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Other settings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq custom-file (expand-file-name
		   "custom.el"
		   user-emacs-directory))

(when (file-exists-p custom-file)
  (load-file custom-file))

(menu-bar-mode -1) ;; disable visible menu bar

(setq visible-bell nil)

(when (display-graphic-p)
  (scroll-bar-mode -1)
  (tool-bar-mode -1)
  (tooltip-mode -1)
  (set-fringe-mode 8) ;; gaps

  (defun text-scale-default ()
    (interactive)
    (text-scale-set 0))

  (global-set-key  (kbd "C-+") 'text-scale-increase)
  (global-set-key  (kbd "C-=") 'text-scale-decrease)
  (global-set-key  (kbd "C-M-=") 'text-scale-default))

(setq inhibit-startup-screen t)

;; coding
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
