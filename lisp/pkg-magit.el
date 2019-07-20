;; -*- lexical-binding: t; -*-

(use-package magit
  :ensure t
  :bind ("C-x g" . magit)
  :init
  (setq magit-completing-read-function 'ivy-completing-read))

(provide 'pkg-magit)
