

;;;;;;;;;;;;;;;;;;;;;;;
;;  Package Configs  ;;
;;;;;;;;;;;;;;;;;;;;;;;

(require 'package)
(setq package-enable-at-startup nil)
(setq package-archives '(("org"   . "http://orgmode.org/elpa/")
                         ("gnu"   . "http://elpa.gnu.org/packages/")
                         ("melpa" . "http://melpa.org/packages/")))

(package-initialize)

;; Bootstrap `use-package`
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

;;;;;;;;;;;;;;;;;;;;;;;
;;    Preferences    ;;
;;;;;;;;;;;;;;;;;;;;;;;

;; Disable newline automatically added at end of file
(setq mode-require-final-newline nil)

;; Show Matching Parentheses
(setq show-paren-delay 0)
(show-paren-mode  1)

;; Splash Screen
;;(setq inhibit-startup-screen t)
;;(setq initial-scratch-message ";; ( ͡° ͜ʖ ͡°)")

;; UI Configurations
;;(scroll-bar-mode -1)
;;(horizontal-scroll-bar-mode -1)
;;(tool-bar-mode   -1)
;;(tooltip-mode    -1)
;;(menu-bar-mode   -1)
(global-linum-mode t)
(setq linum-format " %d ") ;; Fix clipping issue
(set-face-attribute 'default nil
  :family "Iosevka"
  :height 120)
;;(blink-cursor-mode 0)
(set-default 'cursor-type 'box)
(global-hl-line-mode t)


(setq-default
 ring-bell-function 'ignore
 visible-bell nil
 ;; Disable backups and autosaves
 make-backup-files nil
 auto-save-default nil
 ;; 4 spaces instead of tabs
 indent-tabs-mode nil
 tab-width 4
 tab-stop-list (quote (4 8))
 tab-always-indent 'complete
 ;; Split windows vertically by default.
 split-width-threshold 0
 split-height-threshold nil)

