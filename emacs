;; Start Emacs in fullscreen mode
(modify-all-frames-parameters '((fullscreen . maximized)))


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
 '(menu-bar-mode nil)
 '(package-archives
   (quote
    (("gnu" . "http://elpa.gnu.org/packages/")
     ("melpa" . "https://melpa.org/packages/"))))
 '(package-selected-packages
   (quote
    (poly-R mood-line sql-indent web-mode stan-mode smex smartparens multiple-cursors markdown-mode magit ess electric-operator dired-toggle-sudo cython-mode csv-mode auto-complete)))
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

;; try to autoload packages
(package-initialize)


;; Editing

;; autocomplete
(ac-config-default)
(global-auto-complete-mode t)
(set-face-attribute 'ac-candidate-face nil   :background "#00222c" :foreground "light gray")
(set-face-attribute 'ac-selection-face nil   :background "SteelBlue4" :foreground "white")
(set-face-attribute 'popup-tip-face    nil   :background "#4c4c4c" :foreground "#eeeeee")
;; math operator spacing
(require 'electric-operator)
(electric-operator-add-rules-for-mode 'ess-mode
				      (cons "^" nil))
;; multiple cursors
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
;; parentheses autocompletion
(smartparens-global-mode t)
(defun my-create-newline-and-enter-sexp (&rest _ignored)
  (newline)
  (ess-newline-and-indent)
  (previous-line)
  (indent-according-to-mode))
(sp-local-pair 'ess-mode "{" nil :post-handlers '(my-create-newline-and-enter-sexp))
(sp-pair "'" nil :unless '(sp-point-after-word-p))
(sp-pair "\"" nil :unless '(sp-point-after-word-p))
(sp-pair "(" nil :unless '(sp-point-before-word-p))
(sp-pair "[" nil :unless '(sp-point-before-word-p))
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


;; Mode customizations

;; ess
(add-hook 'ess-r-mode-hook (function electric-operator-mode))
(add-hook 'ess-julia-mode-hook (function electric-operator-mode))
(require 'ess-site)
(setq ess-ask-for-ess-directory nil)
(ess-toggle-underscore nil)
(setq ess-indent-with-fancy-comments nil)
;; remove exasperating double comment symbols
(add-hook 'ess-r-mode-hook (lambda () (setq-local comment-add 0)))
;; web-mode
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
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

;; convenient sudo switching
(require 'dired-toggle-sudo)
(define-key dired-mode-map (kbd "C-c C-s") 'dired-toggle-sudo)
;; nicer file sizes
(setq dired-listing-switches "-alh")
;; for unzipping files
(eval-after-load "dired-aux"
  '(add-to-list 'dired-compress-file-suffixes 
		'("\\.zip\\'" ".zip" "unzip")))
