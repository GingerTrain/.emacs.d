;; -*- lexical-binding: t; -*-

;; Disable GUI elements
(menu-bar-mode   -1)
(scroll-bar-mode -1)
(tool-bar-mode   -1)
(tooltip-mode    -1)

(blink-cursor-mode 0)            ;; Disable blinking
(set-default 'cursor-type 'box)  ;; Fat cursor
(global-hl-line-mode t)          ;; Highlight current line
(show-paren-mode)                ;; Show matching parentheses
;;(fringe-mode '(4 . 0))           ;; Thinner fringes

(setq-default
 mode-line-default-help-echo nil) ;; Disable mode-line hover tips

(when (version<= "26.0.50" emacs-version )
      (global-display-line-numbers-mode )) ;; Enable line numbers

;; Indentation highlighting
(use-package highlight-indent-guides
  :ensure t
  :hook (prog-mode . highlight-indent-guides-mode)
  :config
  (setq highlight-indent-guides-method 'character))

;; Rainbow delimiters
(use-package rainbow-delimiters
  :ensure t
  :hook (prog-mode . rainbow-delimiters-mode))

;; Emoji support
(use-package company-emoji
  :hook
  ((markdown-mode . company-mode)
   (git-commit-mode . company-mode))
  :config
  (add-to-list 'company-backends 'company-emoji))

(use-package emojify
  :hook
  ((markdown-mode . emojify-mode)
   (git-commit-mode . emojify-mode)
   (magit-status-mode . emojify-mode)
   (magit-log-mode . emojify-mode)))

;; Font
(set-face-attribute 'default nil
                    :family "Iosevka"
                    :height 110)

;; Theme
(use-package base16-theme
  :ensure t
  :config
  (load-theme 'base16-atelier-dune t)
  (set-face-attribute 'mode-line           nil :background "#2D2B28")
  (set-face-attribute 'region              nil :background "#3F3E36")
  (set-face-attribute 'secondary-selection nil :background "#3F3E36")
  (eval-after-load 'company
    '(progn
       (set-face-attribute 'company-tooltip-selection nil :background "#292824"))))

;; Modeline
(use-package core-modeline
  :config
  (setq line-number-mode 1
        column-number-mode 1))

(provide 'core-ui)
