;; Start Emacs in fullscreen mode
(modify-all-frames-parameters '((fullscreen . maximized)))

;; For auto-complete mode
(add-to-list 'load-path "~/.emacs.d/elpa/auto-complete-20140803.2118")
(add-to-list 'load-path "~/.emacs.d/elpa/popup-20140207.1702")
(require 'auto-complete)
;; (add-to-list 'ac-modes 'matlab-mode)
(add-to-list 'ac-modes 'web-mode)
(add-to-list 'ac-modes 'R-mode)
(add-to-list 'ac-modes 'org-mode)
;; (add-to-list 'ac-modes 'java-mode)
(add-to-list 'ac-modes 'ruby-mode)
;; (add-to-list 'ac-modes 'emaxima-mode)
(add-to-list 'ac-modes 'c-mode)
;; (add-to-list 'ac-modes 'jde-mode)

;; smartparens (and what else??)
(package-initialize)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(R-mode-hook (quote (ess-bp-recreate-all ess-developer-setup-modeline ess-developer-activate-in-package ess-toggle-S-assign ess-toggle-S-assign)))
 '(ac-auto-start t)
 '(ansi-color-names-vector ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(custom-enabled-themes (quote (wombat)))
 '(custom-safe-themes (quote ("3d5307e5d6eb221ce17b0c952aa4cf65dbb3fa4a360e12a71e03aab78e0176c5" default)))
 '(electric-indent-mode t)
 '(ess-S-assign " = ")
 '(ess-default-style (quote GNU))
 '(ess-fancy-comments nil)
 '(ess-smart-S-assign-key "=")
 '(global-auto-complete-mode t)
 '(inhibit-startup-screen t)
 '(menu-bar-mode nil)
 '(package-archives (quote (("gnu" . "http://elpa.gnu.org/packages/") ("MELPA" . "http://melpa.milkbox.net/packages/"))))
 '(scroll-bar-mode nil)
 '(smartparens-global-mode t)
 '(sp-autoescape-string-quote nil)
 '(sp-autoinsert-if-followed-by-word nil)
 '(sp-highlight-pair-overlay nil)
 '(tool-bar-mode nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(completions-common-part ((t (:inherit default :foreground "red"))))
 '(show-paren-match ((((class color) (background light)) (:background "azure2")))))


;; Start web-mode automatically
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[gj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode)) 
(add-to-list 'auto-mode-alist '("\\.php\\'" . web-mode))

;; For relative line numbers
;; (add-to-list 'load-path "~/.emacs.d/elpa/linum-relative-20131210.2053")
;; (require 'linum-relative)

;; For multiple cursors
(add-to-list 'load-path "~/.emacs.d/elpa/multiple-cursors-20140804.1527")
(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;; For smartparens
(defun my-open-block-c-mode (id action context)
  (when (eq action 'insert)
    (newline)
    (newline)
    (indent-according-to-mode)
    (previous-line)
    (indent-according-to-mode)))

(sp-local-pair 'c-mode "{" nil :post-handlers '(:add my-open-block-c-mode))

;; For R in ESS
(add-to-list 'load-path "~/.emacs.d/elpa/ess-20140716.2033")
(autoload 'R-mode "ess-site.el" "ESS" t)
(add-to-list 'auto-mode-alist '("\\.R$" . R-mode))

;; Customizations for all modes in CC Mode. See
;; https://www.gnu.org/software/emacs/manual/html_node/ccmode/Sample-_002eemacs-File.html#Sample-_002eemacs-File
(defun my-c-mode-common-hook ()
  ;; auto-newline and hungry-delete
  (c-toggle-auto-newline 1)
  (c-toggle-hungry-state 1))
(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

;; ;; For JDEE
;; (add-to-list 'load-path "~/.emacs.d/other_packages/jdee-2.4.1/lisp")
;; (autoload 'jde-mode "jde" "JDE mode" t)
;; (setq auto-mode-alist
;;         (append '(("\\.java\\'" . jde-mode)) auto-mode-alist))

;; ;; Fixing up Matlab for auto-complete
;; (add-to-list 'load-path "~/.emacs.d/elpa/matlab-mode-20140307.2322")
;; (load-library "matlab-load")
;; (matlab-cedet-setup)

;; fix Ruby gemspec file mode
(add-to-list 'auto-mode-alist '("\\.gemspec$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.jbuilder" . ruby-mode))

(require 'rvm)
(rvm-use-default) ;; use rvm's default ruby for the current Emacs session

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

;; for BUGS and JAGS
(require 'ess-bugs-d)
;; (require 'ess-jags-d)

;; ;; for imaxima
;; ;; (push "/usr/local/share/emacs/site-lisp" load-path)
;; (autoload 'maxima-mode "maxima" "Maxima mode" t)
;; (autoload 'imaxima "imaxima" "Maxima frontend" t)
;; (autoload 'imath "imath" "Interactive Math mode" t)
;; (add-to-list 'auto-mode-alist '("\\.ma[cx]" . maxima-mode))

;; for Magit -- not using ATM
;; (add-to-list 'load-path "~/.emacs.d/elpa/git-rebase-mode-20140605.520")
;; (add-to-list 'load-path "~/.emacs.d/elpa/git-commit-mode-20140831.1359")
;; (add-to-list 'load-path "~/.emacs.d/elpa/magit-20140901.51")
;; (require 'magit)

;; ;; Java macros
;; ;; Java Main class macro
;; (fset 'java-main-class
;;    (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([112 117 98 108 105 99 32 99 108 97 115 115 32 77 97 105 110 return 123 return 16 5 return 112 117 98 108 105 99 32 115 116 97 116 105 99 32 118 111 105 100 32 109 97 105 110 40 83 116 114 105 110 103 91 6 32 97 114 103 115 5 return 123 return 16 5 return] 0 "%d")) arg)))
;; (global-set-key "\C-x\C-kM" 'java-main-class)
;; ;; Java public class macro
;; (fset 'java-public-class
;;    (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([112 117 98 108 105 99 32 99 108 97 115 115 return 123 return 80 backspace 16 5 return 16 16 5 32] 0 "%d")) arg)))
;; (global-set-key "\C-x\C-kP" 'java-public-class)
