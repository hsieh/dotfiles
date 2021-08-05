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

(let ((pkgs '(use-package quelpa-use-package)))
  (mapcar
   (lambda (pkg)
     (unless (package-installed-p pkg)
       (package-install pkg)))
   pkgs))

(require 'use-package)
(require 'quelpa-use-package)

(let ((d (expand-file-name "~/.emacs.d/quelpa/melpa/recipes")))
  (unless (file-exists-p d) 
    (make-directory d t)))

(quelpa-use-package-activate-advice)

(setq use-package-always-ensure t
      use-package-always-demand t
      quelpa-checkout-melpa-p nil
      quelpa-update-melpa-p nil)

(use-package company
  :init
  (global-company-mode 1)
  :custom
  (company-idle-delay 0.02))

(use-package company-posframe
  :hook (company-mode . company-posframe-mode)
  :custom
  (company-posframe-show-indicator nil)
  (company-posframe-show-metadata nil))

(setq enable-recursive-minibuffers t)

(use-package projectile
  :init
  (projectile-global-mode 1)
  :custom
  (projectile-completion-system 'default))



(use-package selectrum
  :init
  (selectrum-mode 1))

(use-package selectrum-prescient
  :init
  (selectrum-prescient-mode 1))
  
(global-set-key (kbd "<escape>") #'keyboard-quit)

(use-package smartparens
  :hook (prog-mode . smartparens-mode))

(use-package elixir-mode
  :bind
  (:map elixir-mode-map
   ("C-c C-f" . 'elixir-format)))

(use-package web-mode
  :mode (("\\.eex\\'" . web-mode)
	 ("\\.leex\\'" . web-mode)))

(require 'project)

(use-package magit)

(use-package inf-iex
  :hook (elixir-mode . inf-iex-minor-mode)
  :quelpa
  (inf-iex :fetcher github
	   :repo "DogLooksGood/inf-iex"))

(use-package eglot
  :hook (elixir-mode . eglot-ensure)
  :config
  (add-to-list 'eglot-server-programs '(elixir-mode "/home/yatung/.config/coc/extensions/node_modules/coc-elixir/els-release/language_server.sh")))

(use-package evil
  :init
  (evil-mode 1))

(use-package evil-leader
  :init
  (global-evil-leader-mode t)
  :config
  (evil-leader/set-leader "<SPC>")
  (evil-leader/set-key "e" 'find-file)
  (evil-leader/set-key "p" 'projectile-find-file)
  (evil-leader/set-key "g" 'projectile-ripgrep)
  (evil-leader/set-key "b" 'switch-to-buffer)


  (evil-leader/set-key-for-mode 'elixir-mode "cz" 'inf-iex-start)
  (evil-leader/set-key-for-mode 'elixir-mode "ck" 'inf-iex-reload)
  (evil-leader/set-key-for-mode 'elixir-mode "cl" 'inf-iex-compile)
  (evil-leader/set-key-for-mode 'elixir-mode "cc" 'inf-iex-eval)
  (evil-leader/set-key-for-mode 'elixir-mode "cn" 'inf-iex-eval-measure-time)
  (evil-leader/set-key-for-mode 'elixir-mode "cw" 'inf-iex-eval-with-binding)
  (evil-leader/set-key-for-mode 'elixir-mode "css" 'inf-iex-query-state-swarm)
  (evil-leader/set-key-for-mode 'elixir-mode "csc" 'inf-iex-query-state-common)
  (evil-leader/set-key-for-mode 'elixir-mode "cp" 'inf-iex-pry)
  (evil-leader/set-key-for-mode 'elixir-mode "ci" 'inf-iex-setup-context)
  (evil-leader/set-key-for-mode 'elixir-mode "cr" 'inf-iex-respawn-context))

(setq custom-file (expand-file-name "custom.el" "~/.emacs.d"))
(tool-bar-mode -1)
(menu-bar-mode -1)
(global-hl-line-mode 1)
(add-hook 'prog-mode-hook #'display-line-numbers-mode)

(tool-bar-mode -1)

(when (display-graphic-p)
  (scroll-bar-mode -1))

(setq inhibit-startup-screen t)
