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

(use-package all-the-icons
  :ensure t)

(defun open-dired ()
  
  (interactive)
  (dired default-directory))


(define-prefix-command 'my-leader-map)
(global-set-key (kbd "\\") 'my-leader-map)
(define-key my-leader-map (kbd "a a") 'set-mark-command) ;; Shortcut to select multiple lines (C-c C-a)
(define-key my-leader-map (kbd "v v") 'yank) ;; Shortcut to paste (C-c C-v)
(define-key my-leader-map (kbd "k k") 'save-buffer) ;; Shortcut to save (C-c C-s) 
(define-key my-leader-map (kbd "e e") 'open-dired) ;; Leader \ e e for open file explorer

(define-key my-leader-map (kbd "f f") 'treemacs)     
(define-key my-leader-map (kbd "b b") 'switch-to-buffer) 
(define-key my-leader-map (kbd "w s") 'eshell) 

(define-key my-leader-map (kbd "e n") 'dired-create-empty-file) ;; \ e n to create a new file
(define-key my-leader-map (kbd "e d") 'dired-create-directory) ;; \ e d to create a new directory

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
