; https://blog.aaronbieber.com/2015/05/24/from-vim-to-emacs-in-fourteen-days.html
(require 'package)
 
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))
 
(setq package-enable-at-startup nil)
(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (web-mode adaptive-wrap markdown-mode evil-visual-mark-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

; Evil Mode to make it like Vim. Starts every time.
(require 'evil)
(evil-mode t)


; This is for package management, somehow
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
;; Added after reading https://ianyepan.github.io/posts/setting-up-use-package/
(eval-and-compile
  (setq use-package-always-ensure t
        use-package-expand-minimally t))

(eval-when-compile
  (require 'use-package))

(use-package markdown-mode
  :mode ("\\.md\\'" . markdown-mode))

(use-package adaptive-wrap)

(setf sentence-end-double-space nil)

; Stops the ~ tilde endings for backup files
(setq backup-directory-alist `(("." . "~/.saves")))
(setq backup-by-copying t)

; Stop the splash screen because I'm an expert
(setq inhibit-startup-screen t)
