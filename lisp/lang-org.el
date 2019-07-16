;; -*- lexical-binding: t; -*-

(use-package org
  :defer t
  :config
  (unbind-key "C-k" org-mode-map)
  (unbind-key "C-x n e" org-mode-map)
  ;; Wrap lines in org-mode
  (setq org-startup-truncated nil))

(use-package org-bullets
  :hook
  (org-mode . (lambda () (org-bullets-mode 1))))

(provide 'lang-org)
