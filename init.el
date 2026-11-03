;; -*- lexical-binding: t; -*-

;; customize ui
(when (display-graphic-p)
  (tool-bar-mode 0)
  (scroll-bar-mode 0))
(setq inhibit-startup-screen 1)

;; set window size
(setq initial-frame-alist '((top . 0) (left . 0) (width . 120) (height . 80)))

;; dark theme
(load-theme 'wombat)
(set-face-background 'default "#111")

;; line numbers
(global-display-line-numbers-mode)

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
(dolist (package '(slime paredit rainbow-delimiters))
  (unless (package-installed-p package)
    (package-install package)))

;; configure SBCL as the Lisp program for SLIME
(setq inferior-lisp-program "sbcl")

;; enable paredit
(add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook 'enable-paredit-mode)
(add-hook 'ielm-mode-hook 'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook 'enable-paredit-mode)
(add-hook 'lisp-mode-hook 'enable-paredit-mode)
(add-hook 'slime-repl-mode-hook 'enable-paredit-mode)
(require 'paredit)
(defun override-slime-del-key ()
  (define-key slime-repl-mode-map
              (read-kbd-macro paredit-backward-delete-key) nil))
(add-hook 'slime-repl-mode-hook 'override-slime-del-key)

;; enable rainbow delimiters
(add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode)
(add-hook 'ielm-mode-hook 'rainbow-delimiters-mode)
(add-hook 'lisp-interaction-mode-hook 'enable-paredit-mode)
(add-hook 'lisp-mode-hook 'rainbow-delimiters-mode)
(add-hook 'slim-repl-mode-hook 'rainbow-delimiters-mode)

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

;; open slime on the right
(add-to-list 'display-buffer-alist
             '("\\*slime-repl.*\\*"
               (display-buffer-in-side-window)
               (side . right)
               (slot . 0)
               (window-width . 0.4)))

(provide 'init)
