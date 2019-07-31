;; -*- lexical-binding: t; -*-

(use-package neotree
  :ensure t
  :bind ([f8] . neotree-toggle)
  :after (all-the-icons)
  :config
  (setq neo-show-hidden-files t)
  ;;(setq neo-autorefresh nil)
  (setq neo-smart-open t)
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow)))

(provide 'pkg-neotree)
