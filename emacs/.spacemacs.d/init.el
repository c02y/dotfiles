;; -*- mode: emacs-lisp; lexical-binding: t -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.
;; and original template file is
;; ~/.emacs.d/core/templates/.spacemacs.template
;; diff them using `SPC f e D'

(defun dotspacemacs/layers ()
  "Layer configuration:
This function should only modify configuration layer settings."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs

   ;; Lazy installation of layers (i.e. layers are installed only when a file
   ;; with a supported type is opened). Possible values are `all', `unused'
   ;; and `nil'. `unused' will lazy install only unused layers (i.e. layers
   ;; not listed in variable `dotspacemacs-configuration-layers'), `all' will
   ;; lazy install any layer that support lazy installation even the layers
   ;; listed in `dotspacemacs-configuration-layers'. `nil' disable the lazy
   ;; installation feature and you have to explicitly list a layer in the
   ;; variable `dotspacemacs-configuration-layers' to install it.
   ;; (default 'unused)
   dotspacemacs-enable-lazy-installation 'unused

   ;; If non-nil then Spacemacs will ask for confirmation before installing
   ;; a layer lazily. (default t)
   dotspacemacs-ask-for-lazy-installation t

   ;; If non-nil layers with lazy install support are lazy installed.
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()

   ;; List of configuration layers to load.
   dotspacemacs-configuration-layers
   '(markdown
     vimscript
     ;; ----------------------------------------------------------------
     ;; Example of useful layers you may want to use right away.
     ;; Uncomment some layer names and press `SPC f e R' (Vim style) or
     ;; `M-m f e R' (Emacs style) to install them.
     ;; ----------------------------------------------------------------
     (auto-completion :variables
                      auto-completion-enable-snippets-in-popup t
                      auto-completion-enable-help-tooltip t
                      auto-completion-enable-sort-by-usage t
                      )
     better-defaults
     emacs-lisp
     ;; `pip install importmagic epc' after the python layer is installed
     python
     git
     helm
     ;; markdown
     ;; replace multiple-cursors with symbol-overlay
     ;; multiple-cursors
     org
     ;; (shell :variables
     ;;        shell-default-height 30
     ;;        shell-default-position 'bottom)
     spell-checking
     syntax-checking
     semantic
     shell-scripts
     treemacs
     (version-control :variables
                      version-control-diff-tool 'git-gutter
                      version-control-diff-side 'left
                      )
     (evil-snipe :variables evil-snipe-enable-alternate-f-and-t-behaviors t)
     ;; install ccls binary first
     (c-c++ :variables
            c-c++-adopt-subprojects t
            c-c++-backend 'lsp-ccls
            ;; just get rid of the warning message
            c-c++-lsp-cache-dir "~/.emacs.d/.cache/lsp-ccls"
            )
     lsp
     ;; M-x dap-gdb-lldb-setup after packages are installed by dap layer
     dap
     )

   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   ;; To use a local version of a package, use the `:location' property:
   ;; '(your-package :location "~/path/to/your-package/")
   ;; Also include the dependencies as they will not be resolved automatically.
   dotspacemacs-additional-packages '(
                                      highlight-indent-guides
                                      electric-operator
                                      syntax-subword
                                      comment-dwim-2
                                      (cool-moves :location (recipe :fetcher github :repo "mrbig033/cool-moves"))
                                      )

   ;; A list of packages that cannot be updated.
   dotspacemacs-frozen-packages '()

   ;; A list of packages that will not be installed and loaded.
   dotspacemacs-excluded-packages '(
                                    google-c-style
                                    auto-highlight-symbol
                                    git-gutter+
                                    git-gutter-fringe
                                    git-gutter-fringe+
                                    )

   ;; Defines the behaviour of Spacemacs when installing packages.
   ;; Possible values are `used-only', `used-but-keep-unused' and `all'.
   ;; `used-only' installs only explicitly used packages and deletes any unused
   ;; packages as well as their unused dependencies. `used-but-keep-unused'
   ;; installs only the used packages but won't delete unused ones. `all'
   ;; installs *all* packages supported by Spacemacs and never uninstalls them.
   ;; (default is `used-only')
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/init ()
  "Initialization:
This function is called at the very beginning of Spacemacs startup,
before layer configuration.
It should only modify the values of Spacemacs settings."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; If non-nil then enable support for the portable dumper. You'll need
   ;; to compile Emacs 27 from source following the instructions in file
   ;; EXPERIMENTAL.org at to root of the git repository.
   ;; (default nil)
   dotspacemacs-enable-emacs-pdumper nil

   ;; File path pointing to emacs 27.1 executable compiled with support
   ;; for the portable dumper (this is currently the branch pdumper).
   ;; (default "emacs-27.0.50")
   dotspacemacs-emacs-pdumper-executable-file "emacs-27.0.50"

   ;; Name of the Spacemacs dump file. This is the file will be created by the
   ;; portable dumper in the cache directory under dumps sub-directory.
   ;; To load it when starting Emacs add the parameter `--dump-file'
   ;; when invoking Emacs 27.1 executable on the command line, for instance:
   ;;   ./emacs --dump-file=~/.emacs.d/.cache/dumps/spacemacs.pdmp
   ;; (default spacemacs.pdmp)
   dotspacemacs-emacs-dumper-dump-file "spacemacs.pdmp"

   ;; If non-nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https t

   ;; Maximum allowed time in seconds to contact an ELPA repository.
   ;; (default 5)
   dotspacemacs-elpa-timeout 5

   ;; Set `gc-cons-threshold' and `gc-cons-percentage' when startup finishes.
   ;; This is an advanced option and should not be changed unless you suspect
   ;; performance issues due to garbage collection operations.
   ;; (default '(100000000 0.1))
   dotspacemacs-gc-cons '(100000000 0.1)

   ;; If non-nil then Spacelpa repository is the primary source to install
   ;; a locked version of packages. If nil then Spacemacs will install the
   ;; latest version of packages from MELPA. (default nil)
   dotspacemacs-use-spacelpa nil

   ;; If non-nil then verify the signature for downloaded Spacelpa archives.
   ;; (default nil)
   dotspacemacs-verify-spacelpa-archives nil

   ;; If non-nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. Note that checking for
   ;; new versions works via git commands, thus it calls GitHub services
   ;; whenever you start Emacs. (default nil)
   dotspacemacs-check-for-update nil

   ;; If non-nil, a form that evaluates to a package directory. For example, to
   ;; use different package directories for different Emacs versions, set this
   ;; to `emacs-version'. (default 'emacs-version)
   dotspacemacs-elpa-subdirectory 'emacs-version

   ;; One of `vim', `emacs' or `hybrid'.
   ;; `hybrid' is like `vim' except that `insert state' is replaced by the
   ;; `hybrid state' with `emacs' key bindings. The value can also be a list
   ;; with `:variables' keyword (similar to layers). Check the editing styles
   ;; section of the documentation for details on available variables.
   ;; (default 'vim)
   dotspacemacs-editing-style '(hybrid :variables
                                       hybrid-style-visual-feedback t)

   ;; If non-nil output loading progress in `*Messages*' buffer. (default nil)
   dotspacemacs-verbose-loading nil

   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner nil

   ;; List of items to show in startup buffer or an association list of
   ;; the form `(list-type . list-size)`. If nil then it is disabled.
   ;; Possible values for list-type are:
   ;; `recents' `bookmarks' `projects' `agenda' `todos'.
   ;; List sizes may be nil, in which case
   ;; `spacemacs-buffer-startup-lists-length' takes effect.
   dotspacemacs-startup-lists '((recents . 10)
                                (projects . 10))

   ;; True if the home buffer should respond to resize events. (default t)
   dotspacemacs-startup-buffer-responsive t

   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'lisp-interaction-mode

   ;; Initial message in the scratch buffer, such as "Welcome to Spacemacs!"
   ;; (default nil)
   dotspacemacs-initial-scratch-message nil

   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press `SPC T n' to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(spacemacs-dark
                         spacemacs-light)

   ;; Set the theme for the Spaceline. Supported themes are `spacemacs',
   ;; `all-the-icons', `custom', `doom', `vim-powerline' and `vanilla'. The
   ;; first three are spaceline themes. `doom' is the doom-emacs mode-line.
   ;; `vanilla' is default Emacs mode-line. `custom' is a user defined themes,
   ;; refer to the DOCUMENTATION.org for more info on how to create your own
   ;; spaceline theme. Value can be a symbol or list with additional properties.
   ;; (default '(spacemacs :separator wave :separator-scale 1.5))
   ;; dotspacemacs-mode-line-theme '(spacemacs :separator wave :separator-scale 1.5)
   dotspacemacs-mode-line-theme 'custom

   ;; If non-nil the cursor color matches the state color in GUI Emacs.
   ;; (default t)
   dotspacemacs-colorize-cursor-according-to-state t

   ;; Default font, or prioritized list of fonts. `powerline-scale' allows to
   ;; quickly tweak the mode-line size to make separators look not too crappy.
   dotspacemacs-default-font '("PragmataPro"
                               :size 14.5
                               :weight normal
                               :width normal)

   ;; The leader key (default "SPC")
   dotspacemacs-leader-key "SPC"

   ;; The key used for Emacs commands `M-x' (after pressing on the leader key).
   ;; (default "SPC")
   dotspacemacs-emacs-command-key "SPC"

   ;; The key used for Vim Ex commands (default ":")
   dotspacemacs-ex-command-key ":"

   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"

   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","

   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m")
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"

   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs `C-i', `TAB' and `C-m', `RET'.
   ;; Setting it to a non-nil value, allows for separate commands under `C-i'
   ;; and TAB or `C-m' and `RET'.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil

   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"

   ;; If non-nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil

   ;; If non-nil then the last auto saved layouts are resumed automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil

   ;; If non-nil, auto-generate layout name when creating new layouts. Only has
   ;; effect when using the "jump to layout by number" commands. (default nil)
   dotspacemacs-auto-generate-layout-names nil

   ;; Size (in MB) above which spacemacs will prompt to open the large file
   ;; literally to avoid performance issues. Opening a file literally means that
   ;; no major mode or minor modes are active. (default is 1)
   dotspacemacs-large-file-size 1

   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache

   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 5

   ;; If non-nil, the paste transient-state is enabled. While enabled, after you
   ;; paste something, pressing `C-j' and `C-k' several times cycles through the
   ;; elements in the `kill-ring'. (default nil)
   dotspacemacs-enable-paste-transient-state nil

   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.2

   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom

   ;; Control where `switch-to-buffer' displays the buffer. If nil,
   ;; `switch-to-buffer' displays the buffer in the current window even if
   ;; another same-purpose window is available. If non-nil, `switch-to-buffer'
   ;; displays the buffer in a same-purpose window even if the buffer can be
   ;; displayed in the current window. (default nil)
   dotspacemacs-switch-to-buffer-prefers-purpose nil

   ;; If non-nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar nil

   ;; If non-nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil

   ;; If non-nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil

   ;; If non-nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup nil

   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90

   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 40

   ;; If non-nil show the titles of transient states. (default t)
   dotspacemacs-show-transient-state-title t

   ;; If non-nil show the color guide hint for transient state keys. (default t)
   dotspacemacs-show-transient-state-color-guide t

   ;; If non-nil unicode symbols are displayed in the mode line.
   ;; If you use Emacs as a daemon and wants unicode characters only in GUI set
   ;; the value to quoted `display-graphic-p'. (default t)
   dotspacemacs-mode-line-unicode-symbols nil

   ;; If non-nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters point
   ;; when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t

   ;; Control line numbers activation.
   ;; If set to `t' or `relative' line numbers are turned on in all `prog-mode' and
   ;; `text-mode' derivatives. If set to `relative', line numbers are relative.
   ;; This variable can also be set to a property list for finer control:
   ;; '(:relative nil
   ;;   :disabled-for-modes dired-mode
   ;;                       doc-view-mode
   ;;                       markdown-mode
   ;;                       org-mode
   ;;                       pdf-view-mode
   ;;                       text-mode
   ;;   :size-limit-kb 1000)
   ;; (default nil)
   dotspacemacs-line-numbers nil

   ;; Code folding method. Possible values are `evil' and `origami'.
   ;; (default 'evil)
   dotspacemacs-folding-method 'evil

   ;; If non-nil `smartparens-strict-mode' will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode t

   ;; If non-nil pressing the closing parenthesis `)' key in insert mode passes
   ;; over any automatically added closing parenthesis, bracket, quote, etc…
   ;; This can be temporary disabled by pressing `C-q' before `)'. (default nil)
   dotspacemacs-smart-closing-parenthesis t

   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all

   ;; If non-nil, start an Emacs server if one is not already running.
   ;; (default nil)
   dotspacemacs-enable-server nil

   ;; Set the emacs server socket location.
   ;; If nil, uses whatever the Emacs default is, otherwise a directory path
   ;; like \"~/.emacs.d/server\". It has no effect if
   ;; `dotspacemacs-enable-server' is nil.
   ;; (default nil)
   dotspacemacs-server-socket-dir nil

   ;; If non-nil, advise quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil

   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `rg', `ag', `pt', `ack' and `grep'.
   ;; (default '("rg" "ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("rg" "ag" "pt" "ack" "grep")

   ;; Format specification for setting the frame title.
   ;; %a - the `abbreviated-file-name', or `buffer-name'
   ;; %t - `projectile-project-name'
   ;; %I - `invocation-name'
   ;; %S - `system-name'
   ;; %U - contents of $USER
   ;; %b - buffer name
   ;; %f - visited file name
   ;; %F - frame name
   ;; %s - process status
   ;; %p - percent of buffer above top of window, or Top, Bot or All
   ;; %P - percent of buffer above bottom of window, perhaps plus Top, or Bot or All
   ;; %m - mode name
   ;; %n - Narrow if appropriate
   ;; %z - mnemonics of buffer, terminal, and keyboard coding systems
   ;; %Z - like %z, but including the end-of-line format
   ;; (default "%I@%S")
   dotspacemacs-frame-title-format "%b:%p @%S"

   ;; Format specification for setting the icon title format
   ;; (default nil - same as frame-title-format)
   dotspacemacs-icon-title-format nil

   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed' to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup nil

   ;; Either nil or a number of seconds. If non-nil zone out after the specified
   ;; number of seconds. (default nil)
   dotspacemacs-zone-out-when-idle nil

   ;; Run `spacemacs/prettify-org-buffer' when
   ;; visiting README.org files of Spacemacs.
   ;; (default nil)
   dotspacemacs-pretty-docs nil))

