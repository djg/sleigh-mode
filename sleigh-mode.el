;;; sleigh-mode.el --- sample major mode for editing ghidra sleigh files. -*- coding: utf-8; lexical-binding: t; -*-

;; Copyright © 2020, Dan Glastonbury

;; Author: Dan Glastonbury (dan.glastonbury@gmail.com)
;; Version: 1.0.0
;; Created: 4 Apr 2020
;; Keywords: languages
;; Homepage: http://github.com/djg/sleigh-mode

;; This file is not part of GNU Emacs.

;;; License:

;; You can redistribute this program and/or modify it under the terms of the GNU
;; General Public License version 2.

;;; Commentary:

;; short description here

;; full doc on how to use here

;;; Code:

(defvar sleigh-mode-syntax-table nil "Syntax table for `sleigh-mode'.")

(setq -mode-syntax-table
      (let ( (table (make-syntax-table)))
        ;; comment: “# …”
        (modify-syntax-entry ?# "<" table)
        (modify-syntax-entry ?\n ">" table)
        table))

;; create the list for font-lock.
;; each category of keyword is given a particular face
(setq sleigh-font-lock-keywords
      (let* (
             ;; define several category of keywords
             (x-keywords
              '("is" "with" "alignment" "attach" "big" "bitrange" "build" "call" "context"
                "crossbuild" "dec" "default" "define" "endian" "export" "goto" "hex" "little"
                "local" "macro" "names" "noflow" "offset" "pcodeop" "return" "signed" "size"
                "space" "token" "type" "unimpl" "values" "variables" "wordsize" "if"))
             (x-types '("const" "ram" "register"))
             ;;(x-constants '("ACTIVE" "AGENT" "ALL_SIDES" "ATTACH_BACK"))
             ;;(x-events '("at_rot_target" "at_target" "attach"))
             (x-functions '("sext" "zext" "carry" "scarry" "sborrow" "nan" "abs" "sqrt" "int2float"
                            "float2float" "trunc" "ceil" "floor" "round" "cpool" "newobject"))
             (x-preprocessor '("@include" "@define" "@undef" "@ifdef" "@ifndef"
                               "@if" "@elif" "@endif" "@else"))
             
             ;; generate regex string for each category of keywords
             (x-keywords-regexp (regexp-opt x-keywords 'words))
             (x-types-regexp (regexp-opt x-types 'words))
             ;;(x-constants-regexp (regexp-opt x-constants 'words))
             ;;(x-events-regexp (regexp-opt x-events 'words))
             (x-functions-regexp (regexp-opt x-functions 'words))
             (x-functions-regexp (regexp-opt x-preprocessor 'words)))
        
        `(
          (,x-types-regexp . font-lock-type-face)
          ;;(,x-constants-regexp . font-lock-constant-face)
          ;;(,x-events-regexp . font-lock-builtin-face)
          (,x-functions-regexp . font-lock-preprocessor-face)
          (,x-functions-regexp . font-lock-function-name-face)
          (,x-keywords-regexp . font-lock-keyword-face)
          ;; note: order above matters, because once colored, that part won't change.
          ;; in general, put longer words first
          )))

;;;###autoload (add-to-list 'auto-mode-alist '("\\.slaspec\\'" . sleigh-mode))
;;;###autoload (add-to-list 'auto-mode-alist '("\\.sinc\\'" . sleigh-mode))
;;;###autoload
(define-derived-mode sleigh-mode prog-mode "Sleigh"
  "Major mode for editing Ghidra sleigh files"
  
  (setq-local comment-start "# ")
  (setq-local comment-start-skip "#+[\t ]*")
  (setq-local comment-end "")
  
  ;; code for syntax highlighting
  (setq font-lock-defaults '((sleigh-font-lock-keywords))))

;; add the mode to the `features' list
(provide 'sleigh-mode)

;;; sleigh-mode.el ends here
