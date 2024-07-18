;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(async-bytecomp-package-mode t)
 '(c-default-style
   '((c-mode . "linux")
     (java-mode . "java")
     (awk-mode . "awk")
     (other . "linux")))
 '(custom-safe-themes
   '("84b04a13facae7bf10f6f1e7b8526a83ca7ada36913d1a2d14902e35de4d146f" "c2c63381042e2e4686166d5d59a09118017b39003e58732b31737deeed454f1c" default))
 '(ediff-window-setup-function 'ediff-setup-windows-plain)
 '(inhibit-startup-screen t)
 '(ispell-dictionary nil)
 '(make-backup-files nil)
 '(menu-bar-mode nil)
 '(org-babel-load-languages '((shell . t) (emacs-lisp . t)))
 '(package-archives
   '(("melpa" . "https://melpa.org/packages/")
     ("nelpa" . "https://elpa.nongnu.org/nongnu/")
     ("gnu" . "https://elpa.gnu.org/packages/")))
 '(package-enable-at-startup nil)
 '(package-selected-packages
   '(ef-themes eglot consult embark org-re-reveal keycast dired-sidebar transpose-frame sideline-flymake sideline corfu-terminal quelpa-use-package cape corfu yaml-mode rust-mode go-mode meson-mode vala-mode zig-mode vterm magit embark-consult marginalia vertico orderless))
 '(safe-local-variable-values '((c-indent-level . 4)))
 '(treemacs-git-command-pipe "&>/dev/null; git status --porcelain")
 '(treemacs-space-between-root-nodes nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; use-package
(unless package-archive-contents (package-refresh-contents))
(unless (package-installed-p 'use-package) (package-install 'use-package))
(require 'use-package)

;; vertico
(use-package vertico
  :ensure t
  :config
  (vertico-mode)
  :custom
  (enable-recursive-minibuffers t)
  (minibuffer-depth-indicate-mode t))

;; orderless
(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file . (styles basic partial-completion)))))

;; marginalia
(use-package marginalia
  :ensure t
  :config
  (marginalia-mode))

;; embark
(use-package embark
  :ensure t
  :bind
  ("C-." . 'embark-act)
  ("M-." . 'embark-dwim)
  ("C-h B" . 'embark-bindings)
  :custom
  (prefix-help-command 'embark-prefix-help-command)
  (embark-indicators '(embark-highlight-indicator embark-isearch-highlight-indicator)))

;; corfu
(use-package corfu
  :ensure t
  :bind
  (:map corfu-map
	("TAB" . corfu-insert)
	("RET" . nil)
	("<tab>" . nil))
  :custom
  (corfu-auto t)
  (corfu-cycle t)
  (corfu-quit-no-match t)
  :config
  (global-corfu-mode))

;; corfu-terminal
(use-package corfu-terminal
  :ensure t
  :config
  (unless (display-graphic-p)
    (corfu-terminal-mode +1)))

;; consult
(use-package consult
  :ensure t
  :hook
  (completion-list-mode . consult-preview-at-point-mode)
  :bind
  ("C-c a b o" . 'consult-buffer-other-window)
  ("C-c a b b" . 'consult-buffer)
  ("C-c a b p" . 'consult-project-buffer)
  ("C-c a b g" . 'consult-org-heading)
  ("C-c a b a" . 'consult-org-agenda)
  ("C-c a b f" . 'consult-focus-lines)
  ("C-c a b s" . 'consult-line)
  ("C-c a c c" . 'consult-compile-error)
  ("C-c a c f" . 'consult-flymake)
  ("C-c a c g" . 'consult-goto-line)
  ("C-c a c a" . 'eglot-code-actions)
  ("C-c a c t" . 'vterm-other-window)
  ("C-c a f f" . 'consult-find)
  ("C-c a f g" . 'consult-grep)
  ("C-c a f v" . 'consult-git-grep)
  ("C-c a h i" . 'consult-info)
  ("C-c a h l" . 'consult-locate)
  ("C-c a h m" . 'consult-man)
  ("C-c a w t" . 'consult-theme)
  ("C-c a m g" . 'consult-global-mark)
  ("C-c a m k" . 'consult-yank-from-kill-ring)
  ("C-c a m m" . 'consult-mark)
  :custom
  (xref-show-xrefs-function 'consult-xref)
  (xref-show-definitions-function 'consult-xref)
  (completion-in-region-function 'consult-completion-in-region))

;; embark-consult
(use-package embark-consult
  :ensure t
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

;; transpose-frame
(use-package transpose-frame
  :ensure t
  :defer t
  :bind
  ("C-c a w r" . transpose-frame)
  ("C-c a w f" . flip-frame))

(use-package dired-sidebar
  :ensure t
  :defer t
  :bind
  ("C-c a f s" . dired-sidebar-toggle-sidebar))

;; keycast
(use-package keycast
  :ensure t
  :defer t
  :bind
  ("C-c a h k" . keycast-mode))

;; cape
(use-package cape
  :ensure t
  :config
  (add-to-list 'completion-at-point-functions 'cape-keyword)
  (add-to-list 'completion-at-point-functions 'cape-elisp-block)
  (add-to-list 'completion-at-point-functions 'cape-elisp-symbol)
  (add-to-list 'completion-at-point-functions 'cape-file)
  (add-to-list 'completion-at-point-functions 'cape-rfc1345)
  (add-to-list 'completion-at-point-functions 'cape-tex)
  (add-to-list 'completion-at-point-functions 'cape-sgml)
  (add-to-list 'completion-at-point-functions 'cape-dabbrev)
  (add-to-list 'completion-at-point-functions 'cape-abbrev)
  (add-to-list 'completion-at-point-functions 'cape-history)
  (add-to-list 'completion-at-point-functions 'cape-line)
  (add-to-list 'completion-at-point-functions 'cape-dict)
  (add-to-list 'completion-at-point-functions 'cape-emoji))

;; eglot
(use-package eglot
  :ensure t
  :hook
  (prog-mode . eglot-ensure))

;; magit
(use-package magit
  :ensure t
  :defer t)

;; vterm
(use-package vterm
  :ensure t
  :defer t)

;; zig-mode
(use-package zig-mode
  :ensure t
  :defer t)

;; vala-mode
(use-package vala-mode
  :ensure t
  :defer t)

;; meson-mode
(use-package meson-mode
  :ensure t
  :defer t)

;; go-mode
(use-package go-mode
  :ensure t
  :defer t)

;; rust-mode
(use-package rust-mode
  :ensure t
  :defer t)

;; yaml-mode
(use-package yaml-mode
  :ensure t
  :defer t)

;; org-re-reveal
(use-package org-re-reveal
  :ensure t
  :mode
  ("\\.org\\'" . (lambda () (progn (org-mode)(require 'org-re-reveal)))))

;; disable menubar, toolbar, scrollbar
(if (display-graphic-p) (progn (menu-bar-mode -1)(tool-bar-mode -1)(scroll-bar-mode -1)))

;; theme
(use-package ef-themes
  :config
  (load-theme 'ef-dark t))

;;font
(set-face-attribute 'default nil :font "Liberation Mono" :height 180)

;;buffer
(global-set-key [(meta shift j)] 'previous-buffer)
(global-set-key [(meta shift l)] 'next-buffer)
(global-set-key (kbd "C-x K") 'kill-this-buffer)

