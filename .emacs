;;--------------
;; MELPA Emacs package archive
;;--------------
(require 'package) ;; You might already have this line
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (url (concat (if no-ssl "http" "https") "://melpa.org/packages/")))
  (add-to-list 'package-archives (cons "melpa" url) t))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize) ;; You might already have this line

;;--------------
;; Zenburn Theme
;;--------------
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'zenburn t)

;;--------------
;; Initial Options
;;--------------
(setq inhibit-startup-message  t)   ; Don't want any startup message
(setq make-backup-files         nil) ; Don't want any backup files
;;(setq auto-save-list-file-name  nil) ; Don't want any .saves files
;;(setq auto-save-default         nil) ; Don't want any auto saving

(setq search-highlight           t)  ; Highlight search object
(setq query-replace-highlight    t)  ; Highlight query object
;;(setq mouse-sel-retain-highlight t)  ; Keep mouse high-lightening
(setq line-number-mode t)      ; Set line number minor mode
(setq column-number-mode t)      ; Set column number minor mode
(setq tool-bar-mode              t)
(setq menu-bar-mode              nil)
(setq blink-cursor-mode          t)

;;(global-set-key [kp-home]  'beginning-of-buffer)
(global-set-key [home]     'beginning-of-buffer)
;;(global-set-key [kp-end]   'end-of-buffer)
(global-set-key [end]      'end-of-buffer)
;;(global-set-key [kp-prior] 'scroll-down)
;;(global-set-key [prior]    'scroll-down)
;;(global-set-key [kp-next]  'scroll-up)
;;(global-set-key [next]     'scroll-up)
;;(global-set-key [f3] 'replace-string)
;;(global-set-key [f4] 'goto-line)
;;(global-set-key [f12] 'undo)

;;--------------
;; MELPA
;;--------------
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
;; (let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
;;                     (not (gnutls-available-p))))
;;        (url (concat (if no-ssl "http" "https") "://melpa.org/packages/")))
;;   (add-to-list 'package-archives (cons "melpa" url) t))
;; (when (< emacs-major-version 24)
;;   ;; For important compatibility libraries like cl-lib
;;   (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
;; (package-initialize) ;; You might already have this line

;;--------------
;; Other options
;;--------------

;; Initial window size
(when window-system (set-frame-size (selected-frame) 160 100))

;; paired quotes etc.
(electric-pair-mode 1)

;; Don't center single comment like "#"
(setq ess-fancy-comments nil)

;; copy line
(defun duplicate-line()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (open-line 1)
  (next-line 1)
  (yank)
  )
(global-set-key (kbd "C-;") 'duplicate-line)

;; Interactively Do Things
(require 'ido)
(ido-mode t)

;; Multiple cursors
(require 'multiple-cursors)
; When you have an active region that spans multiple lines, the following will add a cursor to each line:
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
;When you want to add multiple cursors not based on continuous lines, but based on keywords in the buffer, use:
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files (quote ("~/temp/notes.org")))
 '(org-startup-folded nil)
 '(org-startup-indented t)
 '(package-selected-packages
   (quote
    (auto-complete exec-path-from-shell multiple-cursors))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Auto complete
(ac-config-default)

;; ESS
; The following two lins adds /usr/local/bin to the emacs PATH.
(setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))
(setq exec-path (append exec-path '("/usr/local/bin")))
; Set auto complete for ESS
(setq ess-use-auto-complete 'script-only)
; Load ESS package
(add-to-list 'load-path "/Users/xuyifa/ess-17.11/lisp/")
(load "ess-site")


;;------------
;; Setting up the org mode filing structure
;;------------
(require 'org)
(setq org-directory "~/org")
(setq org-default-notes-file (concat org-directory "/quick-notes.org"))
(define-key global-map "\C-cc" 'org-capture)

(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/org/todos.org" "Tasks")
	 "* TODO %?")
        ("m" "Meeting" entry (file+datetree "~/org/meetings.org")
	 "* %?\nEntered on %T")))
