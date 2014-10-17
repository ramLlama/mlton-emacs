;; Copyright (C) 2007-2008 Vesa Karvonen
;;
;; MLton is released under a BSD-style license.
;; See the file MLton-LICENSE for details.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Gnu Emacs / XEmacs compatibility workarounds

(if (string-match "XEmacs" emacs-version)
    (defun esml-compat-replace-regexp-in-string (str regexp rep)
      (replace-in-string str regexp rep t))
  (defun esml-compat-replace-regexp-in-string (str regexp rep)
    (replace-regexp-in-string regexp rep str t t)))

(if (string-match "XEmacs" emacs-version)
    (defun esml-compat-error (str &rest objs)
      (error 'error (concat "Error: " (apply (function format) str objs) ".")))
  (defalias 'esml-compat-error (function error)))

(if (string-match "XEmacs" emacs-version)
    (defalias 'esml-compat-add-local-hook (function add-local-hook))
  (defun esml-compat-add-local-hook (hook fn)
    (add-hook hook fn nil t)))

(if (string-match "XEmacs" emacs-version)
    (defun esml-compat-abbreviate-file-name (file)
      (abbreviate-file-name file t))
  (defalias 'esml-compat-abbreviate-file-name (function abbreviate-file-name)))

(if (string-match "XEmacs" emacs-version)
    (defalias 'esml-compat-delete-timer (function delete-itimer))
  (defalias 'esml-compat-delete-timer (function cancel-timer)))

(if (string-match "XEmacs" emacs-version)
    (defalias 'esml-compat-read-file-name (function read-file-name))
  (defun esml-compat-read-file-name (&optional a b c d e f)
    (funcall (function read-file-name) a b c d e)))

(if (string-match "XEmacs" emacs-version)
    (defalias 'esml-compat-process-live-p (function process-live-p))
  (defun esml-compat-process-live-p (process)
    (case (process-status process)
      ((run stop) t))))

(if (string-match "XEmacs" emacs-version)
    (defun esml-compat-compilation-parse-errors ()
      (funcall compilation-parse-errors-function nil nil))
  (defun esml-compat-compilation-parse-errors ()
    (compilation-esml-compat-parse-errors (point-max))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(provide 'esml-compat)
