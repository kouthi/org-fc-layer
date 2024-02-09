;;; packages.el --- org-fc layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2022 Sylvain Benner & Contributors
;;
;; Author: kouthi <kouthi@users.noreply.github.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `org-fc-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `org-fc/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `org-fc/pre-init-PACKAGE' and/or
;;   `org-fc/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

;; ************************************************************
;; org-fc official manual explains how to setup with Spacemacs:
;; https://www.leonrische.me/fc/installation.html
;; ************************************************************

(defconst org-fc-packages
  '((org-fc :location (recipe :fetcher git
                             :url "https://git.sr.ht/~l3kn/org-fc"
                             :files (:defaults "awk" "demo.org"))))
  "The list of Lisp packages required by the org-fc layer.

Each entry is either:

1. A symbol, which is interpreted as a package to be installed, or

2. A list of the form (PACKAGE KEYS...), where PACKAGE is the
    name of the package to be installed or loaded, and KEYS are
    any number of keyword-value-pairs.

    The following keys are accepted:

    - :excluded (t or nil): Prevent the package from being loaded
      if value is non-nil

    - :location: Specify a custom installation location.
      The following values are legal:

      - The symbol `elpa' (default) means PACKAGE will be
        installed using the Emacs package manager.

      - The symbol `local' directs Spacemacs to load the file at
        `./local/PACKAGE/PACKAGE.el'

      - A list beginning with the symbol `recipe' is a melpa
        recipe.  See: https://github.com/milkypostman/melpa#recipe-format")

(defun org-fc/init-org-fc ()
  (use-package hydra)
  (require 'org-fc-hydra)
  (setq org-fc-directories '("~/onedrive/" "~/fc/"))
  (setq org-fc-review-history-file '"~/onedrive/org-fc-reviews.tsv")

  ;; leader key
  (spacemacs/set-leader-keys ",," 'org-fc-hydra/body)
  (spacemacs/set-leader-keys ",n" 'org-fc-type-normal-init)
  (spacemacs/set-leader-keys ",t" 'org-fc-type-text-input-init)
  (spacemacs/set-leader-keys ",d" 'org-fc-type-double-init)
  (spacemacs/set-leader-keys ",c" 'org-fc-type-cloze-init)
  (spacemacs/set-leader-keys ",r" 'org-fc-review)

  ;; minor-mode key
  (evil-define-minor-mode-key '(normal insert emacs) 'org-fc-review-flip-mode
    (kbd "RET") 'org-fc-review-flip
    (kbd "f") 'org-fc-review-flip
    (kbd "q") 'org-fc-review-quit
    (kbd "p") 'org-fc-review-edit
    (kbd "s") 'org-fc-review-suspend-card)
  (evil-define-minor-mode-key '(normal insert emacs) 'org-fc-review-rate-mode
    (kbd "a") 'org-fc-review-rate-again
    (kbd "h") 'org-fc-review-rate-hard
    (kbd "j") 'org-fc-review-rate-good
    (kbd "e") 'org-fc-review-rate-easy
    (kbd "s") 'org-fc-review-suspend-card
    (kbd "p") 'org-fc-review-edit
    (kbd "q") 'org-fc-review-quit))
