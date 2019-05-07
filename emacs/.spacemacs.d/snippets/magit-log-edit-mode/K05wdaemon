;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; To prevent the message "Gnus auto-save file exists.  Do you want
;; to read it?" every time you start gnus, make sure you exit Gnus
;; via ‘q’ in group buffer instead of just killing Emacs.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'gnus)
(require 'gnus-agent)
(require 'nnir) ;; search
(require 'gnus-demon)
(require 'smtpmail)
(require 'nnimap)
(require 'starttls)

;; encoding
(setq gnus-default-charset 'utf-8)
;; base one the Group name
(setq gnus-group-name-charset-group-alist
      '((".*" . gbk)))
(setq gnus-summary-show-article-charset-alist
      '((1 . gbk)
        (2 . utf-8)
        (3 . big5)
        (4 . utf-7)))

;; Article cache
;; https://www.gnu.org/software/emacs/manual/html_node/gnus/Article-Caching.html#Article-Caching
;; gnus-jog-cache, gnus-cacheable-groups
;; By default, all articles ticked(M t or ! to tick a article) or
;; marked as dormant(M ? or ?) will then be copied over to your local cache
;; (gnus-cache-directory).
(setq gnus-use-cache t)
(setq gnus-use-adaptive-scoring t)
(setq gnus-save-score t)
(add-hook 'mail-citation-hook 'sc-cite-original)
(add-hook 'message-sent-hook 'gnus-score-followup-article)
(add-hook 'message-sent-hook 'gnus-score-followup-thread)
;; @see http://stackoverflow.com/questions/945419/how-dont-use-gnus-adaptive-scoring-in-some-newsgroups
(setq gnus-use-scoring nil)
(defvar gnus-default-adaptive-score-alist
  '((gnus-kill-file-mark (from -10))
    (gnus-unread-mark)
    (gnus-read-mark (from 10) (subject 30))
    (gnus-catchup-mark (subject -10))
    (gnus-killed-mark (from -1) (subject -30))
    (gnus-del-mark (from -2) (subject -15))
    (gnus-ticked-mark (from 10))
    (gnus-dormant-mark (from 5))))
(setq  gnus-score-find-score-files-function
       '(gnus-score-find-hierarchical gnus-score-find-bnews bbdb/gnus-score)
       )

;; places
(setq gnus-startup-file "~/Gnus/.newsrc")
;; (setq gnus-init-file "~/Gnus/.gnus")
(setq gnus-default-directory "~/Gnus/")
(setq gnus-home-directory "~/Gnus/")
(setq gnus-dribble-directory "~/Gnus/")
(setq gnus-directory "~/Gnus/News/")
(setq gnus-article-save-directory "~/Gnus/News/")
(setq gnus-kill-files-directory "~/Gnus/News/trash/")
(setq gnus-agent-directory "~/Gnus/News/agent/")
(setq gnus-cache-directory "~/Gnus/News/cache/")
(setq gnus-cache-active-file "~/Gnus/News/cache/active")
(setq message-directory "~/Gnus/Mail/")
(setq message-auto-save-directory "~/Gnus/Mail/drafts")
(setq mail-source-directory "~/Gnus/Mail/incoming")
(setq mml-default-directory "~/Gnus/attachment/")
(setq nnml-newsgroups-file "~/Gnus/Mail/newsgroup")
(setq nntp-marks-directory "~/Gnus/News/marks")
(setq nnmail-message-id-cache-file "~/Gnus/.nnmail-cache")


;; built-in epa-file for encrypting file.gpg file when saveing it
(require 'epa-file)
(epa-file-enable)
;; ask encryption password once
(setq epa-file-cache-passphrase-for-symmetric-encryption t)

;; http://www.cataclysmicmutation.com/2010/11/multiple-gmail-accounts-in-gnus/
(setq user-mail-address "cody.chan.cz@gmail.com"
      user-full-name "Cody Chan")
(setq gnus-select-method
      '(nnimap "co"
               (nnimap-address "imap.gmail.com")
               (nnimap-server-port 993)
               (nnimap-stream ssl)
               (nnimap-authinfo-file "~/.authinfo.gpg")
               (nnir-search-engine imap)
               ))
;; (add-to-list 'gnus-secondary-select-methods
;;              '(nnimap "ch"
;;                       (nnimap-address "imap.gmail.com")
;;                       (nnimap-server-port 993)
;;                       (nnimap-stream ssl)
;;                       (nnimap-authinfo-file "~/.authinfo.gpg")
;;                       (nnir-search-engine imap)
;;                       ))

;; more user friendly layout for your email client
;; https://www.gnu.org/software/emacs/manual/html_node/gnus/Window-Layout.html
(gnus-add-configuration
 '(article
   (horizontal 1.0
               (vertical 40 (group 1.0))
               (vertical 1.0
                         (summary 0.16 point)
                         (article 1.0)))))
(gnus-add-configuration
 '(summary
   (horizontal 1.0
               (vertical 40 (group 1.0))
               (vertical 1.0 (summary 1.0 point)))))

;; show all the mails even read ones
(setq gnus-parameters '((".*" (display . all))))

;; make the newsgroup name look better
(setq gnus-group-sort-function
	  ;; Use `G S ...` to change sort order
      '(gnus-group-sort-by-alphabet gnus-group-sort-by-level))
(defun group-sort ()
  (interactive)
  (gnus-group-sort-groups gnus-group-sort-function nil))
(defun group-sort-one-key ()
  ;; Sometimes it's not sorted right, and typing "G S s" is a pain.
  (if (eq (key-binding "`") 'undefined)
      (local-set-key "`" 'group-sort)
    (message "Key ` has a binding, believe it or not.")))
(add-hook 'gnus-group-mode-hook 'group-sort)
(add-hook 'gnus-group-mode-hook 'group-sort-one-key)

(setq gnus-group-line-format "%M%S%6y/%-6t: %uG %D\n")
;; 1.
(defun gnus-user-format-function-G (arg)
  (concat (car (cdr gnus-tmp-method)) ":"
          (or (gnus-group-find-parameter gnus-tmp-group 'display-name)
              (let ((prefix (assq 'remove-prefix (cddr gnus-tmp-method))))
                (if (and prefix
                         (string-match (concat "^\\("
                                               (regexp-quote (cadr prefix))
                                               "\\)")
                                       gnus-tmp-qualified-group))
                    (substring gnus-tmp-qualified-group (match-end 1))
                  gnus-tmp-qualified-group)))))

;; Show all mail groups
(setq gnus-permanently-visible-groups "^nn.*")
;;(setq gnus-permanently-visible-groups ".*")
(add-hook 'gnus-topic-mode-hook 'gnus-topic-mode)
(setq gnus-ignored-newsgroups "^to\\.\\|^[0-9. ]+\\( \\|$\\)\\|^[\”]\”[#’()]")

(setq  smtpmail-auth-credentials
       (expand-file-name "~/.authinfo.gpg")
 ;; smtpmail-auth-credentials "~/.authinfo.gpg"
      smtpmail-smtp-server "smtp.gmail.com"
      smtpmail-default-smtp-server "smtp.gmail.com"
      send-mail-function 'smtpmail-send-it
      message-send-mail-function 'smtpmail-send-it
      smtpmail-smtp-service 587
      starttls-use-gnutls t)

;; (setq gnus-outgoing-message-group "[Google Mail]/Sent Mail")
(setq gnus-extract-address-components
      'mail-extract-address-components)

(require 'bbdb)
(bbdb-initialize 'gnus 'message)
(add-hook 'gnus-startup-hook 'bbdb-insinuate-gnus)
(add-hook 'message-mode-hook
          '(lambda ()
             (flyspell-mode 1)
             (bbdb-initialize 'message)
             (bbdb-initialize 'gnus)
             (local-set-key "<TAB>" 'bbdb-complete-name)))

;; (require 'bbdb)
;; (bbdb-initialize)
;; (add-hook 'gnus-startup-hook 'bbdb-insinuate-gnus)
;; (add-hook 'gnus-startup-hook 'bbdb-insinuate-message)

(setq gnus-summary-mark-below 0)

;;
(setq gnus-user-date-format-alist				 ;date en relatif (de gyom)
      '(((gnus-seconds-today) . "     %k:%M")	 ;dans la journée = 14:39
        ((+ 86400 (gnus-seconds-today)) . "Yest %k:%M") ;hier = hier 14:39
        ((+ 604800 (gnus-seconds-today)) . "%a %k:%M") ;dans la semaine = sam 14:39
        ((gnus-seconds-month) . "%a %d")		 ;ce mois  = sam 28
        ((gnus-seconds-year) . "%d %b")			 ;durant l'année = mai 28
        (t . "%d %b '%y"))						 ;le reste = mai 28 '05
      gnus-inhibit-startup-message t ; hide the startup image

      ;; http://www.emacswiki.org/emacs/GnusSpeed
      gnus-use-correct-string-widths nil
      gc-cons-threshold 3500000         ; fasten gnus

      gnus-use-cross-reference t
      message-confirm-send t
      mm-inline-large-images t

      gnus-show-threads t
      gnus-thread-indent-level 2        ;threads indentation

      ;; http://www.gnu.org/software/emacs/manual/html_node/gnus/Sorting-the-Summary-Buffer.html
      gnus-article-sort-functions '((not gnus-article-sort-by-date)
                                    (not gnus-article-sort-by-number))
      gnus-thread-sort-functions  '((not gnus-thread-sort-by-date)
                                    (not gnus-thread-sort-by-number)
                                    ;; (gnus-thread-sort-by-most-recent-date)
                                    ) ;using numbers is faster and similar:

      gnus-summary-line-format "%U%R%z %12&user-date; %(%[%-30,30f%]%) %B %s\n"
      gnus-summary-same-subject ""

      gnus-use-trees nil		;no thread tree buffers
      gnus-thread-hide-subtree t	;auto collapse

      gnus-sum-thread-tree-indent          "  "
      gnus-sum-thread-tree-root            "● "
      gnus-sum-thread-tree-false-root      "◎ "
      gnus-sum-thread-tree-single-indent   "◯ "
      gnus-sum-thread-tree-leaf-with-other "├─► "
      gnus-sum-thread-tree-vertical        "│ "
      gnus-sum-thread-tree-single-leaf     "╰─► "

      ;; Yay (seen here: `https://github.com/cofi/dotfiles/blob/master/gnus.el')
      gnus-cached-mark ?☍
      gnus-canceled-mark ?↗
      gnus-del-mark ?✗
      gnus-dormant-mark ?⚐
      gnus-expirable-mark ?♻
      gnus-forwarded-mark ?↪
      gnus-killed-mark ?☠
      gnus-process-mark ?⚙
      gnus-read-mark ?✓
      gnus-recent-mark ?✩
      gnus-replied-mark ?↺
      gnus-unread-mark ?✉
      gnus-unseen-mark ?★
      gnus-ticked-mark ?⚑
      )

(define-key gnus-summary-mode-map "-" 'gnus-summary-hide-thread)
(define-key gnus-summary-mode-map "+" 'gnus-summary-show-thread)

;; Enable mailinglist support
(when (fboundp 'turn-on-gnus-mailing-list-mode)
  (add-hook 'gnus-summary-mode-hook 'turn-on-gnus-mailing-list-mode))

;; check for new messages, notification for new
;; Auto refresh 10 mins
(gnus-demon-add-handler 'gnus-demon-scan-mail 5 1)
(add-hook 'gnus-after-getting-new-news-hook 'gnus-notifications)
;; mode line email icon
(defface display-time-mail-face
  '((t (:background "red")))
  "If display-time-use-mail-icon is non-nil, its background colour is that of
  this face. Should be distinct from mode-line. Note that this deos not seem
  to affect display-time-mail-string as claimed"
  )
(require 'time)
(setq
 display-time-mail-file "/var/mail/chz"
 display-time-use-mail-icon t
 display-time-mail-face 'display-time-mail-face)
(setq display-time-mail-icon
    '(image :type png :file "~/.emacs.d/email.png" :ascent center))

;; kill the buffer after successful sending instead of keeping it alive as "Sent mail to..."
(setq message-kill-buffer-on-exit t)

;; follow up
(add-hook 'message-sent-hook 'gnus-score-followup-article)
(add-hook 'message-sent-hook 'gnus-score-followup-thread)

(setq gnus-large-newsgroup nil
      nnmail-treat-duplicates 'delete)

;; use w3m to show the html content
;; install w3m, mew in terminal first
(require 'w3m)
(setq mm-text-html-renderer 'w3m)

;; Also, I prefer to see only the top level message.  If a message has
;; several replies or is part of a thread, only show the first
;; message.  'gnus-thread-ignore-subject' will ignore the subject and
;; look at 'In-Reply-To:' and 'References:' headers.
(setq gnus-thread-hide-subtree t)
(setq gnus-thread-ignore-subject t)

;; ;; notify
;; (require 'gnus-notify+)
;; (add-hook 'gnus-summary-exit-hook 'gnus-notify+)
;; (add-hook 'gnus-group-catchup-group-hook 'gnus-notify+)
;; (add-hook 'mail-notify-pre-hook 'gnus-notify+)

(provide 'init-gnus)
