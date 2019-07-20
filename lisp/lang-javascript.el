;; -*- lexical-binding: t; -*-

(use-package js2-mode
  :mode ("\\.js\\'" . js2-mode)
  :config
  (setq js-switch-indent-offset 2)
  (setq js2-include-node-externs t)
  (setq js2-include-browser-externs t)
  (setq js2-basic-offset 2)
  (setq js2-highlight-level 3))

  ;;(add-hook 'js2-mode-hook 'js2-mode-hide-warnings-and-errors)
  ;;(add-hook 'js2-mode-hook '(lambda () (modify-syntax-entry ?_ "w")))

(add-to-list 'interpreter-mode-alist '("node" . js2-mode))

(use-package json
  :ensure json-mode
  :mode (("\\.json" . json-mode))
         ("\\.eslintrc$" . json-mode))
  :config
  (add-hook 'json-mode-hook
            '(lambda () (setq-local js-indent-level 2))))

;; Utilities
(use-package js2-refactor
  :ensure t
  :after js2-mode)

(use-package tern
  :ensure t
  :after js2-mode
  :disabled t
  :config
  (add-hook 'js2-mode-hook 'tern-mode))

(provide 'lang-javascript)
