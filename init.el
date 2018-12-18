
;;;;;;;;;;;;;;;;;;;;;;;
;;  Packages I Want  ;;
;;;;;;;;;;;;;;;;;;;;;;;

;; Org Mode

;; Ivy
;; Projectile
;; Company
;; LSP

;; Which Key
;; Powerline
;; NeoTree
;; All The Icons


;;;;;;;;;;;;;;;;;;;;;;
;;       TODO       ;;
;;;;;;;;;;;;;;;;;;;;;;

;; Improve language supports section
;; Better organization and readability
;; More customization
;; Cleanup and decrease size
;; Fix scrolling lag, could be caused by spaceline
;; Disabling linum-mode fixed the lag, but I want linum-mode so I need to find an alternative


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

;; "Smooth scrolling"
;;(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))
(setq mouse-wheel-follow-mouse 't)

;; Parentheses
(setq show-paren-delay 0)
(show-paren-mode  1)
(electric-pair-mode 1)

;; Splash Screen
;;(setq inhibit-startup-screen t)
;;(setq initial-scratch-message ";; ( ͡° ͜ʖ ͡°)")

;; UI Configurations
;;(scroll-bar-mode -1)
;;(horizontal-scroll-bar-mode -1)
;;(tool-bar-mode   -1)
;;(tooltip-mode    -1)
;;(menu-bar-mode   -1)
;;(global-linum-mode t) ;; !WARNING: CAUSES MASSIVE LAG WHEN SCROLLING!
;;(setq linum-format " %d ") ;; Fix clipping issue
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
 ;; 4 spaces instead of tabs TODO: Possibly change to 2 spaces
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

;; Shell
(global-set-key [f1] 'shell)
(global-set-key [f2] 'shell-command)

;; Auto align
(global-set-key (kbd "C-c C-a") 'align)
(global-set-key (kbd "C-c a") 'align-regexp)

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
;;(global-set-key (kbd "C-'") 'find-file-other-window)
;; (defun find-file-other-window ()
;;   (interactive)
;;   ;;(if (one-window-p nil)
;;   ;;    (split-window-right)
;;   ;;  (delete-other-windows)
;;   ;;(other-window 1)
;;   (find-file-other-window))

;; goto-line
(global-set-key [C-tab] 'goto-line)


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
;;      Unused      ;;
;;;;;;;;;;;;;;;;;;;;;;

;; Fancy titlebar for MacOS
;; (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
;; (add-to-list 'default-frame-alist '(ns-appearance . dark))
;; (setq ns-use-proxy-icon  nil)
;; (setq frame-title-format nil)


;;;;;;;;;;;;;;;;;;;;;;;
;;  Packages (Sort)  ;;
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

;; Ivy - Interactive interface completion
(use-package ivy
  :ensure t
  :hook (after-init . ivy-mode)
  :bind ("C-x 4 b"  . ivy-switch-buffer-other-window)
  :config
  (setq ivy-use-virtual-buffers t
        ivy-count-format "(%d/%d) "
        ivy-display-style 'fancy
        ivy-re-builders-alist
        '((swiper   . ivy--regex-plus)
          (t        . ivy--regex-fuzzy))
        ivy-virtual-abbreviate 'full))
;; Counsel - Remap Emacs functions to Counsel replacements
(use-package counsel
  :ensure t
  :after ivy
  :bind (;;("M-x"     . counsel-M-x)
         ("C-x C-f" . counsel-find-file)
         ("C-x C-r" . counsel-recentf))
  :config
  (setq counsel-find-file-ignore-regexp "^\\.\\|~$\\|^#\\|\\.elc\\|\\.pyc\\|__pycache__"))
;; Swiper - Ivy alternative to isearch
(use-package swiper
  :ensure t
  :after ivy
  :bind (("C-s"     . swiper)
         ("C-r"     . swiper)))

;; Projectile - Project Interaction
(use-package projectile
  :ensure t
  :defer t
  :hook ((emacs-lisp-mode . projectile-mode)
         (python-mode     . projectile-mode)
         (html-mode       . projectile-mode)
         (css-mode        . projectile-mode)
         (js2-mode         . projectile-mode))         
         ;;(rust-mode       . projectile-mode))
  :init
  (setq projectile-keymap-prefix (kbd "C-c p"))
  :config
  (setq projectile-enable-caching t
        ;; External indexing for Windows . 
        projectile-indexing-method 'alien
        projectile-completion-system 'ivy))

(use-package counsel-projectile
  :ensure t
  :after (counsel projectile)
  :config
  (counsel-projectile-mode))

;; Flx - Fuzzy matching
(use-package flx
  :ensure t
  :defer t)

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

;; LSP - Language Server Protocal library
(use-package lsp-mode
  :ensure t
  :defer t)

(use-package lsp-imenu
  :hook (lsp-after-open . lsp-enable-imenu))

(use-package lsp-ui
  :ensure t
  :hook (lsp-mode . lsp-ui-mode))

;; Yasnippet - Template system (abbreviation into function template)
(use-package yasnippet
  :ensure t
  :defer t
  :commands yas-minor-mode
  :hook (prog-mode . yas-minor-mode)
  :config
  (yas-reload-all))

;;(use-package yasnippet-snippets :ensure t)

;; FlyCheck - Syntax checking
(use-package flycheck
  :ensure t
  :bind (("C-\\"          . flycheck-list-errors)
         ("M-["           . flycheck-previous-error)
         ("M-]"           . flycheck-next-error))
  :hook ((emacs-lisp-mode . flycheck-mode)
         (python-mode     . flycheck-mode)
         (html-mode       . flycheck-mode)
         (css-mode        . flycheck-mode)
         (js2-mode         . flycheck-mode))
         ;;(rust-mode     . flycheck-mode))
  :config
  (setq-default flycheck-checker-error-threshold 400
                flycheck-disabled-checkers '(emacs-lisp-checkdoc)
                flycheck-check-syntax-automatically '(save mode-enabled)))

;; Company - Text completion
(use-package company
  :ensure t
  :defer 1
  :commands company-mode
  :config
  (setq company-idle-delay 0.1
        company-minimum-prefix-length 1
        company-tooltip-limit 20)
  (global-company-mode 1))

(use-package company-lsp
  :ensure t
  :after (company lsp-mode)
  :config
  (push 'company-lsp company-backends))

;; NeoTree - Filepath Sidebar
(use-package neotree
  :ensure t
  :init
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow)))
(global-set-key [f8] 'neotree-toggle)

;; All The Icons - Icon and Font Collection
(use-package all-the-icons :ensure t)

;; Which Key - Command assist
(use-package which-key
  :ensure t
  :init
  (setq which-key-separator " ")
  (setq which-key-prefix-prefix "+")
  :config
  (which-key-mode))

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

;; HTML
(use-package lsp-html
  :ensure t
  :hook (html-mode . lsp-html-enable))

;; CSS
(use-package lsp-css
  :ensure t
  :hook (css-mode . lsp-css-enable))

;; PHP
(use-package lsp-php
  :ensure t
  :hook (php-mode . lsp-php-enable))

;; Javascript
(use-package js2-mode
  :ensure t
  :init
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode)))

(use-package lsp-javascript-typescript
  :ensure t
  :hook (js2-mode . lsp-javascript-typescript-enable))

;; Typescript - Look into Tide
(use-package typescript-mode
  :ensure t
  :init
  (add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-mode)))

(use-package lsp-typescript
  :ensure t
  :hook (typescript-mode . lsp-typescript-enable))

;; Python
(setq-default python-shell-interpreter "python3"
              python-indent-offset 4
              python-indent-guess-indent-offset nil)
              ;; TODO: Make this crossplatform.
              ;;flycheck-flake8rc "C:/Users/Eric/.flake8")

(use-package lsp-python
  :ensure t
  :hook (python-mode . lsp-python-enable))

;; SQL
;; ADD SQL SUPPORT

;; Shell
;; ADD SHELL SUPPORT

;; Markdown
(use-package markdown-mode
  :ensure t
  :defer t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'"       . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

;; LaTeX
(use-package tex
  :ensure auctex
  :defer t
  :mode ("\\.tex\\'" . TeX-latex-mode))

(use-package company-auctex
  :ensure t
  :after (company tex)
  :defer t
  :config
  (company-auctex-init))

(use-package company-math
  :ensure t
  :defer t
  :config
  (add-to-list 'company-backends 'company-math-symbols-latex))


;;;;;;;;;;;;;;;;;;;;;;
;;   Do Not Touch   ;;
;;;;;;;;;;;;;;;;;;;;;;