;; Theme
(use-package doom-themes
  :ensure t
  :config
  (load-theme 'doom-one t))

;; https://gist.github.com/huytd/6b785bdaeb595401d69adc7797e5c22c
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#212121" :foreground "#eeffff" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 110 :width normal :foundry "nil" :family "Iosevka"))))
 '(font-lock-constant-face ((t (:foreground "#C792EA"))))
 '(font-lock-keyword-face ((t (:foreground "#2BA3FF" :slant italic))))
 '(font-lock-preprocessor-face ((t (:inherit bold :foreground "#2BA3FF" :slant italic :weight normal))))
 '(font-lock-string-face ((t (:foreground "#C3E88D"))))
 '(font-lock-type-face ((t (:foreground "#FFCB6B"))))
 '(font-lock-variable-name-face ((t (:foreground "#FF5370"))))
 '(helm-rg-active-arg-face ((t (:foreground "LightGreen"))))
 '(helm-rg-file-match-face ((t (:foreground "LightGreen" :underline t))))
 '(helm-rg-preview-line-highlight ((t (:background "LightGreen" :foreground "black"))))
 '(mode-line ((t (:background "#191919" :box nil))))
 '(mode-line-inactive ((t (:background "#282828" :foreground "#5B6268" :box nil))))
 '(term ((t (:foreground "#fafafa")))))

;; Lighter "ocean" theme
;;(use-package toxi-theme
;;  :ensure t
;;  :config
;;  (load-theme 'toxi-theme t))

;; Darker "ocean" theme
;;(use-package gotham-theme
;;  :ensure t
;;  :config
;;  (load-theme 'gotham-theme t))

;; Randy's recommendation - Darker theme
;;(use-package challenger-deep
;;  :ensure t
;;  :config
;;  (load-theme 'challenger-deep t))

;;;;;;;;;;;;;;;;;;;;;;;
;;    Keybindings    ;;
;;;;;;;;;;;;;;;;;;;;;;;

;; Easy config management
(defun edit-config()
  (interactive)
  (find-file "~/.emacs.d/init.el"))
(defun reload-config()
  (interactive)
  (load-file "~/.emacs.d/init.el"))

;; Copy the current line and paste it on a new line
(global-set-key (kbd "C-c C-v") 'duplicate-line)
(defun duplicate-line ()
  (interactive)
  (kill-whole-line)
  (yank)
  (yank)
  (previous-line))

;; Find file in another window -- TODO: Improve
(global-set-key (kbd "C-'") 'find-file-other-window)
(defun find-file-other-window ()
  (interactive)
  ;;(if (one-window-p nil)
  ;;    (split-window-right)
  ;;  (delete-other-windows)
  ;;(other-window 1)
  (find-file-other-window))

;;;;;;;;;;;;;;;;;;;;;;;
;;   Optimizations   ;;
;;;;;;;;;;;;;;;;;;;;;;;

(setq-default
 bidi-display-reordering nil
 jit-lock-defer-time nil
 jit-lock-stealth-nice 0.1
 jit-lock-stealth-time 0.2
 jit-lock-stealth-verbose nil
 mode-line-default-help-echo nil) ;; Disable mode-line hover tips

;; http://bling.github.io/blog/2016/01/18/why-are-you-changing-gc-cons-threshold/
(defun my-minibuffer-setup-hook ()
  (setq gc-cons-threshold most-positive-fixnum))

(defun my-minibuffer-exit-hook ()
  (setq gc-cons-threshold 800000))

(add-hook 'minibuffer-setup-hook #'my-minibuffer-setup-hook)
(add-hook 'minibuffer-exit-hook #'my-minibuffer-exit-hook)

;;;;;;;;;;;;;;;;;;;;;;
;;     Template     ;;
;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;
;;      Unused      ;;
;;;;;;;;;;;;;;;;;;;;;;

;; Fancy titlebar for MacOS
;; (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
;; (add-to-list 'default-frame-alist '(ns-appearance . dark))
;; (setq ns-use-proxy-icon  nil)
;; (setq frame-title-format nil)

;;;;;;;;;;;;;;;;;;;;;;;
;;   Stuff To Sort   ;;
;;;;;;;;;;;;;;;;;;;;;;;

;; OrgMode Configs
(setq org-html-validation-link nil)
(setq org-todo-keywords
      '((sequence "TODO" "WORKING" "HOLD" "|" "DONE" "FIXME")))
(setq org-todo-keyword-faces
   '(("TODO"  . "blue")
   ("WORKING" . "yellow")
   ("HOLD"    . "red")
   ("DONE"    . "green")
   ("FIXME"   . "orange")))

;; Anzu - Search Matching
(use-package anzu
  :ensure t
  :config
  (global-anzu-mode 1)
  (global-set-key [remap query-replace-regexp] 'anzu-query-replace-regexp)
  (global-set-key [remap query-replace] 'anzu-query-replace))

;; Helm - (Ivy is "better")
;; use ivy mofo
(use-package helm
  :ensure t
  :init
  (setq helm-M-x-fuzzy-match t
	helm-mode-fuzzy-match t
	helm-buffers-fuzzy-matching t
	helm-recentf-fuzzy-match t
	helm-locate-fuzzy-match t
	helm-semantic-fuzzy-match t
	helm-imenu-fuzzy-match t
	helm-completion-in-region-fuzzy-match t
	helm-candidate-number-list 80
	helm-split-window-in-side-p t
	helm-move-to-line-cycle-in-source t
	helm-echo-input-in-header-line t
	helm-autoresize-max-height 0
	helm-autoresize-min-height 20)
  :config
  (helm-mode 1))

;; RipGrep - Search Tool
(use-package helm-rg :ensure t)

;; Projectile - Project Interaction
(use-package projectile
  :ensure t
  :init
  (setq projectile-require-project-root nil)
  :config
  (projectile-mode 1))

;; Helm Projectile
(use-package helm-projectile
  :ensure t
  :init
  (setq helm-projectile-fuzzy-match t)
  :config
  (helm-projectile-on))

;; All The Icons - Icon and Font Collection
(use-package all-the-icons :ensure t)

;; NeoTree - Filepath Sidebar
(use-package neotree
  :ensure t
  :init
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow)))
(global-set-key [f8] 'neotree-toggle)

;; Which Key - Command assist
(use-package which-key
  :ensure t
  :init
  (setq which-key-separator " ")
  (setq which-key-prefix-prefix "+")
  :config
  (which-key-mode))

;; ;; Custom keybinding
;; (use-package general
;;   :ensure t
;;   :config (general-define-key
;;   :states '(normal visual insert emacs)
;;   :prefix "SPC"
;;   :non-normal-prefix "M-SPC"
;;   "/"   '(helm-projectile-rg :which-key "ripgrep")
;;   "TAB" '(switch-to-prev-buffer :which-key "previous buffer")
;;   "SPC" '(helm-M-x :which-key "M-x")
;;   "pf"  '(helm-projectile-find-file :which-key "find files")
;;   "pp"  '(helm-projectile-switch-project :which-key "switch project")
;;   "pb"  '(helm-projectile-switch-to-buffer :which-key "switch buffer")
;;   "pr"  '(helm-show-kill-ring :which-key "show kill ring")
;;   ;; Buffers
;;   "bb"  '(helm-mini :which-key "buffers list")
;;   ;; Window
;;   "wl"  '(windmove-right :which-key "move right")
;;   "wh"  '(windmove-left :which-key "move left")
;;   "wk"  '(windmove-up :which-key "move up")
;;   "wj"  '(windmove-down :which-key "move bottom")
;;   "w/"  '(split-window-right :which-key "split right")
;;   "w-"  '(split-window-below :which-key "split bottom")
;;   "wx"  '(delete-window :which-key "delete window")
;;   "qz"  '(delete-frame :which-key "delete frame")
;;   "qq"  '(kill-emacs :which-key "quit")
;;   ;; NeoTree
;;   "ft"  '(neotree-toggle :which-key "toggle neotree")
;;   ;; Others
;;   "at"  '(ansi-term :which-key "open terminal")
;; ))

 

;; LSP - ???
(use-package lsp-mode
  :ensure t
  :init
  (add-hook 'prog-major-mode #'lsp-prog-major-mode-enable))

;; (use-package lsp-ui
;;  :ensure t
;;  :init
;;  (add-hook 'lsp-mode-hook 'lsp-ui-mode))

;; Powerline - Pretty modeline
(use-package spaceline
  :ensure t
  :init
  (setq powerline-default-separator 'slant)
  :config
  (spaceline-emacs-theme)
  (spaceline-toggle-minor-modes-off)
  (spaceline-toggle-buffer-size-off))


;;;;;;;;;;;;;;;;;;;;;;;
;; Language Supports ;;
;;;;;;;;;;;;;;;;;;;;;;;

;; Coding systems
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)

;; Yasnippet - Template system (abbreviation into function template)
(use-package yasnippet
  :ensure t)
(use-package yasnippet-snippets :ensure t)

;; FlyCheck - Syntax checking
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

;; Company - Text completion
(use-package company
:ensure t
:init
(setq company-minimum-prefix-length 3)
(setq company-auto-complete nil)
(setq company-idle-delay 0)
(setq company-require-match 'never)
(setq company-frontends
  '(company-pseudo-tooltip-unless-just-one-frontend
    company-preview-frontend
    company-echo-metadata-frontend))
(setq tab-always-indent 'complete)
(defvar completion-at-point-functions-saved nil)
:config
(global-company-mode 1)
(define-key company-active-map (kbd "TAB") 'company-complete-common-or-cycle)
(define-key company-active-map (kbd "<tab>") 'company-complete-common-or-cycle)
(define-key company-active-map (kbd "S-TAB") 'company-select-previous)
(define-key company-active-map (kbd "<backtab>") 'company-select-previous)
(define-key company-mode-map [remap indent-for-tab-command] 'company-indent-for-tab-command)
(defun company-indent-for-tab-command (&optional arg)
  (interactive "P")
  (let ((completion-at-point-functions-saved completion-at-point-functions)
    	(completion-at-point-functions '(company-complete-common-wrapper)))
	(indent-for-tab-command arg)))

(defun company-complete-common-wrapper ()
	(let ((completion-at-point-functions completion-at-point-functions-saved))
	(company-complete-common))))

(use-package company-lsp
:ensure t
:init
(push 'company-lsp company-backends))

;; Markdown
(use-package markdown-mode
  :ensure t
  :defer t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'"       . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

;; JavaScript
(use-package js2-mode
  :ensure t
  :init
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode)))

;; Tern - Code Analyzer (Same as Tide?)
(use-package tern :ensure t)

;; (use-package js2-refactor
;;   :ensure t 
;;   :init
;;   (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-refactor)))

;; Typescript
(use-package typescript-mode
  :ensure t
  :init
  (add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-mode)))

;; Tide - Code Analyzer (Same as Tern?)
;;(use-package tide
;;  :ensure t
;;  :after (typescript-mode company flycheck)
;;  :hook ((typescript-mode . tide-setup)
;;         (typescript-mode . tide-hl-identifier-mode)))

;; Python
(setq-default python-shell-interpreter "python3"
              python-indent-offset 4
              python-indent-guess-indent-offset nil)
;; use lsp-python niBBa

;; LaTeX
;; (use-package tex
;;   :ensure auctex
;;   :defer t
;;   :mode ("\\.tex\\'" . TeX-latex-mode))

;; (use-package company-auctex
;;   :ensure t
;;   :after (company tex)
;;   :defer t
;;   :config
;;   (company-auctex-init))

;; (use-package company-math
;;   :ensure t
;;   :defer t
;;   :config
;;   (add-to-list 'company-backends 'company-math-symbols-latex))

;;;;;;;;;;;;;;;;;;;;;;
;;   Do Not Touch   ;;
;;;;;;;;;;;;;;;;;;;;;;

