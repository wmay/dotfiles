
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (wombat)))
 '(electric-indent-mode t)
 '(electric-operator-R-named-argument-style (quote spaced))
 '(ess-default-style (quote GNU))
 '(ess-indent-with-fancy-comments nil)
 '(ess-r-package-auto-enable-namespaced-evaluation nil)
 '(ess-r-package-auto-set-evaluation-env nil)
 '(ess-style (quote GNU))
 '(eww-search-prefix "https://www.google.com/search?q=")
 '(fci-rule-use-dashes t)
 '(fill-column 80)
 '(inferior-R-args "--no-restore --no-save")
 '(inhibit-startup-screen t)
 '(package-archives
   (quote
    (("gnu" . "http://elpa.gnu.org/packages/")
     ("melpa" . "https://melpa.org/packages/"))))
 '(package-selected-packages
   (quote
    (poly-R mood-line sql-indent web-mode stan-mode smex smartparens multiple-cursors markdown-mode magit ess electric-operator cython-mode csv-mode auto-complete)))
 '(python-shell-interpreter "ipython3")
 '(python-shell-interpreter-args "--simple-prompt --nosep")
 '(scroll-bar-mode nil)
 '(sp-highlight-pair-overlay nil)
 '(split-height-threshold nil)
 '(split-width-threshold 140)
 '(sql-mode-hook (quote (sqlind-minor-mode)))
 '(sql-product (quote postgres))
 '(tool-bar-mode nil)
 '(truncate-lines nil))
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
;; minibuffer autocompletion
(ido-mode t)
(global-set-key (kbd "M-x") 'smex)
;; remove unused left space
(modify-all-frames-parameters '((left-fringe . 0)))
;; replace annoying error noise with visual notification
(setq visible-bell 1)
;; nicer mode line
(mood-line-mode)

;; Start Emacs in fullscreen mode. This should be called after other commands
;; that change the display (for example the fringe, tool bar mode, scroll bar
;; mode, or theme). Otherwise it can miscalculate the number of columns!
(modify-all-frames-parameters '((fullscreen . maximized)))

(require 'use-package)
(setq use-package-compute-statistics 1)


;; Editing

(use-package auto-complete
  :config (ac-config-default)
  (global-auto-complete-mode t)
  (set-face-attribute 'ac-candidate-face nil   :background "#00222c" :foreground "light gray")
  (set-face-attribute 'ac-selection-face nil   :background "SteelBlue4" :foreground "white")
  (set-face-attribute 'popup-tip-face    nil   :background "#4c4c4c" :foreground "#eeeeee"))

;; math operator spacing
(use-package electric-operator
  :config
  (electric-operator-add-rules-for-mode 'ess-mode
					(cons "^" nil)))

(use-package multiple-cursors
  :bind (("C-S-c C-S-c" . mc/edit-lines)
	 ("C->" . mc/mark-next-like-this)
	 ("C-<" . mc/mark-previous-like-this)
	 ("C-c C-<" . mc/mark-all-like-this)))

(defun my-create-newline-and-enter-sexp (&rest _ignored)
  (newline)
  (ess-newline-and-indent)
  (previous-line)
  (indent-according-to-mode))
(use-package smartparens
  :config
  (smartparens-global-mode t)
  (sp-local-pair 'ess-mode "{" nil :post-handlers '(my-create-newline-and-enter-sexp))
  (sp-pair "'" nil :unless '(sp-point-after-word-p))
  (sp-pair "\"" nil :unless '(sp-point-after-word-p))
  (sp-pair "(" nil :unless '(sp-point-before-word-p))
  (sp-pair "[" nil :unless '(sp-point-before-word-p)))

;; convert character case
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
;; delete selected text when pasting [yanking]
(delete-selection-mode 1)
;; automatically indent inserted text
(dolist (command '(yank yank-pop))
  (eval `(defadvice ,command (after indent-region activate)
	   (and (not current-prefix-arg)
		;; in case I want to exclude modes later:
		;; (member major-mode '(emacs-lisp-mode lisp-mode
		;; 				     clojure-mode    scheme-mode
		;; 				     haskell-mode    ruby-mode
		;; 				     rspec-mode      python-mode
		;; 				     c-mode          c++-mode
		;; 				     objc-mode       latex-mode
		;; 				     plain-tex-mode))
		(let ((mark-even-if-inactive transient-mark-mode))
		  (indent-region (region-beginning) (region-end) nil))))))

;; Mode customizations

(use-package magit
  :bind (("C-x g" . magit-status)
         ("C-x C-g" . magit-status))
  :custom
  (magit-bury-buffer-function 'magit-mode-quit-window))

(use-package ess
  :hook ((ess-r-mode . electric-operator-mode)
	 (ess-julia-mode . electric-operator-mode)
	 (ess-mode . (lambda () (ess-toggle-underscore nil)))
	 ;; remove exasperating double comment symbols
	 (ess-r-mode . (lambda () (setq-local comment-add 0))))
  :custom
  (ess-ask-for-ess-directory nil)
  (ess-indent-with-fancy-comments nil)
  (ess-auto-width 'window))

;; make R Markdown work
(require 'polymode)
(require 'poly-R)

(use-package web-mode
  :mode (("\\.phtml\\'" . web-mode)
	 ("\\.tpl\\.php\\'" . web-mode)
	 ("\\.[agj]sp\\'" . web-mode)
	 ("\\.as[cp]x\\'" . web-mode)
	 ("\\.erb\\'" . web-mode)
	 ("\\.mustache\\'" . web-mode)
	 ("\\.djhtml\\'" . web-mode)
	 ("\\.html?\\'" . web-mode)))

;; actually, need python 2 for Python Mapper
;; (setq python-shell-interpreter "python3")
(setq python-mode-hook #'electric-operator-mode)
;; SQL
(defun update-sql-product (product)
  (sql-mode)
  (sql-set-product product))
(add-to-list 'auto-mode-alist '("\\.sql\\'" . (lambda () (update-sql-product "postgres"))))
(add-to-list 'auto-mode-alist '("\\.postgresql\\'" . (lambda () (update-sql-product "postgres"))))
(add-to-list 'auto-mode-alist '("\\.sqlite\\'" . (lambda () (update-sql-product "sqlite"))))


;; Directory navigation

;; nicer file sizes
(setq dired-listing-switches "-alh")
;; for unzipping files
(eval-after-load "dired-aux"
  '(add-to-list 'dired-compress-file-suffixes 
		'("\\.zip\\'" ".zip" "unzip")))