(defun dotspacemacs/user-env ()
  "Environment variables setup.
This function defines the environment variables for your Emacs session. By
default it calls `spacemacs/load-spacemacs-env' which loads the environment
variables declared in `~/.spacemacs.env' or `~/.spacemacs.d/.spacemacs.env'.
See the header of this file for more information."
  (spacemacs/load-spacemacs-env))

(defun dotspacemacs/user-init ()
  "Initialization for user code:
This function is called immediately after `dotspacemacs/init', before layer
configuration.
It is mostly for variables that should be set before packages are loaded.
If you are unsure, try setting them in `dotspacemacs/user-config' first."
  (setq evil-normal-state-tag "NORMAL")
  (setq evil-emacs-state-tag "EMACS")
  (setq evil-hybrid-state-tag "HYBRID")
  (setq evil-insert-state-tag "INSERT")
  (setq evil-visual-state-tag "VISUAL")
  (setq evil-lisp-state-tag "LISP")
  (setq evil-motion-state-tag "MOTION")
  (setq evil-operator-state-tag "OPERATOR")
  (setq evil-replace-state-tag "REPLACE")
  (setq evil-evilified-state-tag "EVIL")

  (defun spaceline-custom-theme (&rest additional-segments)
    "My custom spaceline theme, just add state indicators line before window-number in the mode.
https://github.com/syl20bnr/spacemacs/issues/12346"
    (spaceline-compile
      ;; left side
      '(((evil-state
          persp-name
          workspace-number
          window-number)
         :fallback evil-state
         :face highlight-face
         :priority 100)
        (anzu :priority 95)
        auto-compile
        ((buffer-modified buffer-size buffer-id remote-host)
         :priority 98)
        (major-mode :priority 79)
        (process :when active)
        ((flycheck-error flycheck-warning flycheck-info)
         :when active
         :priority 89)
        (minor-modes :when active
                     :priority 9)
        (mu4e-alert-segment :when active)
        (erc-track :when active)
        (version-control :when active
                         :priority 78)
        (org-pomodoro :when active)
        (org-clock :when active)
        nyan-cat)
      ;; right side
      '(which-function
        (python-pyvenv :fallback python-pyenv)
        (purpose :priority 94)
        (battery :when active)
        (selection-info :priority 95)
        input-method
        ((buffer-encoding-abbrev
          point-position
          line-column)
         :separator " | "
         :priority 96)
        (global :when active)
        (buffer-position :priority 99)
        (hud :priority 99)))
    (setq-default mode-line-format '("%e" (:eval (spaceline-ml-main)))))
  )

