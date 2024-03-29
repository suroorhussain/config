(put 'upcase-region 'disabled nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (tango-dark)))
 '(package-selected-packages
   (quote
    (rainbow-mode go-mode rudel togetherly yaml-mode csv-mode web-mode persistent-scratch jedi flycheck-pycheckers flycheck-pyflakes flycheck yasnippet web nlinum magit projectile)))
 '(show-paren-style (quote expression)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; set tab width to 4 spaces
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

;; Set agenda file and macro
(setq org-agenda-files '("~/journals/vyoma.org"))
(global-set-key "\C-ca" 'org-agenda)

;; Add archives
(setq package-archives '(("melpa-stable" . "http://stable.melpa.org/packages/")
                         ("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.org/packages/")
                         ("elpa" . "http://tromey.com/elpa/")
                         ))

;; Install packages


; list the packages you want
(setq package-list '(projectile magit nlinum web persistent-scratch))

; activate all the packages (in particular autoloads)
(package-initialize)

; fetch the list of packages available
(unless package-archive-contents
  (package-refresh-contents))

; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))


;;setup jedi autocomplete
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)

;; Add macro to reset file
(global-set-key (kbd"C-c r") (lambda ()
                               (interactive)
                               (revert-buffer t t t)
                               (message "buffer is reverted")))
;; toggle useful modes on
(show-paren-mode t)
(iswitchb-mode t)
(projectile-global-mode)
(setq projectile-keymap-prefix (kbd "C-c p")) ;; Set the keybinding for projectile mode. This needs to be manually set
(global-nlinum-mode t)

;; Start server
(server-start)

;; Remove menubar and toolbar
(menu-bar-mode 0)
(tool-bar-mode 0)

;; Activate projectile mode
;;(add-hook 'after-init-hook #'projectile-mode)

;; Add hooks for golang
(add-hook 'before-save-hook #'gofmt-before-save)

;; (global-flycheck-mode)

;; set web-mode as default html editor
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(setq web-mode-engines-alist
      '(("django"    . "\\.html\\'"))
)

;; Command to activate django mode
(defun webd () (interactive) (web-mode-set-engine "django"))

;; Setup persitent scratch
(persistent-scratch-setup-default)

;; Configure flymake for Python
(when (load "flymake" t)
  (defun flymake-pylint-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      (list "epylint3" (list local-file))))
  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.py\\'" flymake-pylint-init)))

;; Set as a minor mode for Python
(add-hook 'python-mode-hook '(lambda () (flymake-mode)))

;; Configure to wait a bit longer after edits before starting
(setq-default flymake-no-changes-timeout '3)


;; To avoid having to mouse hover for the error message, these functions make flymake error messages
;; appear in the minibuffer
(defun show-fly-err-at-point ()
  "If the cursor is sitting on a flymake error, display the message in the minibuffer"
  (require 'cl)
  (interactive)
  (let ((line-no (line-number-at-pos)))
    (dolist (elem flymake-err-info)
      (if (eq (car elem) line-no)
      (let ((err (car (second elem))))
        (message "%s" (flymake-ler-text err)))))))

(add-hook 'post-command-hook 'show-fly-err-at-point)

(require 'projectile)
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
(projectile-mode +1)

;; FLymake venv
(defun set-flychecker-executables ()
  "Configure virtualenv for flake8 and lint."
  (when (get-current-buffer-flake8)
    (flycheck-set-checker-executable (quote python-flake8)
                                     (get-current-buffer-flake8)))
  (when (get-current-buffer-pylint)
    (flycheck-set-checker-executable (quote python-pylint)
                                     (get-current-buffer-pylint))))
(add-hook 'flycheck-before-syntax-check-hook
          #'set-flychecker-executables 'local)