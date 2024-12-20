(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("gnu" . "https://elpa.gnu.org/packages/")))

(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)

(require 'use-package)
(setq use-package-always-ensure t)
(package-refresh-contents)
(package-install 'doom-themes)

(unless (package-installed-p 'hydra)
  (package-refresh-contents)
  (package-install 'hydra))

(load-theme 'gruber-darker t)

(global-set-key (kbd "C-c b") 'load-themes/body)

(set-fringe-mode 15)
(electric-indent-mode 1)
(column-number-mode t)
(global-display-line-numbers-mode t)
(global-hl-line-mode t)
(global-visual-line-mode t)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(tooltip-mode -1)
(menu-bar-mode 0)

(setq inhibit-startup-message t)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

(setq auto-mode-alist (append '(("\\.scm$" . scheme-mode)) auto-mode-alist))
(setq auto-mode-alist (append '(("\\.lisp$" . lisp-mode)) auto-mode-alist))
(add-to-list 'auto-mode-alist '("\\.el\\'" . emacs-lisp-mode))

(load-file "~/.emacs.d/modes/haskell-mode.el")
(load-file "~/.emacs.d/modes/c-mode.el")
(load-file "~/.emacs.d/modes/asm-mode.el")
(load-file "~/.emacs.d/slime/config.el")

(use-package all-the-icons
  :ensure t)

(defun open-dired ()
  
  (interactive)
  (dired default-directory))

(defun my-eshell-split-window ()
  
  (interactive)
  (split-window-below)         
  (other-window 1)             
  (eshell))                    

(global-set-key (kbd "C-c f") 'open-dired)
(global-set-key (kbd "C-c q") 'save-buffers-kill-emacs)

(global-set-key (kbd "C-c s") 'my-eshell-split-window) 

(defun move-line-up ()
  (interactive)
  (transpose-lines 1)
  (forward-line -2))

(defun move-line-down ()
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1))

(global-set-key (kbd "M-<up>") 'move-line-up) ;; Alt + ↑
(global-set-key (kbd "M-<down>") 'move-line-down) ;; Alt + ↓

(use-package vertico
  :init
  (vertico-mode))

(dolist (package '(slime paredit rainbow-delimiters))
  (unless (package-installed-p package)
    (package-install package)))

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

(add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode)
(add-hook 'ielm-mode-hook 'rainbow-delimiters-mode)
(add-hook 'lisp-interaction-mode-hook 'rainbow-delimiters-mode)
(add-hook 'lisp-mode-hook 'rainbow-delimiters-mode)
(add-hook 'slime-repl-mode-hook 'rainbow-delimiters-mode)

(require 'rainbow-delimiters)
(set-face-foreground 'rainbow-delimiters-depth-1-face "#c66")  ; red
(set-face-foreground 'rainbow-delimiters-depth-2-face "#6c6")  ; green
(set-face-foreground 'rainbow-delimiters-depth-3-face "#69f")  ; blue
(set-face-foreground 'rainbow-delimiters-depth-4-face "#cc6")  ; yellow
(set-face-foreground 'rainbow-delimiters-depth-5-face "#6cc")  ; cyan
(set-face-foreground 'rainbow-delimiters-depth-6-face "#c6c")  ; magenta
(set-face-foreground 'rainbow-delimiters-depth-7-face "#ccc")  ; light gray
(set-face-foreground 'rainbow-delimiters-depth-8-face "#999")  ; medium gray
(set-face-foreground 'rainbow-delimiters-depth-9-face "#666")  ; dark gray

(use-package vertico-posframe
  :after vertico
  :custom
  (vertico-posframe-parameters
   '((left-fringe . 8)
     (right-fringe . 8)))
  :config
  (vertico-posframe-mode 1))

(ac-config-default)
(global-auto-complete-mode t)
(use-package lsp-mode
  :init
  (setq lsp-keymap-prefix "C-c l")
  :hook ((python-mode . lsp))
  :commands lsp)

(use-package lsp-ui
  :commands lsp-ui-mode)

(use-package lsp-pyright
  :after lsp-mode
  :hook (python-mode . (lambda ()
                         (require 'lsp-pyright)
                         (lsp))))



;;; This will enable emacs to compile a simple cpp single file without any makefile by just pressing [f9] key
(defun code-compile()
  (interactive)
  (unless (file-exists-p "Makefile")
    (set (make-local-variable 'compile-command)
	 (let ((file (file-name-nondirectory buffer-file-name)))
	   (format "%s -o %s %s"
		   (if (equal (file-name-extension file) "cpp") "g++" "gcc")
		   (file-name-sans-extension file)
		   file)))
    (compile compile-command)))
(global-set-key [f9] 'code-compile)


(global-set-key (kbd "C-c C-e") 'eval-last-sexp)
(global-set-key (kbd "C-c C-r") 'eval-region)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(ac-haskell-process auto-complete haskell-mode markdown-mode gruber-darker-theme gams-ac gams-mode ghc-imported-from ghci-completion github-dark-vscode-theme gruvbox-theme lsp-pyright lsp-ui lsp-mode vertico-posframe vertico treemacs all-the-icons doom-themes hydra)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