(defun dotspacemacs/user-load ()
  "Library to load while dumping.
This function is called only while dumping Spacemacs configuration. You can
`require' or `load' the libraries of your choice that will be included in the
dump."
  )

(defun dotspacemacs/user-config ()
  "Configuration for user code:
This function is called at the very end of Spacemacs startup, after layer
configuration.
Put your configuration code here, except for variables that should be set
before packages are loaded."
  ;; encode system
  ;; encode, the last line will be the highest priority
  (set-language-environment 'UTF-8)
  ;; this the current file is not utf-8, when saving it, it will prompt to select
  ;; the coding system, use this following line to choose utf-8 always
  (setq coding-system-for-write 'utf-8)
  (setq-default path-coding-system 'utf-8)
  (setq file-name-coding-system 'utf-8)
  (prefer-coding-system 'cp950)
  (prefer-coding-system 'gb2312)
  (prefer-coding-system 'cp936)
  (prefer-coding-system 'gb18030)
  ;;(prefer-coding-system 'utf-16le-with-signature)
  (prefer-coding-system 'utf-16)
  (prefer-coding-system 'utf-8)

  ;; disable scroll-bar-mode in newly created frame
  ;; This also fix the bug when scroll bar still shows in daemon/emacsclient
  (add-hook 'after-make-frame-functions
            '(lambda (frame)
               (modify-frame-parameters
                frame
                '((vertical-scroll-bars . nil)
                  (horizontal-scroll-bars . nil)))))

  ;; prevent package-selected-package list been created
  (defun package--save-selected-packages (&rest opt) nil)
  (add-hook 'after-init-hook 'global-company-mode)

  ;; set the font, don't have touch dotspacemacs-default-font
  ;; even touched without this following line, font may not work for daemon/emacsclient
  (setq default-frame-alist '((font . "PragmataPro-14.5")))
  (setq-default
   ;; always show trailing whitespace, spacemacs only it in prog-mode by default
   ;; show-trailing-whitespace t
   ;; change the major mode of any file without extension to org-mode instead of fundamental-mode
   major-mode 'org-mode)
  (setq
   ;; open a link not prompt yes/no
   vc-follow-symlinks t
   ;; disable the warning message
   python-spacemacs-indent-guess nil
   ;; spacemacs change it to blank, change it to use last words if no thing-at-point
   ;; helm-swoop-pre-input-function
   ;; (lambda ()
   ;;   (let (($pre-input (thing-at-point 'symbol)))
   ;;     (if (eq (length $pre-input) 0)
   ;;         (if (boundp 'helm-swoop-pattern)
   ;;             helm-swoop-pattern ;; this variable keeps the last used words
   ;;           "") ;; first time helm-swoop and no thing at point
   ;;       $pre-input)))
   company-minimum-prefix-length 1
   company-show-numbers t
   company-tooltip-limit 20
   bookmark-default-file "~/.spacemacs.d/bookmarks"
   ;; make cursor the width of the character it is under i.e. full width of a TAB
   x-stretch-cursor t
   ;; which-key
   which-key-show-remaining-keys t
   which-key-highlighted-command-list
   '("helm\\|toggle\\|projectile\\|describe"
     ("\\(^cscope\\)\\|\\(^ggtags\\)" . warning)
     ("register\\|transient\\|hydra" . success)
     ("rectangle\\|goto\\|lsp\\|xah" . error)
     ("help\\|emacs\\|bookmarks" . highlight)
     )
   comment-dwim-2--inline-comment-behavior 'reindent-comment
   )

  ;; Removing duplicated lines
  ;; Note that the last line should contain the EOF
  (defun delete-duplicated-lines-buffer-or-region (beg end)
    "Unique lines in region.
Called from a program, there are two arguments:
BEG and END (region to sort)."
    (interactive "r")
    (save-excursion
      (save-restriction
        (narrow-to-region beg end)
        (goto-char (point-min))
        (while (not (eobp))
          (kill-line 1)
          (yank)
          (let ((next-line (point)))
            (while
                (re-search-forward
                 (format "^%s" (regexp-quote (car kill-ring))) nil t)
              (replace-match "" nil nil))
            (goto-char next-line))))))

  (defun duplicate-line-or-region (&optional n)
    "Duplicate current line, or region if active.
With argument N, make N copies.
With negative N, comment out original line and use the absolute value."
    (interactive "*p")
    (let ((use-region (use-region-p)))
      (save-excursion
        (let ((text (if use-region		;Get region if active, otherwise line
                        (buffer-substring (region-beginning) (region-end))
                      (prog1 (thing-at-point 'line)
                        (end-of-line)
                        (if (< 0 (forward-line 1)) ;Go to beginning of next line,
                                        ;or make a new one
                            (newline))))))
          (dotimes (i (abs (or n 1)))			;Insert N times, or once if not
                                        ;specified
            (insert text))))
      (if use-region nil		   ;Only if we're working with a line (not a region)
        (let ((pos (- (point) (line-beginning-position)))) ;Save column
          (if (> 0 n)						;Comment out original with negative arg
              (comment-region (line-beginning-position) (line-end-position)))
          (forward-line 1)
          (forward-char pos)))))

  ;; delete not kill it into kill-ring
  ;; _based on_ http://ergoemacs.org/emacs/emacs_kill-ring.html
  (defun delete-word (arg)
    "Delete characters forward until encountering the end of a word.
With argument, do this that many times.
This command does not push text to `kill-ring'."
    (interactive "p")
    (delete-region
     (point)
     (progn
       (forward-word arg)
       (point))))
  (defun delete-word-backward (arg)
    "Delete(not kill) characters backward until encountering the beginning of the syntax-subword.
With argument, do this that many times."
    (interactive "p")
    (delete-word (- arg)))
  (defun delete-line-to-end (arg)
    "Delete text from current position to end of line char.
With argument, forward ARG lines."
    (interactive "p")
    (let (x1 x2)
      (setq x1 (point))
      (if (eolp) (forward-line arg) (forward-line (- arg 1)))
      (move-end-of-line 1)
      (setq x2 (point))
      (delete-region x1 x2)
      (when (bolp) (delete-char 1))))
  (defun delete-line-backward (arg)
    "Delete text between the beginning of the line to the cursor position.
With argument, backward ARG lines."
    (interactive "p")
    (let (x1 x2)
      (setq x1 (point))
      (if (bolp) (forward-line (- arg)) (forward-line (- 1 arg)))
      (move-beginning-of-line 1)
      (setq x2 (point))
      (delete-region x1 x2)))

  ;; TODO: please remove this part if the author put this into comment-dwim-2 package
  ;; useful for M-;(comment-dwim-2)
  ;; replace tabs with spaces before comment and code even if indent-tabs-mode is t
  ;; https://github.com/remyferre/comment-dwim-2/issues/6
  (defadvice comment-indent (around comment-indent-with-spaces activate)
    (let ((orig-indent-tabs-mode indent-tabs-mode))
      (when orig-indent-tabs-mode
        (setq indent-tabs-mode nil))
      ad-do-it
      (when orig-indent-tabs-mode
        (setq indent-tabs-mode t))))

  ;; kill all magit buffers, do this in magit-status with `q'
  ;; https://manuel-uberti.github.io/emacs/2018/02/17/magit-bury-buffer/
  (defun mu-magit-kill-buffers ()
    "Restore window configuration and kill all Magit buffers."
    (interactive)
    (let ((buffers (magit-mode-get-buffers)))
      (magit-restore-window-configuration)
      (mapc #'kill-buffer buffers)))
  ;; `q' by default is bound to magit-mode-bury-buffer which doesn't kill buffers
  (with-eval-after-load 'magit
    (bind-key "q" #'mu-magit-kill-buffers magit-status-mode-map))

  ;; show snippets in company list, don't know why auto-completion-enable-snippets-in-popup doesn't work
  (defun autocomplete-show-snippets ()
    "Show snippets in autocomplete popup."
    (let ((backend (car company-backends)))
      (unless (listp backend)
        (setcar company-backends `(,backend :with company-yasnippet company-files)))))
  (with-eval-after-load 'company
    '(add-hook 'after-change-major-mode-hook 'autocomplete-show-snippets))

  ;; highlight-indent-guides
  ;; TODO: uncomment his line when the character can be displayed correctly
  ;; (add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
  (setq highlight-indent-guides-auto-enabled nil
        highlight-indent-guides-method 'character
        ;; Indent character samples: | ┆ ┊ ⁞
        highlight-indent-guides-character ?\┊)

  ;; reopen killed buffer
  (defvar killed-buffers-list nil
    "List of recently killed buffers.")
  (defun add-file-to-killed-buffers-list ()
    "If buffer is associated with a file name, add that file to the
`killed-buffers-list' when killing the buffer."
    (when buffer-file-name
      (push buffer-file-name killed-buffers-list)))
  (add-hook 'kill-buffer-hook #'add-file-to-killed-buffers-list)
  (defun reopen-killed-buffer-fancy ()
    "Pick a file to revisit from a list of files killed during this
Emacs session."
    (interactive)
    (if killed-buffers-list
        (let ((file
               (completing-read "Reopen killed file: " killed-buffers-list
                                nil nil nil nil (car killed-buffers-list))))
          (when file
            (setq killed-buffers-list
                  (cl-delete file killed-buffers-list :test #'equal))
            (find-file file)))
      (error "No recently-killed files to reopen")))
  (spacemacs/declare-prefix "fY" "yasnippets")
  (spacemacs/declare-prefix "X" "copy/cut/delete/move")
  (spacemacs/set-leader-keys
    "bU" 'reopen-killed-buffer-fancy
    "bc" 'whitespace-cleanup
    ;; overwrite the default bR
    "bR" 'revert-buffer-without-asking
    "tG" 'highlight-indent-guides-mode
    "fYn" 'yas-new-snippet
    "fYr" 'yas-reload-all
    "fYi" 'yas-insert-snippet
    "fYv" 'yas-visit-snippet-file
    "bq" 'query-replace-from-top
    "bf" 'flush-blank-lines
    ;; related one is default M-q
    "bF" 'xah-fill-or-unfill
    ;; default feR, still works
    "fer" 'dotspacemacs/sync-configuration-layers
    ;; default helm-find-files
    "fF" 'find-alternate-file
    "Xd" 'delete-line-or-region-or-buffer
    "Xc" 'copy-line-or-region-or-buffer
    "Xk" 'cut-line-or-region-or-buffer
    "XC" 'hydra-change-case/body
    "Xm" 'hydra-cool-moves/body
    "Xr" 'hydra-rectangle/body
    )

  (defun revert-buffer-without-asking()
    "Revert buffer without asking"
    (interactive)
    (revert-buffer nil t))

  ;; symbol-overlay replaces highlight-symbol
  (dolist (hook '(prog-mode-hook org-mode-hook))
    (add-hook hook #'symbol-overlay-mode))

  (defun xah-fill-or-unfill ()
  "Reformat current paragraph or region to `fill-column', like `fill-paragraph' or “unfill”.
When there is a text selection, act on the the selection, else, act on a text block separated by blank lines.
URL `http://ergoemacs.org/emacs/modernization_fill-paragraph.html'
Version 2016-07-13"
  (interactive)
  ;; This command symbol has a property “'compact-p”, the possible values are t and nil.
  ;; This property is used to easily determine whether to compact or uncompact, when this command is called again
  (let ( (-compact-p
          (if (eq last-command this-command)
              (get this-command 'compact-p)
            (> (- (line-end-position) (line-beginning-position)) fill-column)))
         (deactivate-mark nil)
         (-blanks-regex "\n[ \t]*\n")
         -p1 -p2
         )
    (if (use-region-p)
        (progn (setq -p1 (region-beginning))
               (setq -p2 (region-end)))
      (save-excursion
        (if (re-search-backward -blanks-regex nil "NOERROR")
            (progn (re-search-forward -blanks-regex)
                   (setq -p1 (point)))
          (setq -p1 (point)))
        (if (re-search-forward -blanks-regex nil "NOERROR")
            (progn (re-search-backward -blanks-regex)
                   (setq -p2 (point)))
          (setq -p2 (point)))))
    (if -compact-p
        (fill-region -p1 -p2)
      (let ((fill-column most-positive-fixnum ))
        (fill-region -p1 -p2)))
    (put this-command 'compact-p (not -compact-p))))

  ;; M-^ delete Up to Non-Whitespace Character, 'delete-indentation, combine two lines
  ;; M-Backspace delete to the previous word 'backword-kill-word
  ;; M-\ delete kill _all_ spaces at point 'delete-horizontal-space
  ;; Remove whitespaces around cursor to just one or none. If current line does
  ;; have visible characters: shrink whitespace around cursor to just one space.
  ;; If current line does not have visible chars, then shrink all neighboring
  ;; blank lines to just one. Repeat the function will remove the remaining one
  ;; space or blank line. If current line is a single space, remove that space.
  ;; `shrink-whitespaces` combine `delete-blank-lines`, `just-one-space`,
  ;; `fixup-whitespace`, `delete-horizontal-space`, and `cycle-spacing`(in emacs
  ;; 24.4) into one.
  (defun xah-shrink-whitespaces ()
    "Remove whitespaces around cursor to just one or none.
Call this command again to shrink more. 3 calls will remove all whitespaces.
URL `http://ergoemacs.org/emacs/emacs_shrink_whitespace.html'
Version 2016-12-18"
    (interactive)
    (let ((-p0 (point))
          -line-has-char-p ; current line contains non-white space chars
          -has-space-tab-neighbor-p
          -space-or-tab-begin -space-or-tab-end
          )
      (save-excursion
        (setq -has-space-tab-neighbor-p
              (or (looking-at " \\|\t") (looking-back " \\|\t" 1)))
        (beginning-of-line)
        (setq -line-has-char-p (re-search-forward "[[:graph:]]" (line-end-position) t))
        (goto-char -p0)
        (skip-chars-backward "\t ")
        (setq -space-or-tab-begin (point))
        (goto-char -p0)
        (skip-chars-forward "\t ")
        (setq -space-or-tab-end (point)))
      (if -line-has-char-p
          (if -has-space-tab-neighbor-p
              (let (-deleted-text)
                ;; remove all whitespaces in the range
                (setq -deleted-text
                      (delete-and-extract-region -space-or-tab-begin -space-or-tab-end))
                ;; insert a whitespace only if we have removed something different than a simple whitespace
                (when (not (string= -deleted-text " "))
                  (insert " ")))
            (progn
              (when (equal (char-before) 10) (delete-char -1))
              (when (equal (char-after) 10) (delete-char 1))))
        (progn (delete-blank-lines)))))
  (bind-keys*
   ("C-x DEL" . xah-shrink-whitespaces)
   ("M-%" . query-replace-from-top)
   ("M-z" . helm-for-files)
   ("C-h h" . helm-apropos)
   ("C-x /" . helm-semantic-or-imenu)
   ("C-s" . helm-occur)
   ("C-a" . keep-beginning-of-line)
   ("C-e" . keep-end-of-line)
   ("M-;" . comment-dwim-2)
   ;; switch the last visited buffer, repeated invocations toggle between the most recent two buffers
   ;; this is different from SPC TAB, which switch the last buffer in this window
   ("C-x x" . (lambda () (interactive) (switch-to-buffer (other-buffer (current-buffer) 1))))
   ("M-n" . symbol-overlay-jump-next)
   ("M-p" . symbol-overlay-jump-prev)
   ("M-d" . delete-word)
   ("<M-backspace>" . delete-word-backward)
   ("C-k" . delete-line-to-end)
   ("C-c k" . delete-line-backward)
   ("C-c d" . duplicate-line-or-region)
   ("C-c D" . delete-duplicated-lines-buffer-or-region)
   ("M-RET" . Meta-return)
   )
  (bind-keys :map evil-hybrid-state-map
             ;; not put it into global, it goes wrong in helm mode
             ("RET" . advanced-return)
             )
  ;; disable follow in helm-occur (like helm-swoop) github-2152
  (with-eval-after-load 'helm
    (cl-defmethod helm-setup-user-source ((source helm-moccur-class))
      (setf (slot-value source 'follow) -1))
    ;; use <right> to search the whole word when using helm-occur
    ;; FIXME: this doesn't work helm-occur in spacemacs
    (defun helm-occur-insert-symbol-regexp ()
      (interactive)
      (helm-set-pattern (concat "\\_<" helm-input "\\_>")))
    (define-key helm-occur-map (kbd "<right>") 'helm-occur-insert-symbol-regexp)
    )

  ;; for terminal emacs, change theme in the configuration of the terminal, such as solarized-dark
  ;; if it doesn't work, comment out the following lines
  ;; (when (not window-system)
  ;;   (progn
  ;;     ;; change the color or current highlighted line
  ;;     (set-face-background 'hl-line "839496")
  ;;     ;; change the color of selected item in helm list
  ;;     (set-face-background 'region "black")
  ;;     (set-face-attribute 'region nil :background "#666")
  ;;     (with-eval-after-load 'helm
  ;;       (set-face-background 'helm-selection "839496"))
  ;;     ))
  ;; whitespace faces
  (with-eval-after-load 'whitespace
    (set-face-attribute 'whitespace-space-after-tab nil :background "red" :foreground "yellow")
    (set-face-attribute 'whitespace-space-before-tab nil :background "red" :foreground "yellow")
    (if indent-tabs-mode
        (progn
          (set-face-attribute 'whitespace-tab nil :background nil :foreground nil)
          (set-face-attribute 'whitespace-indentation nil :background nil :foreground nil)
          ))
    (progn
      (set-face-attribute 'whitespace-tab nil :background nil :foreground "yellow")
      (set-face-attribute 'whitespace-indentation nil :background "red" :foreground "yellow")
      ))

  ;; format
  (setq-default
   ;; t -> use tab as tab, nil -> use space as tab
   indent-tabs-mode t
   tab-always-indent 'complete
   ;; sometimes tab-width (4) will make the char's position different from turning on whitespace-mode
   tab-width 4
   ;; for C++
   c-basic-offset 4
   )
  (add-hook 'emacs-lisp-mode-hook
            (lambda ()
              (setq indent-tabs-mode nil)))
  (add-hook 'python-mode-hook
            (lambda ()
              (set (make-local-variable 'comment-inline-offset) 2) ; PEP8 two spaces
              (setq indent-tabs-mode nil)
              (setq tab-width 4)))
  (add-hook 'c-mode-hook
            (lambda ()
              (c-set-style "linux")
              (setq tab-width 8)
              (setq indent-tabs-mode t) ;;default in linux kernel
              (setq c-basic-offset 8)
              ;; make comment aligned with the code block/line
              (c-set-offset 'comment-intro 0)))
  (add-hook 'c++-mode-hook
            (lambda ()
              (c-set-style "linux")
              (setq tab-width 4)
              (setq indent-tabs-mode t) ;;default in linux kernel
              (setq c-basic-offset 4)
              (c-set-offset 'comment-intro 0)))
  (add-hook 'makefile-mode-hook
            (lambda ()
              (setq tab-width 8)))
  (add-hook 'fish-mode-hook
            (lambda ()
              (setq indent-tabs-mode nil)))

  ;; make the code inside #if 0/#else/#endif the same color as comment
  (defun c-mode-font-lock-if0 (limit)
    (save-restriction
      (widen)
      (save-excursion
        (goto-char (point-min))
        (let ((depth 0) str start start-depth)
          ;; Search #if/#else/#endif using regular expression.
          (while (re-search-forward "^\\s-*#\\s-*\\(if\\|else\\|endif\\)" limit 'move)
            (setq str (match-string 1))
            ;; Handle #if.
            (if (string= str "if")
                (progn
                  (setq depth (1+ depth))
                  ;; Handle neariest 0.
                  (when (and (null start) (looking-at "\\s-+0"))
                    (setq start (match-end 0)
                          start-depth depth)))
              ;; Handle #else, here we can decorate #if 0->#else block using 'font-lock-comment-face'.
              (when (and start (= depth start-depth))
                (c-put-font-lock-face start (match-beginning 0) 'font-lock-comment-face)
                (setq start nil))
              ;; Handle #endif, return to upper block if possible.
              (when (string= str "endif")
                (setq depth (1- depth)))))
          ;; Corner case when there are only #if 0 (May be you are coding now:))
          (when (and start (> depth 0))
            (c-put-font-lock-face start (point) 'font-lock-comment-face)))))
    nil)
  (defun my-c-mode-common-hook ()
    (font-lock-add-keywords
     nil
     '((c-mode-font-lock-if0 (0 font-lock-comment-face prepend))) 'add-to-end))
  (add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

  ;; insert mode by default in commit editing buffer
  (add-hook 'with-editor-mode-hook 'evil-insert-state)

  ;; make C-e in better-defaults work, not work if setting like README.org
  (define-key evil-insert-state-map (kbd "C-e") 'mwim-end-of-code-or-line)
  (define-key evil-motion-state-map (kbd "C-e") 'mwim-end-of-code-or-line)
  (spacemacs/toggle-truncate-lines-on)
  (add-hook 'org-mode-hook 'spacemacs/toggle-visual-line-navigation-on)

  ;; electric-operator
  (dolist (hook '(c-mode-common-hook org-mode-hook python-mode-hook inferior-python-mode-hook LaTeX-mode-hook plantuml-mode-hook))
    (add-hook hook #'electric-operator-mode))
  (with-eval-after-load "electric-operator"
    (setq electric-operator-enable-in-docs t)
    (electric-operator-add-rules-for-mode
     'c++-mode
     (cons "<>" "<> ")
     (cons "<" " < ")
     (cons ">" " > ")
     (cons ";" "; ")
     (cons "++" "++")
     )
    (electric-operator-add-rules-for-mode
     'c-mode
     (cons "<>" "<> ")
     (cons "<" " < ")
     (cons ">" " > ")
     (cons ";" "; ")
     (cons "++" "++")
     )
    (electric-operator-add-rules-for-mode
     'org-mode
     (cons "," ", ")
     (cons "?" "? ")
     (cons ";" "; ")
     (cons "." ". ")
     (cons ".c" ".c ")
     (cons ".cpp" ".cpp ")
     (cons ".org" ".org ")
     (cons ".md" ".md ")
     (cons ".el" ".el ")
     (cons ".py" ".py ")
     (cons "./" " ./")
     (cons "/." "/.")
     (cons "/" nil) ;; or change nil to "/"
     )
    (electric-operator-add-rules-for-mode
     'inferior-python-mode
     (cons "=" " = ")
     (cons "==" ",== ")
     (cons "," ", ")
     )
    (electric-operator-add-rules-for-mode
     'plantuml-mode
     (cons ":" " : ")
     ;;
     (cons "<->" " <-> ")
     (cons "<->o" " <->o ")
     (cons "->" " -> ")
     (cons "->>" " ->> ")
     (cons "->x" " ->x ")
     (cons "->o" " ->o ")
     ;;
     ;; (cons "<-" " <- ")
     ;; (cons "x<-" " x<- ")
     ;; (cons "o<-" " o<- ")
     ;;
     (cons "-->>" " -->> ")
     (cons "-->>" " -->> ")
     ;; (cons "<<--" " <<-- ")
     ;; (cons "<<--" " <<-- ")
     ;;
     ;; (cons "\-" " \- ")
     ;; (cons "-\" " -\ ")
     ;; (cons "\\--" " \\-- ")
     (cons "--//" " --// ")
     (cons "-/" " -/ ")
     (cons "/-" " /- ")
     (cons "//--" " //-- ")
     ;; (cons "--\\" " --\\ ")
     ;;
     (cons "-->" " --> ")
     (cons "-->o" " -->o ")
     (cons "-->x" " -->x ")
     ;; (cons "<--" " <-- ")
     ;; (cons "x<--" " x<-- ")
     ;; (cons "o<--" " o<-- ")
     )
    )

  ;; set the query-replace from top
  (defun query-replace-from-top ()
    (interactive)
    (let ((orig-point (point)))
      (save-excursion
        (goto-char (point-min))
        (call-interactively 'query-replace))
      (message "Back to old point.")
      (goto-char orig-point)))

  ;; flush blank lines
  (defun flush-blank-lines (start end)
    "Mark a block and delete all blank/empty lines inside it."
    (interactive "r")
    (flush-lines "^\\s-*$" start end nil))

  (defun keep-beginning-of-line (ARG)
    "Make `C-a` keep going to first non-whitespace character _and_then_ beginning of
  next line(previous with C-u)."
    (interactive "P")
    (when (bolp) (forward-line (if ARG -1 1)))
    (let ((orig-point (point)))
      (back-to-indentation)
      (when (= orig-point (point))
        (move-beginning-of-line 1))))
  (defun keep-end-of-line (ARG)
    "Make `C-e` keep going to end of next line(previous with C-u)."
    (interactive "P")
    (when (eolp) (forward-line (if ARG -1 1)))
    (move-end-of-line nil))

  ;; needed for change-case functions
  (global-syntax-subword-mode)
  (defun xah-toggle-letter-case ()
    "Toggle the letter case of current word or text selection.
Always cycle in this order: Init Caps, ALL CAPS, all lower.

URL `http://ergoemacs.org/emacs/modernization_upcase-word.html'
Version 2017-04-19"
    (interactive)
    (let (
          (deactivate-mark nil)
          $p1 $p2)
      (if (use-region-p)
          (setq $p1 (region-beginning)
                $p2 (region-end))
        (save-excursion
          (skip-chars-backward "[:alnum:]-_")
          (setq $p1 (point))
          (skip-chars-forward "[:alnum:]-_")
          (setq $p2 (point))))
      (when (not (eq last-command this-command))
        (put this-command 'state 0))
      (cond
       ((equal 0 (get this-command 'state))
        (upcase-initials-region $p1 $p2)
        (put this-command 'state 1))
       ((equal 1  (get this-command 'state))
        (upcase-region $p1 $p2)
        (put this-command 'state 2))
       ((equal 2 (get this-command 'state))
        (downcase-region $p1 $p2)
        (put this-command 'state 0)))))
  ;; automatically convert the comma/dot once downcase/upcase next character
  (defun endless/convert-punctuation (rg rp)
    "Look for regexp RG around point, and replace with RP.
Only applies to text-mode."
    (let ((f "\\(%s\\)\\(%s\\)")
          (space "?:[[:blank:]\n\r]*"))
      ;; We obviously don't want to do this in prog-mode.
      (if (and (derived-mode-p 'org-mode)
               (or (looking-at (format f space rg))
                   (looking-back (format f rg space))))
          (replace-match rp nil nil nil 1))))
  (defun endless/capitalize ()
    "Capitalize region or word.
Also converts commas to full stops, and kills
extraneous space at beginning of line."
    (interactive)
    (endless/convert-punctuation "," ".")
    (if (use-region-p)
        (call-interactively 'capitalize-region)
      ;; A single space at the start of a line:
      (when (looking-at "^\\s-\\b")
        ;; get rid of it!
        (delete-char 1))
      (call-interactively 'subword-capitalize)))
  (defun endless/downcase ()
    "Downcase region or word.
Also converts full stops to commas."
    (interactive)
    (endless/convert-punctuation "\\." ",")
    (if (use-region-p)
        (call-interactively 'downcase-region)
      (call-interactively 'subword-downcase)))
  (defun endless/upcase ()
    "Upcase region or word."
    (interactive)
    (if (use-region-p)
        (call-interactively 'upcase-region)
      (call-interactively 'subword-upcase)))
  ;; this can also can be done simply using M-c/M-l/M-u
  (defhydra hydra-change-case (:hint nil)
    ""
    ("x" xah-toggle-letter-case "loop")
    ("c" endless/capitalize "capitalize")
    ("l" endless/downcase "downcase")
    ("u" endless/upcase "upcase")
    ("z" undo-tree-undo "undo")
    ("Z" undo-tree-redo "redo")
    ("q" nil))

  (require 'cool-moves)
  (dolist (m (list prog-mode-map text-mode-map))
    (bind-keys :map m
               ("M-<up>" . cool-moves/line-backward)
               ("M-<down>" . cool-moves/line-forward)
               ("M-<left>" . cool-moves/sexp-backward)
               ("M-<right>" . cool-moves/sexp-forward)))
  (defhydra hydra-cool-moves (:color amaranth :hint nil :foreign-keys nil)
    "
 _<down>_/_l_: line ↓     _<up>_/_L_: line ↑
 _p_: par  ↓             _P_: par  ↑
 _w_: word →             _W_: word ←
 _c_: char →             _C_: char ←
 _s_: sentence →         _S_: sentence ←
 _<right>_/_x_: sexp →   _<left>_/_X_: sexp ←
 _z_: undo               _Z_: redo
"
    ("<escape>" nil)
    ("u" nil)

    ("l" cool-moves/line-forward)
    ("<down>" cool-moves/line-forward)
    ("L" cool-moves/line-backward)
    ("<up>" cool-moves/line-backward)

    ("p" cool-moves/paragraph-forward)
    ("P" cool-moves/paragraph-backward)

    ("w" cool-moves/word-forward)
    ("W" cool-moves/word-backwards)

    ("c" cool-moves/character-forward)
    ("C" cool-moves/character-backward)

    ("s" cool-moves/sentence-forward)
    ("S" cool-moves/sentence-backward)

    ("x" cool-moves/sexp-forward)
    ("<right>" cool-moves/sexp-forward)
    ("X" cool-moves/sexp-backward)
    ("<left>" cool-moves/sexp-backward)

    ("z" undo-tree-undo)
    ("Z" undo-tree-redo)
    ("q" nil))

  (bind-key* "C-c %"
             (defhydra hydra-rectangle
               (:body-pre (rectangle-mark-mode 1)
                          :color pink
                          :hint nil
                          :post (deactivate-mark))
               "
  ^_k_^		  _w_ copy		_o_pen		 _N_umber-lines			   |\\	   -,,,--,,_
_h_	  _l_	  _y_ank		_t_ype		 _e_xchange-point		   /,`.-'`'	  ..  \-;;,_
  ^_j_^		  _d_ kill		_c_lear		 _r_eset-region-mark	  |,4-	) )_   .;.(	 `'-'
^^^^		  _u_ndo		_g_ quit	 ^ ^					 '---''(./..)-'(_\_)
"
               ("k" rectangle-previous-line)
               ("j" rectangle-next-line)
               ("h" rectangle-backward-char)
               ("l" rectangle-forward-char)
               ("d" kill-rectangle)					 ;; C-x r k
               ("y" yank-rectangle)					 ;; C-x r y
               ("w" copy-rectangle-as-kill)			 ;; C-x r M-w
               ("o" open-rectangle)					 ;; C-x r o
               ("t" string-rectangle)					 ;; C-x r t
               ("c" clear-rectangle)					 ;; C-x r c
               ("e" rectangle-exchange-point-and-mark) ;; C-x C-x
               ("N" rectangle-number-lines)			 ;; C-x r N
               ("r" (if (region-active-p)
                        (deactivate-mark)
                      (rectangle-mark-mode 1)))
               ("u" undo nil)
               ("g" nil)))

  ;; delete/copy/cut whole buffer without moving point
  (defun current-line-empty-p ()
    (save-excursion
      (beginning-of-line)
      (looking-at "[[:space:]]*$")))
  (defun delete-line-or-region-or-buffer ()
    "Delete current line, or text selection.
When `universal-argument' is called first, delete whole buffer (respects `narrow-to-region')."
    (interactive)
    (if current-prefix-arg
        (delete-region (point-min) (point-max))
      (progn
        (if (use-region-p)
            (delete-region (region-beginning) (region-end))
          (delete-region (line-beginning-position) (line-end-position)))
        ;; delete the extra empty line
        (when (current-line-empty-p) (delete-blank-lines))
        (when (not (current-line-empty-p)) (indent-for-tab-command)))))
  (defun copy-line-or-region-or-buffer ()
    "Copy current line, or text selection.
When called repeatedly, append copy subsequent lines.
When `universal-argument' is called first, copy whole buffer (respects `narrow-to-region').
URL `http://ergoemacs.org/emacs/emacs_copy_cut_current_line.html'
Version 2016-06-18"
    (interactive)
    (let (-p1 -p2)
      (if current-prefix-arg
          (setq -p1 (point-min) -p2 (point-max))
        (if (use-region-p)
            (setq -p1 (region-beginning) -p2 (region-end))
          ;; (setq -p1 (line-beginning-position) -p2 (line-end-position))))
          ;; use non-white position
          ;; -p1 is the position of beginning of line of non-whitespace
          ;; -p2 is the position of end of line of non-whitespace
          (setq -p1 (save-excursion (back-to-indentation) (point))
                -p2 (save-excursion
                      (end-of-line)
                      (skip-syntax-backward "-")
                      (point)))))
      (if (eq last-command this-command)
          (progn
            (progn										   ; hack. exit if there's no more next line
              (end-of-line)
              (forward-char)
              (backward-char))
            ;; (push-mark (point) "NOMSG" "ACTIVATE")
            (kill-append "\n" nil)
            (kill-append (buffer-substring-no-properties (line-beginning-position) (line-end-position)) nil)
            (message "Line copy appended"))
        (progn
          (kill-ring-save -p1 -p2)
          (if current-prefix-arg
              (message "Buffer text copied")
            (message "Text copied"))))
      ;; (end-of-line)
      ;; (forward-char)
      ))
  (defun cut-line-or-region-or-buffer ()
    "Cut current line, or text selection.
When `universal-argument' is called first, cut whole buffer (respects `narrow-to-region').
URL `http://ergoemacs.org/emacs/emacs_copy_cut_current_line.html'
Version 2015-06-10"
    (interactive)
    (if current-prefix-arg
        (progn ; not using kill-region because we don't want to include previous kill
          (kill-new (buffer-string))
          (delete-region (point-min) (point-max)))
      (progn (if (use-region-p)
                 (kill-region (region-beginning) (region-end) t)
               ;; (kill-region (line-beginning-position) (line-end-position))
               ;; use non-white position
               (kill-region
                (save-excursion (back-to-indentation) (point))
                (save-excursion
                  (end-of-line)
                  (skip-syntax-backward "-")
                  (point))))
             ;; delete the extra empty line
             (when (current-line-empty-p) (delete-blank-lines))
             (when (not (current-line-empty-p)) (indent-for-tab-command)))))

  (defun advanced-return (&optional ARG)
    "Customized return, more powerful.

Default(without prefix), create a line, jump into it and indent(like C-e C-m)
With prefix argument(C-u), it will create a new line, jump into it but no indent(like C-e C-o C-n).
With negative prefix argument(C--), it will create a new line above the current
line and jump into it(like C-a C-o)

In comments, RET will automatically use C-M-j instead.
In other non-comment situations, try C-M-j to split."
    (interactive "P")
    (if (equal ARG '-)
        (progn
          (beginning-of-line)
          (open-line 1))
      (if (equal ARG '(4))
          (progn
            (end-of-line)
            (open-line 1)
            (forward-line))
        (progn
          (end-of-line)
          (newline-and-indent)))))
  (defun Meta-return ()
    (interactive)
    (progn
      ;; executing key in a function
      (call-interactively (key-binding (kbd "C-M-j")))
      (indent-according-to-mode)))
  )

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(defun dotspacemacs/emacs-custom-settings ()
  "Emacs custom settings.
This is an auto-generated function, do not modify its content directly, use
Emacs customize menu instead.
This function is called at the very end of Spacemacs initialization."
  (custom-set-variables
   ;; custom-set-variables was added by Custom.
   ;; If you edit it by hand, you could mess it up, so be careful.
   ;; Your init file should contain only one such instance.
   ;; If there is more than one, they won't work right.
   '(delete-selection-mode nil)
   '(evil-want-Y-yank-to-eol nil))
  (custom-set-faces
   ;; custom-set-faces was added by Custom.
   ;; If you edit it by hand, you could mess it up, so be careful.
   ;; Your init file should contain only one such instance.
   ;; If there is more than one, they won't work right.
   )
  )
