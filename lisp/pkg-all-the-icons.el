;; -*- lexical-binding: t; -*-

;; all-the-icons
;; file-icons
;; FontAwesome
;; github-octicons
;; Material Icons
;; Weather Icons

(use-package all-the-icons
  :ensure t
  :config
  (unless (member "all-the-icons" (font-family-list))
    (all-the-icons-install-fonts t)))
  ;;(setq inhibit-compacting-font-caches t)) ;; Fix slow rendering

(use-package all-the-icons-ivy
  :ensure t
  :config
  (all-the-icons-ivy-setup))

(use-package all-the-icons-dired
  :ensure t
  :hook (dired-mode . all-the-icons-dired-mode))

(provide 'pkg-all-the-icons)
