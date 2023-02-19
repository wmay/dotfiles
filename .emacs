#!/usr/bin/emacs --script

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(wombat))
 '(delete-selection-mode t)
 '(dired-listing-switches "-alh")
 '(eww-search-prefix "https://www.google.com/search?q=")
 '(fill-column 80)
 '(inhibit-startup-screen t)
 '(package-archives
   '(("gnu" . "http://elpa.gnu.org/packages/")
     ("melpa" . "https://melpa.org/packages/")))
 '(package-selected-packages
   '(engine-mode makefile-executor ace-jump-mode rainbow-delimiters fish-mode yaml-mode auto-package-update use-package poly-R mood-line sql-indent web-mode stan-mode smex smartparens multiple-cursors markdown-mode magit ess electric-operator cython-mode csv-mode auto-complete))
 '(require-final-newline t)
 '(save-place-mode t)
 '(scroll-bar-mode nil)
 '(show-paren-delay 0)
 '(show-paren-mode t)
 '(split-height-threshold nil)
 '(split-width-threshold 140)
 '(tool-bar-mode nil)
 '(truncate-lines nil)
 '(visible-bell t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; this can be removed in Emacs >=27, which is in Ubuntu 22.04
(package-initialize)

;; Misc

;; make answering questions easier
(defalias 'yes-or-no-p 'y-or-n-p)
;; convert character case
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
;; automatically indent inserted text
(dolist (command '(yank yank-pop))
  (eval `(defadvice ,command (after indent-region activate)
	   (and (not current-prefix-arg)
		;; not in an inferior/shell ("command interpreter") buffer
		(not (derived-mode-p 'comint-mode))
		(let ((mark-even-if-inactive transient-mark-mode))
		  (indent-region (region-beginning) (region-end) nil))))))
;; for unzipping files
(eval-after-load "dired-aux"
  '(add-to-list 'dired-compress-file-suffixes 
		'("\\.zip\\'" ".zip" "unzip")))
;; remove unused left space
(modify-all-frames-parameters '((left-fringe . 0)))
;; Start Emacs in fullscreen mode. This should be called after other commands
;; that change the display (for example the fringe, tool bar mode, scroll bar
;; mode, or theme). Otherwise it can miscalculate the number of columns!
(modify-all-frames-parameters '((fullscreen . maximized)))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-compute-statistics 1
      use-package-always-ensure t)

(use-package auto-package-update
  :custom
  (auto-package-update-interval 14)
  (auto-package-update-prompt-before-update t)
  (auto-package-update-show-preview t)
  (auto-package-update-delete-old-versions t)
  :config
  (auto-package-update-maybe))


;; Editing

(use-package ido
  :config
  (ido-mode t))

(use-package smex
  :config
  (global-set-key (kbd "M-x") 'smex))

(use-package mood-line
  :config
  (mood-line-mode))

(use-package ace-jump-mode
  :bind ("C-c SPC" . ace-jump-mode))

(use-package auto-complete
  :config (ac-config-default)
  (global-auto-complete-mode t)
  (set-face-attribute 'ac-candidate-face nil   :background "#00222c" :foreground "light gray")
  (set-face-attribute 'ac-selection-face nil   :background "SteelBlue4" :foreground "white")
  (set-face-attribute 'popup-tip-face    nil   :background "#4c4c4c" :foreground "#eeeeee"))

;; math operator spacing
(use-package electric-operator
  :hook ((ess-r-mode . electric-operator-mode)
	 (ess-julia-mode . electric-operator-mode)
	 (python-mode . electric-operator-mode))
  :custom
  (electric-indent-mode t)
  (electric-operator-R-named-argument-style 'spaced)  
  :config
  (electric-operator-add-rules-for-mode 'ess-mode
					(cons "^" nil)))

(use-package multiple-cursors
  :bind (("C-S-c C-S-c" . mc/edit-lines)
	 ("C->" . mc/mark-next-like-this)
	 ("C-<" . mc/mark-previous-like-this)
	 ("C-c C-<" . mc/mark-all-like-this)))

;; make lisp parentheses more tolerable
(require 'color)
;; Brighten a color. `s` is the percent to increase saturation. `l` is the
;; percent to increase luminance.
(defun my-brighten-color (name s l)
  (color-saturate-name 
   (color-lighten-name name l) s))
(use-package rainbow-delimiters
  :hook (emacs-lisp-mode . rainbow-delimiters-mode)
  :config
  (dotimes (i rainbow-delimiters-max-face-count)
    (let* ((face (intern (format "rainbow-delimiters-depth-%d-face" (+ i 1))))
	   (new-color (my-brighten-color (face-foreground face) 50 4)))
      (set-face-foreground face new-color))))

;; after creating a closing bracket, automatically move it two lines down and
;; end with the cursor on the previous line
(defun my-create-newline-and-enter-sexp (&rest _ignored)
  (newline)
  (ess-newline-and-indent)
  (previous-line)
  (indent-according-to-mode))
(defun my-{-handler (&rest _ignored)
  (if (eq (sp--get-context) 'code)
      (my-create-newline-and-enter-sexp)))
(use-package smartparens
  :custom
  (sp-highlight-pair-overlay nil)
  :config
  (smartparens-global-mode t)
  (sp-local-pair 'ess-mode "{" nil :post-handlers '(my-{-handler))
  (sp-local-pair 'emacs-lisp-mode "'" nil :actions nil)
  (sp-pair "'" nil :unless '(sp-point-after-word-p sp-point-before-word-p
			     sp-in-string-p))
  (sp-pair "\"" nil :unless '(sp-point-after-word-p sp-point-before-word-p
			      sp-in-string-p))
  (sp-pair "(" nil :unless '(sp-point-before-word-p sp-point-before-same-p))
  (sp-pair "[" nil :unless '(sp-point-before-word-p sp-point-before-same-p)))

(use-package magit
  :bind (("C-x g" . magit-status)
         ("C-x C-g" . magit-status))
  :custom
  (magit-bury-buffer-function 'magit-mode-quit-window))

(use-package engine-mode
  :config
  (engine-mode t))
(defengine google
  "https://www.google.com/search?ie=utf-8&oe=utf-8&q=%s"
  :keybinding "g")


;; Mode customizations

(use-package ess
  :defer t
  :hook ((ess-mode . (lambda () (ess-toggle-underscore nil)))
	 ;; remove exasperating double comment symbols
	 (ess-r-mode . (lambda () (setq-local comment-add 0))))
  :custom
  (inferior-R-args "--no-restore --no-save")
  (ess-default-style 'GNU)
  (ess-r-package-auto-enable-namespaced-evaluation nil)
  (ess-r-package-auto-set-evaluation-env nil)
  (ess-style 'GNU)
  (ess-ask-for-ess-directory nil)
  (ess-indent-with-fancy-comments nil)
  (ess-auto-width -1))

(use-package poly-R
  :defer t)

(use-package python
  :defer t
  :custom
  (python-shell-interpreter "ipython3")
  (python-shell-interpreter-args "--simple-prompt --nosep"))

(use-package makefile-executor
  :hook (makefile-mode . makefile-executor-mode))

(use-package fish-mode
  :defer t)

;; (use-package sql)

(use-package sql-indent
  :hook (sql-mode . sqlind-minor-mode))

(use-package yaml-mode
  :mode ("\\.ya?ml\\'" . yaml-mode))

(use-package web-mode
  :mode (("\\.phtml\\'" . web-mode)
	 ("\\.tpl\\.php\\'" . web-mode)
	 ("\\.[agj]sp\\'" . web-mode)
	 ("\\.as[cp]x\\'" . web-mode)
	 ("\\.erb\\'" . web-mode)
	 ("\\.mustache\\'" . web-mode)
	 ("\\.djhtml\\'" . web-mode)
	 ("\\.html?\\'" . web-mode)))

(use-package stan-mode
  :defer t)

(use-package markdown-mode
  :defer t)

(use-package cython-mode
  :defer t)

(use-package csv-mode
  :defer t)
