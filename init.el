;; -*- lexical-binding: t; -*-

;; customize ui
(when (display-graphic-p)
  (tool-bar-mode 0)
  (scroll-bar-mode 0))
(setq inhibit-startup-screen 1)
(setq ring-bell-function 'ignore)

;; set window size
(setq initial-frame-alist '((top . 0) (left . 0) (width . 120) (height . 80)))

;; dark theme
(load-theme 'wombat)
(set-face-background 'default "#111")

;; line numbers
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

;; enable fido
(fido-mode)

;; expandtab
(setq-default indent-tabs-mode nil)

;; highlight parens
(setq show-paren-delay 0)
(show-paren-mode)

;; set customizations file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file t)

;; enable package installation from MELPA
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; install packages
(dolist (package '(paredit rainbow-delimiters auto-complete cider))
  (unless (package-installed-p package)
    (package-install package)))

;; enable paredit
(add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook 'enable-paredit-mode)
(add-hook 'ielm-mode-hook 'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook 'enable-paredit-mode)
(add-hook 'lisp-mode-hook 'enable-paredit-mode)

;; enable rainbow delimiters
(add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode)
(add-hook 'ielm-mode-hook 'rainbow-delimiters-mode)
(add-hook 'lisp-interaction-mode-hook 'enable-paredit-mode)
(add-hook 'lisp-mode-hook 'rainbow-delimiters-mode)

;; customize rainbow delimiters
(require 'rainbow-delimiters)
(set-face-foreground 'rainbow-delimiters-depth-1-face "#c66") ; red
(set-face-foreground 'rainbow-delimiters-depth-2-face "#6c6") ; green
(set-face-foreground 'rainbow-delimiters-depth-3-face "#69f") ; blue
(set-face-foreground 'rainbow-delimiters-depth-4-face "#cc6") ; yellow
(set-face-foreground 'rainbow-delimiters-depth-5-face "#6cc") ; cyan
(set-face-foreground 'rainbow-delimiters-depth-6-face "#c6c") ; magenta
(set-face-foreground 'rainbow-delimiters-depth-7-face "#ccc") ; light gray
(set-face-foreground 'rainbow-delimiters-depth-8-face "#999") ; mediuam gray
(set-face-foreground 'rainbow-delimiters-depth-9-face "#666") ; dark gray

;; cider specifics
(add-hook 'cider-repl-mode-hook 'rainbow-delimiters-mode)
(add-hook 'cider-mode-hook 'paredit-mode)

;; configure auto-complete
(global-auto-complete-mode t)
(define-key ac-complete-mode-map "\t" 'ac-expand)

(provide 'init)
