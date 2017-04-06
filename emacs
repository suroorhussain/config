(put 'upcase-region 'disabled nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (tango-dark)))
 '(show-paren-style (quote expression)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

(setq org-agenda-files '("~/journals/vyoma.org"))
(global-set-key "\C-ca" 'org-agenda)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))

(add-hook 'python-mode-hook 'jedi:setup)
(global-set-key (kbd"C-c r") (lambda ()
                               (interactive)
                               (revert-buffer t t t)
                               (message "buffer is reverted")))

(show-paren-mode t)
(iswitchb-mode t)

(server-start)

(menu-bar-mode 0)
(tool-bar-mode 0)

(add-hook 'after-init-hook #'projectile-mode)

;; (global-flycheck-mode)



(when (load "flymake" t)
  (defun flymake-pylint-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      (list "/home/suroor/epylint" (list local-file))))
  
  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.py\\'" flymake-pylint-init)))

;; (when (load "flymake" t) 
;;   (defun flymake-pyflakes-init () 
;;     (let* ((temp-file (flymake-init-create-temp-buffer-copy 
;;                        'flymake-create-temp-inplace)) 
;;            (local-file (file-relative-name 
;;                         temp-file 
;;                         (file-name-directory buffer-file-name)))) 
;;       (list "pyflakes" (list local-file)))) 
  
;;   (add-to-list 'flymake-allowed-file-name-masks 
;;                '("\\.py\\'" flymake-pyflakes-init))) 

;; (add-hook 'find-file-hook 'flymake-find-file-hook)
