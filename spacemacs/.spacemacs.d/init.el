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

   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. "~/.mycontribs/")
   dotspacemacs-configuration-layer-path '()

   ;; List of configuration layers to load.
   dotspacemacs-configuration-layers
   '(
     ;; ----------------------------------------------------------------
     ;; Example of useful layers you may want to use right away.
     ;; Uncomment some layer names and press `SPC f e R' (Vim style) or
     ;; `M-m f e R' (Emacs style) to install them.
     ;; ----------------------------------------------------------------
     (auto-completion
      :variables
      ;; auto-completion-enable-snippets-in-popup t
      auto-completion-enable-help-tooltip t
      company-show-numbers t
      )
     better-defaults
     theming
     syntax-checking
     colors
     git
     (ivy :variables ivy-enable-advanced-buffer-information t)
     emacs-lisp
     (vimscript
      ;; TODO: npm install -g vim-language-server
      :variables vimscript-backend 'lsp
      )
     ;; TODO:
     ;; rustup component add rust-analysis rust-src clippy rustfmt
     ;; cargo install cargo-edit cargo-audit cargo-outdated
     (rust
      :variables
      ;; rust-format-on-save t
      cargo-process-reload-on-modify t
      cargo-process--open-file-after-new t
      cargo-process--enable-rust-backtrace t
      ;; NOTE: it auto installs rust-analyzer into ~/.emacs.d/.cache/lsp/rust/rust-analyzer
      lsp-rust-server 'rust-analyzer
      lsp-rust-clippy-preference "on"
      lsp-rust-analyzer-cargo-watch-command "clippy"
      lsp-rust-analyzer-experimental-proc-attr-macros t
      )
     (treemacs
      :variables
      treemacs-position 'right
      treemacs-no-png-images t
      treemacs-use-scope-type 'Perspectives
      treemacs-display-in-side-window nil
      treemacs-show-cursor t
      treemacs-missing-project-action 'remove
      )
     ;; NOTE: install shellcheck
     ;; lsp for bash "npm i -g bash-language-server"
     (shell-scripts
      :variables
      ;; shell-scripts-format-on-save t
      shell-scripts-backend 'lsp
      )
     (python
      :variables
      ;; TODO: pip install 'python-lsp-server[all]'
      python-backend 'lsp        ; the default is anaconda
      python-test-runner '(pytest nose)
      python-formatter 'black
      ;; python-format-on-save t
      python-sort-imports-on-save nil
      ;; TODO: npm install -g pyright
      ;; python-lsp-server 'pyright
      )
     ;; NOTE: `pip install jupyter', then run `jupyter notebook'
     (ipython-notebook
      :variables
      ein:jupyter-default-notebook-directory "~/ipynb"
      ;; display inline image inside emacs instead of external tool
      ein:output-area-inlined-images t)
     (conda :variables conda-anaconda-home "~/anaconda3")
     ;; TODO: Check layer/go for packages to install
     (go
      :variables
      ;; if not given and lsp layer is used, lsp will be used as go-backend
      ;; go-backend 'go-mode
      ;; go-tab-width 4
      ;; go-format-before-save t
      go-use-golangci-lint t
      godoc-at-point-function 'godoc-gogetdoc
      )
     ;; replace multiple-cursors with symbol-overlay(SPC s o)
     ;; multiple-cursors
     (org
      :variables
      org-want-todo-bindings t
      org-enable-epub-support t
      org-enable-sticky-header t
      ;; NOTE: sqlite for org-roam will auto-start even you didn't use org-mode
      ;; org-enable-roam-support t
      ;; org-roam-v2-ack t
      ;; ;; NOTE: the following three lines fix the org-roam causing emacsclient fail to start issue
      ;; ;; spacemacs/issues/14477
      ;; org-directory "~/Org"
      ;; org-roam-directory (concat org-directory "/org-roam")
      ;; org-roam-db-location (concat org-roam-directory "/org-roam.db")
      )
     (shell
      :variables
      shell-default-shell 'ansi-term
      close-window-with-terminal t
      shell-pop-autocd-to-working-dir nil
      ;; not the full width, but just split the current window
      shell-default-full-span nil
      )
     (spell-checking
      :variables
      ;; enable-flyspell-auto-completion t
      )
     ;; use `SPC g .' to use version control functions such as goto next hunk
     (version-control
      :variables
      version-control-diff-tool 'git-gutter+
      version-control-diff-side 'left
      )
     (evil-snipe
      :variables evil-snipe-enable-alternate-f-and-t-behaviors t)
     (c-c++
      :variables
      c-c++-backend 'lsp-clangd
      lsp-clients-clangd-args
      '("-j=12" "--all-scopes-completion" "--background-index" "--clang-tidy"
        "--completion-style=detailed" "--cross-file-rename" "--header-insertion=iwyu"
        "--header-insertion-decorators" "--inlay-hints" "--pch-storage=memory"
        "--query-driver=/usr/bin/**/clang*,/bin/clang,/bin/clang++,/usr/bin/gcc,/usr/bin/g++"
        )
      ;; NOTE: some options such as inlay-hints don't work
      c-c++-adopt-subprojects t
      ;; c-c++-enable-auto-newline t
      c-c++-lsp-enable-semantic-highlight t
      ;; c++-enable-organize-includes-on-save t
      ;; clang-format-style: https://clang.llvm.org/docs/ClangFormat.html
      ;; `clang-format -style=LLVM -dump-config > .clang-format`
      ;; Both C and Cpp projects can share the same .clang-format
      ;; ln -s ~/Dotfiles.d/misc/clang-format-c-cpp .clang-format
      ;; In Cpp project:
      ;; NOTE: the following config is replaced by format-all package and config
      ;; c-c++-enable-clang-format-on-save t
      ;; NOTE: do not use dap-cpptoles, it needs `M-x dap-cpptools-setup' and you need to edit template before debug
      ;; Do not use dap-gdb-lldb, it needs `M-x dap-gdb-lldb-setup'
      ;; (it fails sometimes, FIXME: old version/lldb is not working), no variable like dap-lldb-debugged-program-function
      c-c++-dap-adapters 'dap-lldb)
     ;; TODO: pip install cmake-language-server
     ;; will provide lsp and cmake-format for cmake
     ;; But cmake-format provided by cmake-language-server seems broken, so
     ;; pip install cmake_format
     (cmake
      :variables
      cmake-enable-cmake-ide-support t
      cmake-backend 'lsp
      ;; build dir for the project will be created automatically by cmake-ide(`, p C') when open the src file
      ;; compile project using `, c c' directly even if after modifying CMakeLists.txt
      cmake-ide-build-dir "build"
      )
     meson
     ;; NOTE: to generate compile_commands.json file for lsp before using lsp
     ;; https://sarcasm.github.io/notes/dev/compilation-database.html
     ;; Read https://github.com/MaskRay/ccls/wiki/Project-Setup for project setup like .ccls
     (lsp
      :variables
      ;; https://github.com/emacs-lsp/lsp-mode#performance
      lsp-file-watch-threshold nil
      read-process-output-max (* 1024 1024 3)
      lsp-idle-delay 0.500
      ;; Collect lsp-log data
      ;; lsp-print-performance t
      lsp-log-io t
      lsp-auto-guess-root t
      lsp-ui-doc-position 'at-point
      lsp-ui-doc-delay 1
      lsp-ui-doc-show-with-cursor t
      lsp-ui-imenu-auto-refresh t
      lsp-ui-peek-always-show t
      lsp-ui-peek-peek-height 50
      lsp-ui-sideline-show-code-actions t
      lsp-ui-sideline-show-symbol t
      ;; lsp-ui-sideline-show-hover t
      ;; lsp-ui-sideline-delay 1
      ;; ccls-initialization-options '(:index (:comments 2) :completion (:detailedLabel t) :cache (:directory "/tmp/ccls"))
      ;; ccls-sem-highlight-method 'font-lock
      ;; spacemacs/issues/10051#issuecomment-605979333
      lsp-enable-indentation nil
      ;; https://emacs-lsp.github.io/lsp-mode/tutorials/how-to-turn-off/
      lsp-inlay-hint-enable t
      lsp-rust-analyzer-server-display-inlay-hints t
      lsp-rust-analyzer-display-chaining-hints t
      lsp-rust-analyzer-display-parameter-hints t
      ;; close the server once all buffers of the workspace are closed
      lsp-keep-workspace-alive nil
      lsp-headerline-breadcrumb-enable t
      lsp-headerline-breadcrumb-icons-enable nil
      lsp-headerline-breadcrumb-enable-diagnostics nil
      lsp-headerline-breadcrumb-segments '(project path-up-to-project file symbols)
      )
     (dap :variables dap-ui-locals-expand-depth 3)
     ;; TODO: npm install -g prettier
     prettier
     ;; TODO: npm install -g import-js
     ;; import-js
     ;; TODO: npm install -g tern
     ;; tern
     ;; TODO: npm install -g import-js eslint typescript typescript-language-server
     ;; (javascript
     ;;  :variables
     ;;  javascript-import-tool 'import-js
     ;;  javascript-fmt-tool 'prettier
     ;;  ;; javascript-fmt-on-save t
     ;;  ;; the default backend is lsp
     ;;  javascript-backend 'tern
     ;;  ;; for javascript
     ;;  js2-basic-offset 2
     ;;  js2-include-node-externs t
     ;;  node-add-moduels-path t
     ;;  )
     markdown
     json
     yaml
     ;; (html :variables web-fmt-tool 'web-beautify)
     ;; TODO: sudo luarocks install luacheck
     (lua
      :variables
      lua-backend 'lsp
      ;; NOTE: it auto installs lua-language-server into ~/.emacs.d/.cache/lsp/lua-language-server/
      ;; install lua-roblox-language-server
      lua-lsp-server 'lua-language-server
      lsp-lua-hint-enable t
      )
     ;;(pdf :variables pdf-view-display-size 'fit-height)
     ;; (tabs
     ;;  :variables
     ;;  centaur-tabs-height 20
     ;;  ;; centaur-tabs-bar-height 30
     ;;  ;; centaur-tabs-show-navigation-buttons t ;; FIXME: two tab height variables do not work if set
     ;;  centaur-tabs-show-new-tab-button nil
     ;;  centaur-tabs-modified-marker "*"
     ;;  ;; FIXME: tab-bar will not be displayed for emacsclient if set to left
     ;;  ;; centaur-tabs-set-bar 'left
     ;;  centaur-tabs-cycle 'tabs
     ;;  ;; NOTE: even it is t, emacsclient won't display it, nil for normal emacs
     ;;  centaur-tabs-set-icons nil
     ;;  )
     )

   ;; List of additional packages that will be installed without being wrapped
   ;; in a layer (generally the packages are installed only and should still be
   ;; loaded using load/require/use-package in the user-config section below in
   ;; this file). If you need some configuration for these packages, then
   ;; consider creating a layer. You can also put the configuration in
   ;; `dotspacemacs/user-config'. To use a local version of a package, use the
   ;; `:location' property: '(your-package :location "~/path/to/your-package/")
   ;; Also include the dependencies as they will not be resolved automatically.
   dotspacemacs-additional-packages '(
                                      highlight-indent-guides
                                      electric-operator
                                      syntax-subword
                                      comment-dwim-2
                                      (cool-moves :location (recipe :fetcher github :repo "mrbig033/cool-moves"))
                                      evil-smartparens
                                      esup
                                      wgrep
                                      drag-stuff
                                      leetcode
                                      smart-compile
                                      format-all
                                      (translate-shell :location (recipe :fetcher github :repo "xuchunyang/translate-shell.el"))
                                      exec-path-from-shell
                                      embrace
                                      )

   ;; A list of packages that cannot be updated.
   dotspacemacs-frozen-packages '()

   ;; A list of packages that will not be installed and loaded.
   ;; TODO: org-download package cause error, remove it from the list once fixed
   dotspacemacs-excluded-packages '(
                                    google-c-style auto-highlight-symbol git-gutter
                                    git-gutter-fringe git-gutter-fringe+ fancy-battery
                                    dactyl-mode lorem-ipsum uuidgen evil-tutor indent-guide
                                    org-superstar org-download
                                    evil-escape
                                    )

   ;; Defines the behaviour of Spacemacs when installing packages.
   ;; Possible values are `used-only', `used-but-keep-unused' and `all'.
   ;; `used-only' installs only explicitly used packages and deletes any unused
   ;; packages as well as their unused dependencies. `used-but-keep-unused'
   ;; installs only the used packages but won't delete unused ones. `all'
   ;; installs *all* packages supported by Spacemacs and never uninstalls them.
   ;; (default is `used-only')
   dotspacemacs-install-packages 'used-but-keep-unused))

(defun dotspacemacs/init ()
  "Initialization:
This function is called at the very beginning of Spacemacs startup,
before layer configuration.
It should only modify the values of Spacemacs settings."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; If non-nil then enable support for the portable dumper. You'll need to
   ;; compile Emacs 27 from source following the instructions in file
   ;; EXPERIMENTAL.org at to root of the git repository.
   ;;
   ;; WARNING: pdumper does not work with Native Compilation, so it's disabled
   ;; regardless of the following setting when native compilation is in effect.
   ;;
   ;; (default nil)
   dotspacemacs-enable-emacs-pdumper nil

   ;; Name of executable file pointing to emacs 27+. This executable must be
   ;; in your PATH.
   ;; (default "emacs")
   dotspacemacs-emacs-pdumper-executable-file "emacs"

   ;; Name of the Spacemacs dump file. This is the file will be created by the
   ;; portable dumper in the cache directory under dumps sub-directory.
   ;; To load it when starting Emacs add the parameter `--dump-file'
   ;; when invoking Emacs 27.1 executable on the command line, for instance:
   ;;   ./emacs --dump-file=$HOME/.emacs.d/.cache/dumps/spacemacs-27.1.pdmp
   ;; (default (format "spacemacs-%s.pdmp" emacs-version))
   dotspacemacs-emacs-dumper-dump-file (format "spacemacs-%s.pdmp" emacs-version)

   ;; Maximum allowed time in seconds to contact an ELPA repository.
   ;; (default 5)
   dotspacemacs-elpa-timeout 5

   ;; Set `gc-cons-threshold' and `gc-cons-percentage' when startup finishes.
   ;; This is an advanced option and should not be changed unless you suspect
   ;; performance issues due to garbage collection operations.
   ;; (default '(100000000 0.1))
   dotspacemacs-gc-cons '(100000000 0.1)

   ;; Set `read-process-output-max' when startup finishes.
   ;; This defines how much data is read from a foreign process.
   ;; Setting this >= 1 MB should increase performance for lsp servers
   ;; in emacs 27.
   ;; (default (* 1024 1024))
   dotspacemacs-read-process-output-max (* 1024 1024)

   ;; If non-nil then Spacelpa repository is the primary source to install
   ;; a locked version of packages. If nil then Spacemacs will install the
   ;; latest version of packages from MELPA. Spacelpa is currently in
   ;; experimental state please use only for testing purposes.
   ;; (default nil)
   dotspacemacs-use-spacelpa nil

   ;; If non-nil then verify the signature for downloaded Spacelpa archives.
   ;; (default t)
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

   ;; If non-nil show the version string in the Spacemacs buffer. It will
   ;; appear as (spacemacs version)@(emacs version)
   ;; (default t)
   dotspacemacs-startup-buffer-show-version nil

   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner nil

   ;; Scale factor controls the scaling (size) of the startup banner. Default
   ;; value is `auto' for scaling the logo automatically to fit all buffer
   ;; contents, to a maximum of the full image height and a minimum of 3 line
   ;; heights. If set to a number (int or float) it is used as a constant
   ;; scaling factor for the default logo size.
   dotspacemacs-startup-banner-scale 'auto

   ;; List of items to show in startup buffer or an association list of
   ;; the form `(list-type . list-size)`. If nil then it is disabled.
   ;; Possible values for list-type are:
   ;; `recents' `recents-by-project' `bookmarks' `projects' `agenda' `todos'.
   ;; List sizes may be nil, in which case
   ;; `spacemacs-buffer-startup-lists-length' takes effect.
   ;; The exceptional case is `recents-by-project', where list-type must be a
   ;; pair of numbers, e.g. `(recents-by-project . (7 .  5))', where the first
   ;; number is the project limit and the second the limit on the recent files
   ;; within a project.
   dotspacemacs-startup-lists '((recents . 10)
                                (projects . 5))

   ;; True if the home buffer should respond to resize events. (default t)
   dotspacemacs-startup-buffer-responsive t

   ;; Show numbers before the startup list lines. (default t)
   dotspacemacs-show-startup-list-numbers t

   ;; The minimum delay in seconds between number key presses. (default 0.4)
   dotspacemacs-startup-buffer-multi-digit-delay 0.4

   ;; If non-nil, show file icons for entries and headings on Spacemacs home buffer.
   ;; This has no effect in terminal or if "all-the-icons" package or the font
   ;; is not installed. (default nil)
   dotspacemacs-startup-buffer-show-icons nil

   ;; Default major mode for a new empty buffer. Possible values are mode
   ;; names such as `text-mode'; and `nil' to use Fundamental mode.
   ;; (default `text-mode')
   ;; NOTE: this value is used for `SPC b N n', not anything else
   ;; anything else uses `setq-default major-mode ...'
   dotspacemacs-new-empty-buffer-major-mode 'org-mode

   ;; Default major mode of the scratch buffer (default `text-mode')
   ;; NOTE: change it to org-mode to make spacemacs client open the first org-mode file much faster
   ;; but it will be multiple times slower startup when you open new emacs comparing to not-set-org-mode
   dotspacemacs-scratch-mode 'org-mode

   ;; If non-nil, *scratch* buffer will be persistent. Things you write down in
   ;; *scratch* buffer will be saved and restored automatically.
   dotspacemacs-scratch-buffer-persistent nil

   ;; If non-nil, `kill-buffer' on *scratch* buffer
   ;; will bury it instead of killing.
   dotspacemacs-scratch-buffer-unkillable t

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

   ;; Default font or prioritized list of fonts. This setting has no effect when
   ;; running Emacs in terminal. The font set here will be used for default and
   ;; fixed-pitch faces. The `:size' can be specified as
   ;; a non-negative integer (pixel size), or a floating-point (point size).
   ;; Point size is recommended, because it's device independent. (default 10.0)
   ;; use the following part to get the right name for the font or the first name of fc-list
   ;; (seq-filter (lambda (font)
   ;;               (when-let ((info (font-info font)))
   ;;                 (string-match-p "spacing=100" (aref info 1))))
   ;;             (font-family-list))
   ;; or
   ;; (message
   ;;  (mapconcat (quote identity)
   ;;             (sort (font-family-list) #'string-lessp) "\n"))
   dotspacemacs-default-font '("OperatorMono Nerd Font Mono"
                               :size 13.5
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
   ;; (default "C-M-m" for terminal mode, "<M-return>" for GUI mode).
   ;; Thus M-RET should work as leader key in both GUI and terminal modes.
   ;; C-M-m also should work in terminal mode, but not in GUI mode.
   ;; NOTE: When setting like templage file: GUI mode use M-return as leader key
   ;; weird thing is, emacsclient still uses Meta-return, to make it consistent:
   ;; M-return is bound to Meta-return for both GUI mode and emacsclient
   ;; delete M-return here
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"

   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs `C-i', `TAB' and `C-m', `RET'.
   ;; Setting it to a non-nil value, allows for separate commands under `C-i'
   ;; and TAB or `C-m' and `RET'.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab t

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
   dotspacemacs-which-key-delay 0.4

   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; It is also possible to use a posframe with the following cons cell
   ;; `(posframe . position)' where position can be one of `center',
   ;; `top-center', `bottom-center', `top-left-corner', `top-right-corner',
   ;; `top-right-corner', `bottom-left-corner' or `bottom-right-corner'
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom

   ;; Control where `switch-to-buffer' displays the buffer. If nil,
   ;; `switch-to-buffer' displays the buffer in the current window even if
   ;; another same-purpose window is available. If non-nil, `switch-to-buffer'
   ;; displays the buffer in a same-purpose window even if the buffer can be
   ;; displayed in the current window. (default nil)
   dotspacemacs-switch-to-buffer-prefers-purpose nil

   ;; Whether side windows (such as those created by treemacs or neotree)
   ;; are kept or minimized by `spacemacs/toggle-maximize-window' (SPC w m).
   ;; (default t)
   dotspacemacs-maximize-window-keep-side-windows t

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
   ;; (default t) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup t

   ;; If non-nil the frame is undecorated when Emacs starts up. Combine this
   ;; variable with `dotspacemacs-maximized-at-startup' to obtain fullscreen
   ;; without external boxes. Also disables the internal border. (default nil)
   dotspacemacs-undecorated-at-startup nil

   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90

   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 40

   ;; A value from the range (0..100), in increasing opacity, which describes the
   ;; transparency level of a frame background when it's active or selected. Transparency
   ;; can be toggled through `toggle-background-transparency'. (default 90)
   dotspacemacs-background-transparency 90

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

   ;; Show the scroll bar while scrolling. The auto hide time can be configured
   ;; by setting this variable to a number. (default t)
   dotspacemacs-scroll-bar-while-scrolling nil

   ;; Control line numbers activation.
   ;; If set to `t', `relative' or `visual' then line numbers are enabled in all
   ;; `prog-mode' and `text-mode' derivatives. If set to `relative', line
   ;; numbers are relative. If set to `visual', line numbers are also relative,
   ;; but only visual lines are counted. For example, folded lines will not be
   ;; counted and wrapped lines are counted as multiple lines.
   ;; This variable can also be set to a property list for finer control:
   ;; '(:relative nil
   ;;   :visual nil
   ;;   :disabled-for-modes dired-mode
   ;;                       doc-view-mode
   ;;                       markdown-mode
   ;;                       org-mode
   ;;                       pdf-view-mode
   ;;                       text-mode
   ;;   :size-limit-kb 1000)
   ;; When used in a plist, `visual' takes precedence over `relative'.
   ;; (default nil)
   dotspacemacs-line-numbers t

   ;; Code folding method. Possible values are `evil', `origami' and `vimish'.
   ;; (default 'evil)
   dotspacemacs-folding-method 'evil

   ;; If non-nil and `dotspacemacs-activate-smartparens-mode' is also non-nil,
   ;; `smartparens-strict-mode' will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil

   ;; If non-nil smartparens-mode will be enabled in programming modes.
   ;; (default t)
   dotspacemacs-activate-smartparens-mode t

   ;; If non-nil pressing the closing parenthesis `)' key in insert mode passes
   ;; over any automatically added closing parenthesis, bracket, quote, etc...
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

   ;; The backend used for undo/redo functionality. Possible values are
   ;; `undo-fu', `undo-redo' and `undo-tree' see also `evil-undo-system'.
   ;; Note that saved undo history does not get transferred when changing
   ;; your undo system. The default is currently `undo-fu' as `undo-tree'
   ;; is not maintained anymore and `undo-redo' is very basic."
   dotspacemacs-undo-system 'undo-fu

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
   ;; If nil then Spacemacs uses default `frame-title-format' to avoid
   ;; performance issues, instead of calculating the frame title by
   ;; `spacemacs/title-prepare' all the time.
   ;; (default "%I@%S")
   dotspacemacs-frame-title-format "%a [%t] : %p"

   ;; Format specification for setting the icon title format
   ;; (default nil - same as frame-title-format)
   dotspacemacs-icon-title-format nil

   ;; Color highlight trailing whitespace in all prog-mode and text-mode derived
   ;; modes such as c++-mode, python-mode, emacs-lisp, html-mode, rst-mode etc.
   ;; (default t)
   dotspacemacs-show-trailing-whitespace t

   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed' to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; The variable `global-spacemacs-whitespace-cleanup-modes' controls
   ;; which major modes have whitespace cleanup enabled or disabled
   ;; by default.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup 'trailing

   ;; If non-nil activate `clean-aindent-mode' which tries to correct
   ;; virtual indentation of simple modes. This can interfere with mode specific
   ;; indent handling like has been reported for `go-mode'.
   ;; If it does deactivate it here.
   ;; (default t)
   dotspacemacs-use-clean-aindent-mode nil

   ;; Accept SPC as y for prompts if non-nil. (default nil)
   dotspacemacs-use-SPC-as-y t

   ;; If non-nil shift your number row to match the entered keyboard layout
   ;; (only in insert state). Currently supported keyboard layouts are:
   ;; `qwerty-us', `qwertz-de' and `querty-ca-fr'.
   ;; New layouts can be added in `spacemacs-editing' layer.
   ;; (default nil)
   dotspacemacs-swap-number-row nil

   ;; Either nil or a number of seconds. If non-nil zone out after the specified
   ;; number of seconds. (default nil)
   dotspacemacs-zone-out-when-idle nil

   ;; Run `spacemacs/prettify-org-buffer' when
   ;; visiting README.org files of Spacemacs.
   ;; (default nil)
   dotspacemacs-pretty-docs nil

   ;; If nil the home buffer shows the full path of agenda items
   ;; and todos. If non-nil only the file name is shown.
   dotspacemacs-home-shorten-agenda-source nil

   ;; If non-nil then byte-compile some of Spacemacs files.
   dotspacemacs-byte-compile t))

(defun dotspacemacs/user-env ()
  "Environment variables setup.
This function defines the environment variables for your Emacs session. By
default it calls `spacemacs/load-spacemacs-env' which loads the environment
variables declared in `~/.spacemacs.env' or `~/.spacemacs.d/.spacemacs.env'.
See the header of this file for more information."
  (spacemacs/load-spacemacs-env)
  )

(defun dotspacemacs/user-init ()
  "Initialization for user code:
This function is called immediately after `dotspacemacs/init', before layer
configuration.
It is mostly for variables that should be set before packages are loaded.
If you are unsure, try setting them in `dotspacemacs/user-config' first."
  (setq evil-normal-state-tag    "NORMAL"
        evil-emacs-state-tag     "EMACS"
        evil-hybrid-state-tag    "HYBRID"
        evil-insert-state-tag    "INSERT"
        evil-visual-state-tag    "VISUAL"
        evil-lisp-state-tag      "LISP"
        evil-motion-state-tag    "MOTION"
        evil-operator-state-tag  "OPERATOR"
        evil-replace-state-tag   "REPLACE"
        evil-evilified-state-tag "EVIL")

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
        ((buffer-modified buffer-id)
         :priority 98)
        ((which-function remote-host line-column buffer-position buffer-size)
         :priority 79)
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
      '((python-pyvenv :fallback python-pyenv)
        (purpose :priority 94)
        (battery :when active)
        (selection-info :priority 95)
        input-method
        ((buffer-encoding-abbrev
          point-position
          ;; line-column
          )
         :separator " | "
         :priority 96)
        (global :when active)
        ;; (buffer-position :priority 99)
        ;; (buffer-size :priority 99)
        ;; (hud :priority 99)
        ))
    (with-eval-after-load 'spaceline
      ;; Hijacks existing segment.  Should add cases for both envs.
      (spaceline-define-segment python-pyenv
        "The current python env.  Works with `conda'."
        (when (and active
                   ;; TODO: Consider not restricting to `python-mode', because
                   ;; conda envs can apply to more than just python operations
                   ;; (e.g. libraries, executables).
                   ;; (eq 'python-mode major-mode)
                   ;; TODO: Display `conda-project-env-name' instead?  It's buffer-local.
                   (boundp 'conda-env-current-name)
                   (stringp conda-env-current-name))
          (propertize conda-env-current-name 'face 'spaceline-python-venv
                      'help-echo "Virtual environment (via conda)")))
      (spaceline-compile))
    (setq-default mode-line-format '("%e" (:eval (spaceline-ml-main)))))
  (setq theming-modifications
        '((spacemacs-dark
           (font-lock-comment-face :foreground "DimGrey")
           )))

  ;; spell checking
  ;; NOTE: install hunspell
  (cond
   ;; try hunspell at first
   ;; if hunspell does NOT exist, use aspell
   ;; NOTE: Using hunspell may produce the "Error enabling Flyspell mode: (stringp nil)" problem
   ;; FIXME: comment hunspell part out when the buf of hunspell 1.7.0 is fixed: https://www.reddit.com/r/emacs/comments/air595
   ;; ((executable-find "hunspell")
   ;;  (setq ispell-program-name "hunspell"
   ;;        ;; NOTE: this file is for hunspell, aspell uses another file and format(~/.aspell.en.pws)
   ;;        ;; FIXME: unable to merge dictionaries for aspell and hunspell into one
   ;;        ispell-personal-dictionary "~/.spacemacs.d/ispell_en_US"))
   ((executable-find "aspell")
    (setq ispell-program-name "aspell"
          ;; Please note ispell-extra-args contains ACTUAL parameters passed to aspell
          ispell-extra-args '("--sug-mode=ultra" "--lang=en_US"))
    ;; (message "hunspell not found, use aspell for spell-check!")
    ))
  (setq ispell-local-dictionary "en_US"
        ispell-local-dictionary-alist
        ;; Please note the list `("-d" "en_US")` contains ACTUAL parameters passed to hunspell
        ;; You could use `("-d" "en_US,en_US-med")` to check with multiple dictionaries
        '(("en_US" "[[:alpha:]]" "[^[:alpha:]]" "[']" nil ("-d" "en_US") nil utf-8))
        ;; number of windows is independent in multiple frames
        winum-scope 'frame-local
        ispell-alternate-dictionary (expand-file-name
                                     "~/Dotfiles.d/spacemacs/.spacemacs.d/lisp/words.txt")
        )
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

  (add-to-list 'load-path "~/.spacemacs.d/lisp/")
  ;; disable scroll-bar-mode in newly created frame
  ;; This also fix the bug when scroll bar still shows in daemon/emacsclient
  (add-hook 'after-make-frame-functions
            (lambda (frame)
              (modify-frame-parameters
               frame
               '((vertical-scroll-bars . nil)
                 (horizontal-scroll-bars . nil)))
              (select-frame frame)
              (spacemacs/toggle-maximize-frame-on)
              (delete-other-windows)
              ))

  ;; prevent package-selected-package list been created
  (defun package--save-selected-packages (&rest opt) nil)

  (setq-default
   ;; always show trailing whitespace, spacemacs only it in prog-mode by default
   ;; show-trailing-whitespace t
   ;; change the major mode of any file without extension to org-mode instead of fundamental-mode
   )
  ;; disable loading the default theme for terminal emacs
  (unless (display-graphic-p)
    (disable-theme 'spacemacs-dark))
  (setq
   ;; open a link not prompt yes/no
   vc-follow-symlinks t
   ;; disable the warning message
   python-spacemacs-indent-guess nil
   ;; disable gui pop window
   use-dialog-box nil
   ;; column number starts from 1
   column-number-indicator-zero-based nil
   bookmark-default-file "~/.spacemacs.d/bookmarks"
   ;; make cursor the width of the character it is under i.e. full width of a TAB
   x-stretch-cursor t
   ;; which-key
   which-key-show-remaining-keys t
   which-key-highlighted-command-list
   '("helm\\|counsel\\|ivy\\|swiper\\|toggle\\|projectile\\|describe"
     ("\\(^cscope\\)\\|\\(^ggtags\\)" . warning)
     ("register\\|transient\\|hydra" . success)
     ("rectangle\\|goto\\|lsp\\|xah" . error)
     ("help\\|emacs\\|bookmarks" . highlight)
     )
   comment-dwim-2--inline-comment-behavior 'reindent-comment
   git-gutter+-modified-sign "*"
   git-gutter+-diff-option ""
   git-commit-major-mode 'org-mode
   spaceline-org-clock-p t
   ;; sometimes emacs will unable to quit because of persp-auto-save
   persp-auto-save-opt 0
   ;; https://emacs.stackexchange.com/questions/3358
   ;; https://stackoverflow.com/questions/10474555
   evil-want-fine-undo t
   ;; Persistent undo, undo is usable for old history even restart Emacs
   ;; https://github.com/syl20bnr/spacemacs/issues/774
   undo-tree-auto-save-history t
   undo-tree-history-directory-alist `(("." . ,(concat spacemacs-cache-directory "undo")))
   ;; NOTE: when saving a file becomes slow because of the file in ~/.emacs.d/.cache/undo
   ;; becomes very big, use `(setq buffer-undo-tree nil)' to clean that file completely
   ;; set the limit for file in ~/.emacs.d/.cache/undo, around 10MB
   ;; TODO: not work
   undo-limit 10000000
   undo-strong-limit 10000000
   undo-outer-limit 10000000
   ;; to cause the *compilation* buffer to automatically scroll to the end of new output
   compilation-scroll-output t
   ;; TODO: delete it until the recentf issue is fixed
   ;; spacemacs/issues/5186#issuecomment-31286766
   ;; NOTE: recentf issue also causes the problem of 2 mins of delay for reboot/shutdown
   ;; workaround by changing emacs.service: spacemacs/issues/12873#issuecomment-558252242
   ;; reddit.com/r/emacs/comments/do67z3/emacsservice_will_delay_2_mins_before/flm97pm
   ;; recentf-save-file (format "/tmp/recentf.%s" (emacs-pid))
   ;; compile
   compilation-last-buffer nil
   ;; save all modified buffers without asking before compilation
   compilation-ask-about-save nil
   compilation-auto-jump-to-first-error t
   ;; create a new small frame to show the compilation info
   ;; will be auto closed if no error
   ;; special-display-buffer-names `(("*compilation*" .
   ;;                                 ((name . "*compilation*")
   ;;                                  ,@default-frame-alist
   ;;                                  (left . (- 1))
   ;;                                  (top . 0))))
   ;; NOTE: disable the following config since it affects cargo will has no compilation window
   ;; compilation-finish-functions (lambda (buf str)
   ;;                                (if (null (string-match ".*exited abnormally.*" str))
   ;;                                    ;; no errors, make the compilation window go away in a few seconds
   ;;                                    (progn
   ;;                                      ;; (run-at-time
   ;;                                      ;;  "10 sec" nil 'delete-windows-on
   ;;                                      ;;  (get-buffer-create "*compilation*"))
   ;;                                      (message "No Compilation Errors!"))
   ;;                                  (switch-to-buffer "*compilation*")
   ;;                                  ))
   find-file-visit-truename t
   ;; using translate-shell cli tool, which is trans binary in bin
   ;; translate-shell-command "proxychains4 -q trans -t en %s"
   ;; translate-shell-brief-command "proxychains4 -q trans -brief -t zh %s"
   translate-shell-command "trans :zh+en -d -show-dictionary Y -v -no-ansi %s"
   translate-shell-brief-command "trans -brief -t zh %s"
   ;; options for counsel-fzf function to open file in PWD using fzf
   counsel-fzf-cmd "rg --files --hidden --no-ignore -g !.git | fzf -m $FZF_DEFAULT_OPTS -f \"%s\""
   ;; Putting the following two setq in lsp layer doesn't work
   lsp-completion-provider :capf
   lsp-completion-default-behaviour :insert
   ;; default value alien will ignore projectile-globally-ignored-directories
   projectile-indexing-method 'hybrid
   )
  ;; to make which-function in spaceline-custom-theme work
  (which-function-mode)

  ;; NOTE: along with undo-tree-auto-save-history
  (unless (file-exists-p (concat spacemacs-cache-directory "undo"))
    (make-directory (concat spacemacs-cache-directory "undo")))

  ;; overwrite selected region when typing, yanking
  (delete-selection-mode)

  ;; auto refresh git-gutter+ info for all buffers when magit makes changes
  ;; migrated from git-gutter:update-all-windows, git-gutter+ supports this for old magit
  (add-hook 'magit-post-refresh-hook
            (lambda ()
              (dolist (win (window-list))
                (let ((buf (window-buffer win)))
                  (with-current-buffer buf
                    (when git-gutter+-mode
                      (git-gutter+-refresh)))))))

  ;; disable read-only when open ansi-term, make it work normally
  (evil-set-initial-state 'term-mode 'emacs)

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
      (if use-region nil       ;Only if we're working with a line (not a region)
        (let ((pos (- (point) (line-beginning-position)))) ;Save column
          (if (> 0 n)						;Comment out original with negative arg
              (comment-region (line-beginning-position) (line-end-position)))
          (forward-line 1)
          (forward-char pos)))))

  (global-syntax-subword-mode)
  ;; delete not kill it into kill-ring
  ;; _based on_ http://ergoemacs.org/emacs/emacs_kill-ring.html
  (defun delete-word (arg)
    "Delete characters forward until encountering the end of a syntax-subword.
With argument, do this that many times.
This command does not push text to `kill-ring'."
    (interactive "p")
    (delete-region
     (point)
     (progn
       (syntax-subword-forward arg)
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
  (defun mu-magit-kill-buffers (param)
    "Restore window configuration and kill all Magit buffers."
    ;; (interactive)
    (let ((buffers (magit-mode-get-buffers)))
      (magit-restore-window-configuration)
      (mapc #'kill-buffer buffers)))
  (with-eval-after-load 'magit
    ;; default value of magit-bury-buffer-function only hide magit related buffers
    (setq magit-bury-buffer-function #'mu-magit-kill-buffers)
    ;; turn this off in large repo since it may be slow
    (add-hook 'after-save-hook 'magit-after-save-refresh-status t)
    ;; overwrite the default M-1/2/3/4 since they are used for winum like in other modes
    ;; Use C-tab or S-tab to show section-cycle
    (bind-keys :map magit-mode-map
               ("M-1" . winum-select-window-1)
               ("M-2" . winum-select-window-2)
               ("M-3" . winum-select-window-3)
               ("M-4" . winum-select-window-4)
               )
    (add-hook 'magit-diff-mode-hook (lambda () (setq truncate-lines nil)))
    )

  (with-eval-after-load 'company
    (bind-keys :map company-active-map
               ;; NOTE: C-d/C-h/F1 all call company-show-doc-buffer when point is in company completion list
               ;; it will affect the snippets which C-d is to delete the word
               ("C-d" . yas-skip-and-clear-field)))

  ;; show snippets in company list, don't know why auto-completion-enable-snippets-in-popup doesn't work
  (defun autocomplete-show-snippets ()
    "Show snippets in autocomplete popup."
    (let ((backend (car company-backends)))
      (unless (listp backend)
        (setcar company-backends `(,backend :with company-yasnippet company-files)))))
  (with-eval-after-load 'company
    (add-hook 'after-change-major-mode-hook 'autocomplete-show-snippets))

  ;; highlight-indent-guides
  ;; TODO: uncomment his line when the character can be displayed correctly
  ;; (add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
  (setq highlight-indent-guides-auto-enabled nil
        highlight-indent-guides-method 'character
        ;; Indent character samples: | ┆ ┊ ⁞
        highlight-indent-guides-character ?\┊)

  ;; highlight keywords like TODO/FIXME
  (dolist (hook '(prog-mode-hook org-mode-hook))
    (add-hook hook
              (lambda ()
                (font-lock-add-keywords
                 nil
                 '(("\\<\\(TODO\\|NOTE\\|FIXME\\|ERROR\\|FIX\\|BUG\\|WARNING\\)" 1
                    '(:background "yellow") t))))))

  (defun rename-this-buffer-and-file ()
    "Renames current buffer and file it is visiting."
    (interactive)
    (let ((name (buffer-name))
          (filename (buffer-file-name)))
      (if (not (and filename (file-exists-p filename)))
          (error "Buffer '%s' is not visiting a file!" name)
        (let ((new-name (read-file-name "New name: " filename)))
          (cond ((get-buffer new-name)
                 (error "A buffer named '%s' already exists!" new-name))
                (t
                 (rename-file filename new-name 1)
                 (rename-buffer new-name)
                 (set-visited-file-name new-name)
                 (set-buffer-modified-p nil)
                 (message "File '%s' successfully renamed to '%s'" name
                          (file-name-nondirectory new-name))))))))

  (defun copy-name ()
    "Copy the name (NOT full path) of current buffer file to the clipboard."
    (interactive)
    (let* ((filename (file-name-nondirectory buffer-file-name)))
      (when filename
        (kill-new filename)
        (message "'%s' name copied!" filename))))
  (defun copy-path-short ()
    "Copy the path of current buffer file to the clipboard."
    (interactive)
    (let ((filename
           (if (equal major-mode 'dired-mode)
               default-directory
             ;; abbreviate-file-name will replace /home/user with ~
             ;; also works with directory
             (if buffer-file-name
                 (abbreviate-file-name buffer-file-name)
               (user-error "Current buffer is not a file/directory in disk!" "exit")))))
      (when filename
        (kill-new filename)
        (message "'%s' path copied!" filename))))
  (defun copy-path ()
    "Copy the full path of current buffer file to the clipboard."
    (interactive)
    (let ((filename
           (if (equal major-mode 'dired-mode)
               default-directory
             (buffer-file-name))))
      (if filename
          (progn
            (kill-new filename)
            (message "'%s' path copied!" filename))
        (message "Current buffer is not a file/directory in disk!"))))
  (defun copy-path-html ()
    "Copy the html of according to the current buffer, this is useful when exporting org file to html."
    (interactive)
    (let ((filename
           (if (equal major-mode 'dired-mode)
               default-directory
             (buffer-file-name))))
      (if filename
          (progn
            (kill-new filename)
            (message "'%s' path copied!" filename))
        ;; print error message and exit/return the function
        (user-error "Current buffer is not a file in disk!" "exit")))
    (let ((html-file (concat (file-name-sans-extension (buffer-file-name)) ".html")))
      (if (file-exists-p html-file)
          (progn
            (kill-new html-file)
            (message "'%s' path copied!" html-file))
        (message "'%s' is not a file in disk!" html-file))))
  (defun copy-path-pdf ()
    "Copy the pdf of according to the current buffer, this is useful when exporting org file to html."
    (interactive)
    (let ((filename
           (if (equal major-mode 'dired-mode)
               default-directory
             (buffer-file-name))))
      (if filename
          (progn
            (kill-new filename)
            (message "'%s' path copied!" filename))
        ;; print error message and exit/return the function
        (user-error "Current buffer is not a file in disk!" "exit")))
    (let ((pdf-file (concat (file-name-sans-extension (buffer-file-name)) ".pdf")))
      (if (file-exists-p pdf-file)
          (progn
            (kill-new pdf-file)
            (message "'%s' path copied!" pdf-file))
        (message "'%s' is not a file in disk!" pdf-file))))

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
  (spacemacs/declare-prefix "=" "format/indent")
  (spacemacs/declare-prefix "L" "leetcode")
  (spacemacs/set-leader-keys
    ;; the default binding is counsel-switch-buffer
    "bb" 'counsel-ibuffer
    ;; overwrite the default bB
    "bB" 'counsel-buffer-or-recentf
    "bl" 'ivy-switch-buffer
    "bU" 'reopen-killed-buffer-fancy
    ;; whitespace-cleanup will also do untabify-it/tabify-it automatically
    ;; according indent-tabs-mode, so the definitions of two functions are not needed
    "bc" 'whitespace-cleanup
    ;; original: SPC b N I
    "bC" 'clone-indirect-buffer-other-window-without-purpose
    ;; overwrite the default br
    "br" 'revert-buffer-without-asking
    ;; overwrite the default bR
    "bR" 'rename-this-buffer-and-file
    ;; there are extra several related functions: copy-name/path-short/path/html/pdf
    "b SPC" 'copy-path
    "bN" 'copy-name
    "bi" 'count-words
    "bI" 'count-words-region
    ;; the default cc is for compile
    "cc" 'smart-compile-again
    "cC" 'smart-compile
    "dC" 'dap-clean-buffers
    "dQ" 'dap-disconnect
    "dR" 'dap-debug-restart
    "tG" 'highlight-indent-guides-mode
    "tt" 'spacemacs/toggle-relative-line-numbers
    "tT" 'spacemacs/toggle-line-numbers
    ;; fD delete current file and buffer, fd choose the file and delete the buffer
    "fd" 'spacemacs/delete-file
    "fYn" 'yas-new-snippet
    "fYr" 'yas-reload-all
    "fYi" 'yas-insert-snippet
    "fYv" 'yas-visit-snippet-file
    ;; NOTE: the hints for the following lambda functions are in spacemacs/declare-prefix
    "fxf" (lambda () (interactive) (find-file "~/.config/fish/config.fish"))
    "fxi" (lambda () (interactive) (find-file "~/.config/i3/config"))
    "fxt" (lambda () (interactive) (find-file "~/.config/tmux/tmux.conf"))
    "fxT" (lambda () (interactive) (find-file "~/.local/bin/t"))
    "fxe" (lambda () (interactive) (find-file "~/.local/bin/emm"))
    "fxE" (lambda () (interactive) (find-file "~/ve.emacs.d/init.el"))
    "fp" 'run-python
    ;; the default binding is SPC j =
    "=b" 'spacemacs/indent-region-or-buffer
    "==" 'format-all-buffer
    "=t" 'format-all-mode
    "bq" 'query-replace-region-or-from-top
    "bf" 'flush-blank-lines
    ;; related one is default M-q
    "bt" 'tabify-or-untabify
    "bM" 'hide-ctrl-M
    ;; default feR, still works
    "dt" 'treemacs-select-directory
    "fer" 'dotspacemacs/sync-configuration-layers
    "fF" 'find-alternate-file
    "fa" 'counsel-fzf
    "Xd" 'delete-line-or-region-or-buffer
    "Xc" 'copy-line-or-region-or-buffer
    "Xk" 'cut-line-or-region-or-buffer
    ;; overwrite the default spacemacs/spell-checking-transient-state/body
    "S." 'spacemacs/ispell-transient-state/body
    "xX" 'quickrun-compile-only
    "XX" 'spacemacs/change-case-transient-state/body
    "Xm" 'spacemacs/cool-moves-transient-state/body
    "Xr" 'spacemacs/rectangle-transient-state/body
    "XR" 'recover-this-file
    "Xh" 'spacemacs/hl-todo-transient-state/body
    "pC" 'cargo-process-new
    "Sg" 'flyspell-correct-word-generic
    "Sc" 'flyspell-correct-at-point
    "Sw" 'flyspell-correct-wrapper
    "Sn" 'flyspell-correct-next
    "Sp" 'flyspell-correct-previous
    "SN" 'flyspell-goto-next-error
    ;; correct the wrong word with prefix+i, next time auto-correct it, defined bellow
    "Ss" 'endless/ispell-word-then-abbrev
    "SS" 'ispell-complete-word
    "ST" 'translate-shell-brief
    "St" 'translate-shell
    ;; replace swiper with swiper-isearch since swiper doen't refresh ivy-resume list
    "ss" 'swiper-isearch
    "sw" 'swiper-whole-word
    "sW" 'spacemacs/swiper-region-or-symbol-whole-word
    "sR" 'recentf-save-list
    "tC" 'rainbow-mode
    "t=" 'format-all-mode
    "xA" 'align-regexp
    "xaA" 'align-regexp
    "xaC" 'align-c-comments
    "xaM" 'align-c-macros
    "xe" 'embrace-commander
    ;; The original binding is f1-o, C-h o
    "hh" 'counsel-describe-symbol
    ;; The original binding is SPC C e
    ;; There is another function counsel-colors-web
    "hc" 'counsel-colors-emacs
    ;; The original binding is SPC C f
    "hC" 'counsel-faces
    ;; The original binding is SPC h d v
    "hv" 'counsel-describe-variable
    ;; The original binding is SPC h d f
    "hf" 'counsel-describe-function
    ;; The original binding is SPC h d F
    "hF" 'counsel-describe-face
    ;; The original binding is SPC h d b
    "hb" 'counsel-descbinds
    "nn" 'narrow-or-widen-dwim
    ;; overwrite the default SPC w -//
    "w-" 'split-window-below-next-buffer
    "w/" 'split-window-right-next-buffer
    "w\\" 'split-window-right-next-buffer
    "w RET" 'split-window-smart
    ;; the default binding is SPC w +
    "w SPC" 'spacemacs/window-layout-toggle
    ;; the default is other-frame
    "wo" 'spacemacs/window-split-single-column
    ;; original: SPC b N I
    "wC" 'clone-indirect-buffer-other-window-without-purpose
    ;; the default binding is SPC j b
    "j SPC" 'avy-pop-mark
    "jr" 'avy-resume
    ;; leetcode
    "Ll" 'leetcode
    "Ld" 'leetcode-show-description
    "Lr" 'leetcode-problems-refresh
    "Lt" 'leetcode-try
    "Ls" 'leetcode-submit
    ;; the default is for treemacs-select-window
    ;; the other bindings for treemacs-select-window are M-0/C-x w 0
    "0" 'spacemacs/switch-to-minibuffer-window
    )
  (spacemacs/declare-prefix "fx" "Open the files: ")
  (spacemacs/declare-prefix "fxf" "open fish/config.fish")
  (spacemacs/declare-prefix "fxi" "open i3/config")
  (spacemacs/declare-prefix "fxt" "open tmux/tmux.conf")
  (spacemacs/declare-prefix "fxT" "open bin/t")
  (spacemacs/declare-prefix "fxe" "open bin/emm")
  (spacemacs/declare-prefix "fxE" "open ve.emacs.d/init.el")

  (defun switch-to-ein-notebooklist-buffer ()
    (interactive)
    (loop for buffer in (buffer-list)
          do (if
                 ;; if a buffer name starts with patter
                 (string-match-p "\\*ein:notebooklist" (buffer-name buffer))
                 (switch-to-buffer buffer))))
  ;; when opening an existed ipynb file, start jupyter notebook server automatically
  (add-hook 'find-file-hook
            (lambda ()
              (when (eq major-mode 'ein:ipynb-mode)
                (call-interactively #'ein:process-find-file-callback)
                )))
  (with-eval-after-load 'ein-notebook
    (spacemacs/set-leader-keys-for-minor-mode 'ein:notebook-mode
      ;; switch to ein:notebooklist buffer
      "a" #'switch-to-ein-notebooklist-buffer
      "n" #'ein:notebooklist-new-notebook-with-name
      "q" #'ein:stop
      "," #'ein:worksheet-execute-all-cells-below
      "R" #'ein:worksheet-execute-all-cells
      "C-S-r" #'ein:worksheet-execute-all-cells-above)
    (bind-keys :map ein:notebooklist-mode-map
               ("C-c q" . ein:stop)
               ("C-c C-n" . ein:notebooklist-new-notebook-with-name)
               )
    (spacemacs|add-company-backends
      :backends company-anaconda
      :modes ein:notebook-mode)
    )

  (defun revert-buffer-without-asking ()
    "Revert buffer without asking"
    (interactive)
    (revert-buffer nil t))

  ;; symbol-overlay replaces highlight-symbol
  (dolist (hook '(prog-mode-hook org-mode-hook))
    (add-hook hook #'symbol-overlay-mode))

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
        (delete-blank-lines))))
  (bind-keys*
   ("C-x DEL" . xah-shrink-whitespaces)
   ("M-%" . query-replace-region-or-from-top)
   ("M-c" . xah-toggle-letter-case)
   ;; no alternate from ivy for helm-for-files
   ;; ("M-z" . helm-for-files)
   ("C-h h" . counsel-describe-symbol)
   ("C-h c" . counsel-colors-emacs)
   ("C-h C-c" . counsel-faces)
   ("C-h F" . counsel-describe-face)
   ("C-x /" . spacemacs/counsel-jump-in-buffer)   ;; SPC j i
   ("C-x x" . switch-to-prev-visited-buffer)
   ("M-;" . comment-dwim-2)
   ("M-n" . symbol-overlay-jump-next)
   ("M-p" . symbol-overlay-jump-prev)
   ("M-d" . delete-word)
   ("<M-backspace>" . delete-word-backward)
   ("<M-S-backspace>" . ido-delete-backward-word-updir)
   ("C-k" . delete-line-to-end)
   ("C-c k" . delete-line-backward)
   ("C-c d" . duplicate-line-or-region)
   ("C-c D" . delete-duplicated-lines-buffer-or-region)
   ("M-RET" . Meta-return)
   ("<C-return>" . Ctrl-return)         ; NOTE C-RET doesn't work as expected
   ("M-`" . other-window)
   ("C-<tab>" . spacemacs/tabs-forward)
   ("C-<iso-lefttab>" . spacemacs/tabs-backward)
   ("C-x C-<tab>" . centaur-tabs-counsel-switch-group)
   ("C-c C-j" . lsp-execute-code-action)
   ("<f8>" . spacemacs/shell-pop-ansi-term)
   ("<f9>" . other-window)
   )
  (bind-keys :map evil-hybrid-state-map
             ;; not put it into global, it goes wrong in helm mode
             ("RET" . advanced-return)
             ;; don't put the following lines into global bind-keys, it won't work
             ("C-a" . keep-beginning-of-code-or-line)
             ("C-e" . keep-end-of-code-or-line)
             )
  (bind-keys :map evil-visual-state-map
             ("C-a" . keep-beginning-of-code-or-line)
             ("C-e" . keep-end-of-code-or-line)
             )
  (bind-keys :map evil-normal-state-map
             ;; NOTE: xref, lsp, jump-to-definition/-other-window all have goto-definition functions,
             ;; jump-to-definition/-other-window work badly for lsp project(freeze after jump, not work on some symbols),
             ;; lsp doesn't have other-window function
             ;; xref doesn't work for lsp project
             ("g d" . evil-goto-definition)
             ("g D" . evil-goto-definition-other-window)
             ("g p" . lsp-ui-peek-find-definitions)
             ("g r" . lsp-ui-peek-find-references)
             ("g R" . xref-find-references)
             ;; overwrite the default evil-scroll-down
             ("C-d" . sp-delete-char)
             ;; overwrite the default evil-scroll-up
             ("C-u" . universal-argument)
             ;; record new macro is q, the default execute macro is @
             ("Q" . evil-execute-macro)
             ("U" . undo-tree-visualize)
             ("C-a" . keep-beginning-of-code-or-line)
             ("C-e" . keep-end-of-code-or-line)
             ("[ u" . spacemacs/vcs-revert-hunk)
             ("] u" . spacemacs/vcs-revert-hunk)
             ("[ a" . spacemacs/vcs-stage-hunk)
             ("] a" . spacemacs/vcs-stage-hunk)
             ("[ d" . spacemacs/vcs-show-hunk)
             ("] d" . spacemacs/vcs-show-hunk)
             ;; The default binding is [ h
             ("[ '" . spacemacs/vcs-previous-hunk)
             ;; The default binding is ] h
             ("] '" . spacemacs/vcs-next-hunk)
             ("[ c" . spacemacs/vcs-transient-state/magit-commit-and-exit)
             ("[ P" . spacemacs/vcs-transient-state/magit-push-and-exit)
             ("[ A" . git-gutter+-stage-and-commit)
             ("[ r" . git-gutter+-refresh)
             )
  ;; by default, f11 is bound to toggle-frame-fullscreen, but it easy to affect f12
  (unbind-key "<f11>" global-map)
  ;; use C-tab and C-S-tab for switching tabs
  (unbind-key "C-<tab>" evil-motion-state-map)
  (unbind-key "C-<iso-lefttab>" evil-motion-state-map)

  (with-eval-after-load 'leetcode
    (bind-keys :map leetcode--problems-mode-map
               ("<return>" . leetcode-show-description)))

  (with-eval-after-load 'ivy
    (setq ivy-count-format "%d/%d> "
          ivy-initial-inputs-alist nil
          ivy-magic-tilde nil
          ;; ivy-use-virtual-buffers nil
          ;; C-c C-a to ivy-toggle-ignore
          ivy-ignore-buffers '("\\` " "\\`\\*")
          ;; preselect current file in list of candidates
          counsel-preselect-current-file t
          ;; set ivy-height to 1/2 frame instead the fixed 15
          ivy-height-alist
          '((t
             lambda (_caller)
             (/ (frame-height) 3)))
          ))

  (with-eval-after-load 'yasnippet
    (setq yas-snippet-dirs (remq 'yasnippet-snippets-dir yas-snippet-dirs)))

  ;; whitespace faces
  (with-eval-after-load 'whitespace
    ;; (set-face-attribute 'whitespace-space-after-tab nil :background "red" :foreground "yellow")
    ;; for clang-format, don't highlight the spaces use by alignment
    (set-face-attribute 'whitespace-space-after-tab nil :background nil :foreground nil)
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

  ;; colors of swiper result in buffer
  (custom-set-faces
   '(swiper-match-face-1
     ((t :background "red")))
   '(swiper-match-face-2
     ((t :background "yellow")))
   '(swiper-match-face-3
     ((t :background "blue")))
   '(swiper-match-face-4
     ((t :background "white"))))

  ;; highlight selected, to fix the issue that when the expr is already
  ;; highlighted(word occurs), no color for selected region
  (add-hook 'after-change-major-mode-hook
            (lambda ()
              (set-face-attribute 'region nil :background "white")))

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
  (add-hook 'vimrc-mode-hook
            (lambda ()
              (setq indent-tabs-mode nil)))
  (add-hook 'python-mode-hook
            (lambda ()
              (set (make-local-variable 'comment-inline-offset) 2) ; PEP8 two spaces
              (setq indent-tabs-mode nil
                    tab-width 4)))
  (add-hook 'c-mode-hook
            (lambda ()
              (c-set-style "linux")
              (setq tab-width 8
                    indent-tabs-mode t ;;default in linux kernel
                    c-basic-offset 8)
              ;; make comment aligned with the code block/line
              (c-set-offset 'comment-intro 0)))
  (add-hook 'c++-mode-hook
            (lambda ()
              (c-set-style "linux")
              (setq tab-width 4
                    indent-tabs-mode t ;;default in linux kernel
                    c-basic-offset 4)
              ;; the indent level for method in class
              ;; https://stackoverflow.com/a/14668848/1528712
              (c-set-offset 'inline-open 0)))
  (add-hook 'rust-mode-hook
            (lambda ()
              (setq indent-tabs-mode nil)))
  (add-hook 'makefile-mode-hook
            (lambda ()
              (setq tab-width 8)))
  (add-hook 'fish-mode-hook
            (lambda ()
              (setq indent-tabs-mode nil)))

  ;; format-all package and the following config replaces all the format-on-save variables
  ;; provided or not-yet-provided by spacemacs
  (add-hook 'prog-mode-hook 'format-all-mode)
  (add-hook 'toml-mode-hook 'format-all-mode)
  (add-hook 'format-all-mode-hook 'format-all-ensure-formatter)

  (defun switch-to-prev-visited-buffer ()
    "Switch to the prev visited buffer, repeated invocations toggle between
 the most recent two buffers, this is different from SPC TAB,
which switch the last buffer in this window."
    (interactive)
    (switch-to-buffer
     (other-buffer (current-buffer) 1)))

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

  (add-hook 'with-editor-mode-hook
            (lambda ()
              ;; insert mode by default in commit editing buffer
              (evil-insert-state)
              (smartparens-mode)))
  ;; to disable warning "Warning (with-editor): Cannot determine a suitable Emacsclient" when starting emacs
  (setq-default with-editor-emacsclient-executable "emacsclient")

  ;; wrap long line from the margin, not break, just visually wrap lone line
  (spacemacs/toggle-truncate-lines-off)
  (add-hook 'org-mode-hook 'spacemacs/toggle-truncate-lines-off)
  (add-hook 'cargo-process-mode-hook 'spacemacs/toggle-truncate-lines-off)
  (spacemacs/toggle-highlight-long-lines-globally-on)

  ;; electric-operator
  (dolist (hook '(c-mode-common-hook org-mode-hook python-mode-hook inferior-python-mode-hook LaTeX-mode-hook js2-mode-hook css-mode-hook rust-mode-hook))
    (add-hook hook #'electric-operator-mode))
  (with-eval-after-load "electric-operator"
    (electric-operator-add-rules-for-mode
     'c++-mode
     (cons "<>" "<> ")
     (cons "<" " < ")
     (cons ">" " > ")
     (cons ";" "; ")
     (cons "::" "::")
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
     'rust-mode
     ;; (cons "< " " < ")
     ;; (cons "> " " > ")
     ;; (cons "<" "<>")
     (cons "?" "?")
     (cons "..=" "..=")
     (cons "||" "||")
     )
    (electric-operator-add-rules-for-mode
     'org-mode
     (cons "," ", ")
     (cons "?" "? ")
     (cons ";" "; ")
     (cons ":" ": ")
     (cons "::" "::")
     (cons "." ". ")
     )
    (electric-operator-add-rules-for-mode
     'js2-mode
     (cons "=" " = ")
     (cons "==" ",== ")
     (cons "," ", ")
     (cons ":" ": ")
     (cons "+" " + ")
     )
    (electric-operator-add-rules-for-mode
     'inferior-python-mode
     (cons "=" " = ")
     (cons "==" ",== ")
     (cons "," ", ")
     )
    )

  (defun query-replace-region-or-from-top ()
    "If marked, query-replace for the region, else for the whole buffer (start from the top)"
    (interactive)
    (progn
      (let ((orig-point (point)))
        (if (use-region-p)
            (call-interactively 'query-replace)
          (save-excursion
            (goto-char (point-min))
            (call-interactively 'query-replace)))
        (message "Back to old point.")
        (goto-char orig-point))))

  ;; flush blank lines
  (defun flush-blank-lines (start end)
    "Mark a block and delete all blank/empty lines inside it."
    (interactive "r")
    (flush-lines "^\\s-*$" start end nil))

  (defun keep-beginning-of-code-or-line ()
    "Based on mwim, goto the beginning of code, then beginning of line, then the previous line."
    (interactive)
    (when (bolp) (forward-line -1))
    (mwim-beginning-of-code-or-line))
  ;; eolp in emacs is not like $ in vim, $=eolp-1, use the following to make them the same
  ;; or keep-end-of-code-or-line doesn't keep
  (setq evil-move-beyond-eol t)
  (defun keep-end-of-code-or-line ()
    "Based on mwim, goto the end of code, then end of line, then the next line."
    (interactive)
    (when (eolp) (forward-line 1))
    (if (inside-comment-p) (end-of-line)
      (mwim-end-of-code-or-line)))

  (add-to-list 'auto-mode-alist '(".spacevim\\'" . vimrc-mode))

  (defun xah-toggle-letter-case ()
    "Toggle the letter case of current word or text selection.
Always cycle in this order: Init Caps, ALL CAPS, all lower.

URL `http://ergoemacs.org/emacs/modernization_upcase-word.html'
Version 2020-06-26"
    (interactive)
    (let (
          (deactivate-mark nil)
          $p1 $p2)
      (if (use-region-p)
          (setq $p1 (region-beginning)
                $p2 (region-end))
        (save-excursion
          (skip-chars-backward "[:alpha:]")
          (setq $p1 (point))
          (skip-chars-forward "[:alpha:]")
          (setq $p2 (point))))
      (when (not (eq last-command this-command))
        (put this-command 'state 0))
      (cond
       ((equal 0 (get this-command 'state))
        (upcase-initials-region $p1 $p2)
        (put this-command 'state 1))
       ((equal 1 (get this-command 'state))
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
      (call-interactively 'capitalize-word)))
  (defun endless/downcase ()
    "Downcase region or word.
Also converts full stops to commas."
    (interactive)
    (endless/convert-punctuation "\\." ",")
    (if (use-region-p)
        (call-interactively 'downcase-region)
      (call-interactively 'downcase-word)))
  (defun endless/upcase ()
    "Upcase region or word."
    (interactive)
    (if (use-region-p)
        (call-interactively 'upcase-region)
      (call-interactively 'upcase-word)))
  (spacemacs|define-transient-state change-case
    :title "Change Case Transient State"
    :doc "
_x_: loop     _c_: capitalize     _d_: downcase
_u_: upcase   _z_: undo           _Z_: redo
_h_/_<left>_: left   _l_/_<right>_: right
_j_/_<down>_: down   _k_/_<up>_: up
"
    :bindings
    ("x" xah-toggle-letter-case)
    ("c" endless/capitalize)
    ("d" endless/downcase)
    ("u" endless/upcase)
    ("z" undo-tree-undo)
    ("Z" undo-tree-redo)
    ("h" evil-backward-char)
    ("<left>" evil-backward-char)
    ("l" evil-forward-char)
    ("<right>" evil-forward-char)
    ("j" evil-next-line)
    ("<down>" evil-next-line)
    ("k" evil-previous-line)
    ("<up>" evil-previous-line)
    ("q" nil))

  (require 'cool-moves)
  ;; bind-key except for org-mode
  (bind-keys* :filter (not (derived-mode-p 'org-mode))
              ("M-<up>" . drag-stuff-up)
              ("M-<down>" . drag-stuff-down)
              ("M-<left>" . cool-moves/sexp-backward)
              ("M-<right>" . cool-moves/sexp-forward))
  (spacemacs|define-transient-state cool-moves
    :title "Cool Moves Transient State"
    :doc "
_<down>_/_l_: line ↓    _<up>_/_L_: line ↑
_<right>_/_x_: sexp →   _<left>_/_X_: sexp ←
_p_: par ↓              _P_: par ↑
_w_: word →             _W_: word ←
_c_: char →             _C_: char ←
_s_: sentence →         _S_: sentence ←
_z_: undo               _Z_: redo
"
    :bindings
    ("l" drag-stuff-down)
    ("<down>" drag-stuff-down)
    ("L" drag-stuff-up)
    ("<up>" drag-stuff-up)

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

  (spacemacs|define-transient-state rectangle
    :title "Rectangle"
    :on-enter (rectangle-mark-mode 1)
    :on-exit (deactivate-mark)
    :doc "
  ^_k_^       _w_ copy      _o_ open     _N_ number-lines
_h_   _l_     _y_ yank      _t_ type     _e_ exchange-point
  ^_j_^       _d_ kill      _c_ clear    _r_ reset-region-mark
   ^^^^       _z_ undo      _Z_ redo     _q_ quit
"
    :bindings
    ("k" rectangle-previous-line)
    ("<up>" rectangle-previous-line)
    ("j" rectangle-next-line)
    ("<down>" rectangle-next-line)
    ("h" rectangle-backward-char)
    ("<left>" rectangle-backward-char)
    ("l" rectangle-forward-char)
    ("<right>" rectangle-forward-char)
    ("d" kill-rectangle)                    ;; C-x r k
    ("y" yank-rectangle)                    ;; C-x r y
    ("w" copy-rectangle-as-kill)            ;; C-x r M-w
    ("o" open-rectangle)                    ;; C-x r o
    ("t" string-rectangle)                  ;; C-x r t
    ("c" clear-rectangle)                   ;; C-x r c
    ("e" rectangle-exchange-point-and-mark) ;; C-x C-x
    ("N" rectangle-number-lines)            ;; C-x r N
    ("r" (if (region-active-p)
             (deactivate-mark)
           (rectangle-mark-mode 1)))
    ("z" undo-tree-undo)
    ("Z" undo-tree-redo)
    ("q" nil))

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
            (progn                     ; hack. exit if there's no more next line
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
        ;; check if major-mode is one of ...
        (if (derived-mode-p 'eshell-mode) ; other modes append to eshell-mode
            (eshell-send-input)
          (progn
            (end-of-line)
            (newline-and-indent))))))
  (defun Meta-return ()
    (interactive)
    (if (equal major-mode 'org-mode)
        (org-meta-return)
      (if (equal major-mode 'eshell-mode)
          (eshell-queue-input)
        (progn
          ;; executing key in a function
          (call-interactively (key-binding (kbd "C-M-j")))
          (indent-according-to-mode)))))
  (defun Ctrl-return ()
    "Newline(split line) and indent, move the new spited line up, the opposite of Meta-return
1. move comment from the end of the line to the above line,
2. OR open a new line above the current and jump to it like O(evil mode)"
    (interactive)
    (Meta-return)
    (transpose-lines 1)
    (previous-line 2)
    (indent-according-to-mode))

  (add-hook 'smartparens-enabled-hook #'evil-smartparens-mode)
  (dolist (hook '(css-mode-hook toml-mode-hook))
    (add-hook hook #'smartparens-mode))

  (with-eval-after-load 'org
    (spacemacs/set-leader-keys-for-major-mode 'org-mode
      "TE" 'org-toggle-emphasis)
    ;; Resume clocking task when emacs is restarted
    (org-clock-persistence-insinuate)
    (setq org-list-allow-alphabetical t
          ;; removes clocked tasks with 0:00 duration
          org-clock-out-remove-zero-time-clocks t
          ;; Save the running clock and all clock history when exiting Emacs, load it on startup
          ;; org-clock-persist t
          ;; Do not prompt to resume an active clock
          org-clock-persist-query-resume nil
          ;; Include current clocking task in clock reports
          org-clock-report-include-clocking-task t
          ;; Overwrite the current window with the agenda
          org-agenda-window-setup 'current-window
          ;; indent the content with the header
          org-adapt-indentation t
          ;; search all items including archives
          org-agenda-text-search-extra-files '(agenda-archives)
          ;; mark all children DONE when mark parent DONE, FIXME: not working
          org-enforce-todo-dependencies t
          org-log-reschedule 'time
          org-agenda-span 15
          org-agenda-start-on-weekday nil
          org-agenda-start-day "-7d"
          ;; include all files in ~/Org as the source of org-agenda
          ;; (setq org-agenda-files '("~/org/"))
          org-agenda-files (list "~/org/todo.org"
                                 ;; "~/org/home.org"
                                 )
          org-columns-default-format "%50ITEM(Task) %TODO %3PRIORITY %TAGS %10CLOCKSUM %16TIMESTAMP_IA"
          org-log-into-drawer "LOGBOOK"
          org-log-done 'time
          org-tags-column 0
          ;; about the org-src block format
          ;; https://emacs.stackexchange.com/a/51690
          org-src-preserve-indentation nil
          org-edit-src-content-indentation 0
          ;;
          org-src-ask-before-returning-to-edit-buffer nil
          org-src-window-setup 'split-window-below
          ;; fix the issue of org-src buffer
          ;; spacemacs/issues/12967
          org-src-tab-acts-natively nil
          org-indent-indentation-per-level 3
          ;; Prevents accidentally editing hidden text when the point is inside a folded region.
          ;; use C-c C-r 'org-reveal to show where your point is
          org-catch-invisible-edits 'error
          ;; disable '_' to subscript or '^' to superscript export
          org-export-with-sub-superscripts nil
          ;; export org to html with checkbox like ☑ (ballot)
          org-html-checkbox-type 'unicode
          ;; remove the end part of the exported file such as `author, date, emacs and org-mode version`
          org-html-postamble nil
          ;; FIXME: meaning?
          ;; before the star at the beginning of headline for all speed commands
          org-use-speed-commands t
          ;;
          org-highlight-latex-and-related '(latex script entities)
          org-list-demote-modify-bullet
          '(("-" . "+") ("+" . "*") ("*" . "-") ("1." . "+") ("1)" . "+")
            ("a." . "-") ("a)" . "-") ("A." . "-") ("A)" . "-"))
          org-agenda-custom-commands
          '(("c" "Simple agenda view"
             ((tags "PRIORITY=\"A\""
                    ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                     (org-agenda-overriding-header "High-priority unfinished tasks:")))
              (alltodo "")
              (agenda ""))))
          org-capture-templates
          '(("s" "Scheduled TODO node" entry (file "~/Org/todo.org")
             "* TODO %?\nADDED: %U\nSCHEDULED: %t")
            ("S" "STARTED TODO node" entry (file "~/Org/todo.org")
             "* STARTED %?\nADDED: %U" :clock-in t :clock-keep t :clock-resume t)
            ("t" "TODO list" checkitem (file "~/Org/todo.org")
             "[ ] %?"))
          org-todo-keywords
          ;; !/@ meaning: https://orgmode.org/manual/Tracking-TODO-state-changes.html
          '((sequence "TODO(t!)" "STARTED(s!)" "NEXT(n!)" "WAITING(w!)" "|" "DONE(d!)" "CANCELED(c@)")
            ;; multiple sets for one file
            ;; (sequence "REPORT(r)" "BUG(b)" "KNOWNCAUSE(k)""|" "FIXED(f)")
            ;; (sequence "|" "CANCELED(c)")
            )
          ;; in org-mode buffer
          org-emphasis-alist
          '(
            ("*" (:foreground "cyan" :weight bold))
            ("/" (:foreground "green" :slant italic))
            ("_" (:foreground "orange" :underline t))
            ("=" (:foreground "MediumSpringGreen" :weight bold))
            ("~" (:foreground "white" :weight bold
                              :box (:line-width 3 :color "#545454" :style released-button)))
            ("+" (:foreground "DimGrey" :strike-through t)))
          ;; in exported html file
          org-html-text-markup-alist
          '((bold . "<b>%s</b>")
            (code . "<kbd>%s</kbd>")
            (italic . "<i>%s</i>")
            (strike-through . "<del>%s</del>")
            (underline . "<span class=\"underline\">%s</span>")
            (verbatim . "<code>%s</code>"))
          ;; If you never use "plain" footnotes like [1] or p[1], you can adjust two variables
          ;; to avoid org-mode wrongly interpreting square brackets as footnote
          ;; Use styles at http://orgmode.org/manual/Footnotes.html such as [fn:1]
          ;; C-c C-c to jump to/back definition/reference
          org-footnote-re
          (concat "\\[\\(?:"
                  ;; Match inline footnotes.
                  (org-re "fn:\\([-_[:word:]]+\\)?:\\|")
                  ;; Match other footnotes. "\\(?:\\([0-9]+\\)\\]\\)\\|"
                  (org-re "\\(fn:[-_[:word:]]+\\)")
                  "\\)")
          org-footnote-definition-re (org-re "^\\[\\(fn:[-_[:word:]]+\\)\\]")
          )
    (defun org-toggle-emphasis ()
      "Toggle hiding/showing of org emphasize markers."
      (interactive)
      (if org-hide-emphasis-markers
          (set-variable 'org-hide-emphasis-markers nil)
        (set-variable 'org-hide-emphasis-markers t))
      (org-mode-restart))
    ;; from https://github.com/svetlyak40wt/dot-emacs/blob/master/.emacs.d/lib/org-auto-clock.el
    (defun wicked/org-clock-in-if-starting ()
      "Clock in when the task is marked STARTED."
      (when (and (string= org-state "STARTED")
                 (not (string= org-last-state org-state)))
        (org-clock-in)))
    (add-hook 'org-after-todo-state-change-hook 'wicked/org-clock-in-if-starting)
    (defadvice org-clock-in (after wicked activate)
      "Set this task's status to 'STARTED' when clock-in."
      (org-todo "STARTED"))
    (defun wicked/org-clock-out-if-waiting ()
      "Clock out when the task is marked WAITING or CANCELED."
      (when (and (or (string= org-state "WAITING")
                     (string= org-state "CANCELED"))
                 (equal (marker-buffer org-clock-marker) (current-buffer))
                 (< (point) org-clock-marker)
                 (> (save-excursion (outline-next-heading) (point))
                    org-clock-marker)
                 (not (string= org-last-state org-state)))
        (org-clock-out)))
    (add-hook 'org-after-todo-state-change-hook 'wicked/org-clock-out-if-waiting)
    ;; this is similar to org-enforce-todo-dependencies
    (defun org-summary-todo (n-done n-not-done)
      "Switch entry to DONE when all subentries are done, to TODO otherwise."
      (let (org-log-done org-log-states)	; turn off logging
        (org-todo (if (= n-not-done 0) "DONE" "TODO"))))
    (add-hook 'org-after-todo-statistics-hook 'org-summary-todo)
    ;;
    (defun org-src-format ()
      "Replace
1. `C-c '` to call `org-edit-special`
2. `C-x h` to mark all the source code
3. `TAB` to format it
into one step."
      (interactive)
      (when (org-in-src-block-p)
        (org-edit-special)
        (indent-region (point-min) (point-max))
        (org-edit-src-exit)))
    (bind-keys :map org-mode-map
               ("C-c C-<tab>" . org-src-format)
               ;; C-tab(original 'org-force-cycle-archived) to show the element
               ;; in another window(simpler version of org-panes.el)
               ;; then M-PageUp/Down to scroll another window
               ("C-c <tab>" . org-tree-to-indirect-buffer)
               )
    ;;
    ;; org-export stylesheet
    (setq org-html-head-extra
          "<link rel=\"stylesheet\" href=\"/home/chz/.spacemacs.d/lisp/org.css\" type=\"text/css\" />")
    (defun my/org-inline-css-hook (exporter)
      "Insert custom inline css to automatically set the
background of code to whatever theme I'm using's background"
      (when (eq exporter 'html)
        (let* ((my-pre-bg (face-background 'default))
               (my-pre-fg (face-foreground 'default)))
          (setq
           org-html-head-extra
           (concat
            org-html-head-extra
            (format "<style type=\"text/css\">\n pre.src {background-color: %s; color: %s;}</style>\n"
                    my-pre-bg my-pre-fg))))))
    (add-hook 'org-export-before-processing-hook 'my/org-inline-css-hook)
    ;; org-sticky-header and org-table-sticky-header
    (add-hook 'org-mode-hook
              (lambda ()
                ;; FIXME: `org-sticky-header-mode' in org-mode-hook has a bug that
                ;; the last line of hint will not be displayed for defhydra
                ;; https://github.com/abo-abo/hydra/issues/331
                ;; but OK for spacemacs|define-transient-state, so avoid using defhydra
                ;; already in org lay variables part
                ;; (org-sticky-header-mode)
                ;; FIXME: not fond
                ;; (org-table-sticky-header-mode)
                (org-num-mode)))
    ;; put this after org-mode config part, or flyspell-mode won't be enabled, even with-eval-after-load won't work
    (add-hook 'org-mode-hook 'flyspell-mode)
    (spacemacs|add-company-backends :backends company-ispell :modes org-mode prog-mode)
    )

  (spacemacs|define-transient-state hl-todo
    :title "hl-todo Transient State"
    :bindings
    ("n" hl-todo-next "next")
    ("p" hl-todo-previous "prev")
    ("l" hl-todo-occur "list")
    ("a" hl-todo-insert "add")
    ("t" hl-todo-mode "toggle")
    ("q" nil)
    )
  ;; spell checking
  ;; rewrite the default spell-checking transient state
  (spacemacs|define-transient-state ispell
    :title "Spell Checking Transient State"
    :doc "
[_b_] check whole buffer  [_B_] add word to dict (buffer)   [_t_] toggle spell check
[_d_] change dictionary   [_G_] add word to dict (global)   [_q_] exit
[_n_] correct next        [_S_] add word to dict (session)  [_Q_] exit and disable spell check
[_p_] correct previous    [_s_] correct generic             [_N_] next spell error
[_c_] correct at point    [_._] correct wrapper             [_e_] endless ispell
"
    :on-enter (flyspell-mode)
    :bindings
    ("B" spacemacs/add-word-to-dict-buffer)
    ("b" flyspell-buffer)
    ("d" spell-checking/change-dictionary)
    ("G" spacemacs/add-word-to-dict-global)
    ("s" flyspell-correct-word-generic)
    ("c" flyspell-correct-at-point)
    ("." flyspell-correct-wrapper)
    ("n" flyspell-correct-next)
    ("p" flyspell-correct-previous)
    ("N" flyspell-goto-next-error)
    ("e" endless/ispell-word-then-abbrev)
    ("Q" flyspell-mode :exit t)
    ("q" nil)
    ("S" spacemacs/add-word-to-dict-session)
    ("t" spacemacs/toggle-spelling-checking))
  (add-hook 'ispell-initialize-spellchecker-hook
            (lambda ()
              (setq ispell-base-dicts-override-alist
                    '((nil ; default
                       "[A-Za-z]" "[^A-Za-z]" "[']" t
                       ("-d" "en_US" "-i" "utf-8") nil utf-8)
                      ("american" ; Yankee English
                       "[A-Za-z]" "[^A-Za-z]" "[']" t
                       ("-d" "en_US" "-i" "utf-8") nil utf-8)
                      ("british" ; British English
                       "[A-Za-z]" "[^A-Za-z]" "[']" t
                       ("-d" "en_GB" "-i" "utf-8") nil utf-8)))))
  ;; source: http://endlessparentheses.com/ispell-and-abbrev-the-perfect-auto-correct.html
  (defun endless/simple-get-word ()
    (car-safe (save-excursion (ispell-get-word nil))))
  (defun endless/ispell-word-then-abbrev (p)
    "Call `ispell-word', then create an abbrev for it.
With prefix P, create local abbrev. Otherwise it will
be global.
If there's nothing wrong with the word at point, keep
looking for a typo until the beginning of buffer. You can
skip typos you don't want to fix with `SPC', and you can
abort completely with `C-g'."
    (interactive "P")
    (let (bef aft)
      (save-excursion
        (while (if (setq bef (endless/simple-get-word))
                   ;; Word was corrected or used quit.
                   (if (ispell-word nil 'quiet)
                       nil ; End the loop.
                     ;; Also end if we reach `bob'.
                     (not (bobp)))
                 ;; If there's no word at point, keep looking
                 ;; until `bob'.
                 (not (bobp)))
          (backward-word)
          (backward-char))
        (setq aft (endless/simple-get-word)))
      (if (and aft bef (not (equal aft bef)))
          (let ((aft (downcase aft))
                (bef (downcase bef)))
            (define-abbrev
              (if p local-abbrev-table global-abbrev-table)
              bef aft)
            (message "\"%s\" now expands to \"%s\" %sally"
                     bef aft (if p "loc" "glob")))
        (user-error "No typo at or before point"))))
  (setq save-abbrevs 'silently)
  (setq-default abbrev-mode t)

  ;; align
  ;; align-regexp with space instead tab
  (defadvice align-regexp (around align-regexp-with-spaces activate)
    (let ((indent-tabs-mode nil))
      ad-do-it))
  (defalias 'ar #'align-regexp)
  (defadvice align (around align-with-spaces activate)
    (let ((indent-tabs-mode nil))
      ad-do-it))
  (defun align-c-comments (beginning end)
    "Align instances of // or /* */ within marked region."
    (interactive "*r")
    (let (indent-tabs-mode align-to-tab-stop)
      (align-regexp beginning end "\\(\\s-*\\)[//|/*]")))
  (defun align-c-macros (beginning end)
    "Align macros within marked region"
    (interactive "*r")
    (progn
      (align beginning end)
      (untabify beginning end)))

  ;; tabify only the leading whitespace, this will avoid the changes in c/macro and comments
  (setq tabify-regexp "^\t* [ \t]+")
  (defun tabify-or-untabify ()
    "tabify/untabify(according to the value of indent-tabs-mode) the region if marked a region,
 or else, tabify the whole buffer, then indent-buffer-safe"
    (interactive)
    (if (use-region-p)
        (setq $p1 (region-beginning)
              $p2 (region-end))
      (setq $p1 (point-min)
            $p2 (point-max)))
    (if indent-tabs-mode
        (tabify $p1 $p2)
      (untabify $p1 $p2))
    (indent-region $p1 $p2))

  ;; Use the following function to replace all the C-x n* functions
  (defun narrow-or-widen-dwim (p)
    " If the buffer is narrowed, it widens. Otherwise, it narrows intelligently.
Intelligently means: region, org-src-block, org-subtree, or defun, whichever applies first.
Narrowing to org-src-block actually calls `org-edit-src-code'.
With prefix P, don't widen, just narrow even if buffer is already narrowed. "
    (interactive "P")
    (declare (interactive-only))
    (cond ((and (buffer-narrowed-p) (not p))
           (widen))
          ((region-active-p)
           (narrow-to-region (region-beginning) (region-end)))
          ((and (boundp 'org-src-mode) org-src-mode (not p)) ; <-- Added
           (org-edit-src-exit))
          ((derived-mode-p 'org-mode)
           (cond ((org-in-src-block-p)
                  (org-edit-src-code))
                 ((org-at-block-p)
                  (org-narrow-to-block))
                 (t (org-narrow-to-subtree))))
          (t (narrow-to-defun))))

  (defun split-window-right-next-buffer ()
    "Split the current window right, and switch the new window and load the next buffer in it."
    (interactive)
    (split-window-horizontally)
    (other-window 1 nil)
    (switch-to-next-buffer)
    )
  (defun split-window-below-next-buffer ()
    "Split the current window below, and switch the new window and load the next buffer in it."
    (interactive)
    (split-window-vertically)
    (other-window 1 nil)
    (switch-to-next-buffer)
    )
  (defun split-window-smart ()
    "Smart split the current window horizontally if width >= height, otherwise vertically,
the 8/20 numbers just make it more equal visually than window-total-width/height"
    (interactive)
    (if (> (* 8 (window-total-width)) (* 20 (window-total-height)))
        (split-window-horizontally)
      (split-window-vertically))
    (other-window 1 nil)
    (switch-to-next-buffer))

  ;; functions for eshell
  (when (daemonp)
    (exec-path-from-shell-initialize))
  (defun eshell/x ()
    "x in eshell prompt to exit eshell and close the eshell window."
    (eshell/exit)
    (delete-window))

  ;; NOTE: fix the bug in layer/go
  ;; spacemacs/issues/12263#issuecomment-490131508
  (use-package lsp-mode
    :commands lsp
    :config
    (lsp-register-client
     (make-lsp-client :new-connection (lsp-stdio-connection "gopls")
                      :major-modes '(go-mode)
                      :server-id 'gopls)))

  (defun smart-compile-again (ARG)
    "Run the same compile as the last time.
With a prefix argument or no last time, this acts like M-x compile,
and you can reconfigure the compile args."
    (interactive "p")
    ;; the following two lines create bug: split a new window every time
    ;; (if (not (get-buffer-window "*compilation*"))
    ;;	  (split-window-vertically -10))
    (if (and (eq ARG 1) compilation-last-buffer)
        (recompile)
      (call-interactively 'smart-compile)))

  ;; fix the compatibility of smartparens and yasnippet
  ;; the configs in .emacs.d/layers/+completion/auto-completion/packages.el
  ;; are not reliable, it will disable smartparens-mode after a period
  (add-hook 'yas-before-expand-snippet-hook (lambda () (smartparens-mode -1)))
  (add-hook 'yas-after-exit-snippet-hook (lambda () (smartparens-mode 1)))

  ;; fix the issue: Warning (emacs): recentf mode: Non-character input-event
  ;; syl20bnr/spacemacs/issues/5554#issuecomment-369262669
  (defun ask-user-about-lock (file other-user)
    "A value of t says to grab the lock on the file."
    t)

  (defun hide-ctrl-M ()
    "Hides the disturbing '^M' showing up in files containing mixed UNIX and DOS line endings."
    (interactive)
    (setq buffer-display-table (make-display-table))
    (aset buffer-display-table ?\^M []))

  (defun swiper-whole-word ()
    "Search the whole word using swiper-isearch"
    (interactive)
    (let ((unread-command-events '(?\C-b ?\C-b ?\C-b)))
      (swiper-isearch "\\_<\\_>")))
  ;; This function is deleted in spacemacs repo, now put is here since it used
  (defun spacemacs//counsel-current-region-or-symbol ()
    "Return contents of the region or symbol at point.

If region is active, mark will be deactivated in order to prevent region
expansion when jumping around the buffer with counsel. See `deactivate-mark'."
    (if (region-active-p)
        (prog1
            (buffer-substring-no-properties (region-beginning) (region-end))
          (deactivate-mark))
      (thing-at-point 'symbol t)))
  (defun spacemacs/swiper-region-or-symbol-whole-word ()
    "Run `swiper-isearch' with the selected region or the symbol
around point as the initial input."
    (interactive)
    (let ((input (spacemacs//counsel-current-region-or-symbol))
          (unread-command-events '(?\C-b ?\C-b ?\C-b)))
      (swiper-isearch (concat "\\_<" input "\\_>"))))
  (defun inside-comment-p ()
    "Returns non-nil if inside comment, else nil.
Result depends on syntax table's comment character.
http://ergoemacs.org/emacs/elisp_determine_cursor_inside_string_or_comment.html"
    (interactive)
    (let ((result (nth 4 (syntax-ppss))))
      (message "%s" result)
      result))
  (defun inside-string-p ()
    "Returns non-nil if inside string, else nil.
Result depends on syntax table's string quote character.
http://ergoemacs.org/emacs/elisp_determine_cursor_inside_string_or_comment.html"
    (interactive)
    (let ((result (nth 3 (syntax-ppss))))
      (message "%s" result)
      result))

  (defun insert-indent-brace ()
    "Insert {}, add new line and indent.
  https://stackoverflow.com/a/22114743/1528712"
    (interactive)
    (if (not (or (inside-string-p) (inside-comment-p)))
        (progn
          (insert "{\n\n}")
          (indent-according-to-mode)
          (forward-line -1)
          (indent-according-to-mode))
      (progn
        (insert "{}")
        (forward-char -1))))
  ;; use } for insert-indent-brace in situation such as function/if/while
  ;; use { for normal {} in other normal situation
  (add-hook 'c-mode-common-hook
            (lambda () (define-key c-mode-base-map "}" 'insert-indent-brace)))
  (add-hook 'rust-mode-hook
            (lambda () (define-key rust-mode-map "}" 'insert-indent-brace)))

  ;; using sock5 proxy, useful for installing packages
  ;; (setq url-gateway-method 'socks)
  ;; (setq socks-server '("Default server" "127.0.0.1" 1080 5))


  (with-eval-after-load 'rust-mode
    (spacemacs/set-leader-keys-for-major-mode 'rust-mode
      "cw" 'cargo-process-watch)
    )

  (use-package dap-mode
    :defer
    :custom
    (dap-auto-configure-mode t                           "Automatically configure dap.")
    (dap-auto-configure-features
     '(sessions locals breakpoints expressions tooltip)  "Remove the button panel in the top.")
    :config
    ;; dap for c++
    (require 'dap-lldb)

    ;; set the debugger executable (c++)
    (setq dap-lldb-debug-program '("/usr/bin/lldb-vscode"))
    ;; FIXME: bug of dap-mode package, it will open all files with known breakpoints in
    ;; default ~/.emacs.d/.dap-breakpoints
    (setq dap-breakpoints-file "/tmp/dap-breakpoints")

    (setq dap-lldb-debugged-program-function
          (lambda ()
            (completing-read "Select file to debug: "
                             (directory-files-recursively
                              (lsp-workspace-root)
                              ".*" nil #'f-executable?))))

    ;; default debug template for (c++)
    ;; (dap-register-debug-template
    ;;  "LLDB dap debugger for C/C++/Rust"
    ;;  (list :type "lldb-vscode"
    ;;        ;; :cwd: "${workspaceFolder}"
    ;;        :cwd nil
    ;;        ;; :args ["abc", "def"]
    ;;        :args nil
    ;;        ;; :program "${workspaceFolder}/build/${fileBasenameNoExtension}",
    ;;        :program nil
    ;;        :request "launch"))

    ;; FIXME: don't know how to combine these two into one
    ;; NOTE: 10 makes sure dap-ui--show-many-windows run before dap-hydra
    ;; or dap-ui--show-many-windows will not be displayed
    (add-hook 'dap-stopped-hook
              (lambda (arg) (call-interactively #'dap-hydra)) 10)
    ;; (add-hook 'dap-session-created-hook
    ;;           'dap-ui--show-many-windows)

    (add-hook 'dap-terminated-hook
              (lambda (arg)
                ;; quit dap-hydra once Q to disconnect dap session
                (call-interactively #'dap-hydra/nil)
                ) 10)
    (defun dap-clean-buffers ()
      (interactive)
      (let ((buffers (list "\*dap-ui-*" "\*LLDB::Run *" "\*GDB::Run *")))
        (mapc (lambda (buffer-name) (kill-matching-buffers buffer-name nil t)) buffers))
      )
    ;; FIXME: *dap-ui-expressions* and *dap-ui-locals* buffers won't be killed automatically
    ;; manually executing dap-clean-buffers will
    (add-hook 'dap-terminated-hook (lambda (arg) (dap-clean-buffers) 9))

    ;; TODO: unable to change the height in the left/right
    ;; unable to change the position of debug output window
    (setq dap-ui-buffer-configurations
          `((,dap-ui--breakpoints-buffer  . ((side . left)  (slot . 1) (window-width . ,treemacs-width)))
            (,dap-ui--expressions-buffer  . ((side . left)  (slot . 2) (window-width . 0.20)))
            (,dap-ui--sessions-buffer     . ((side . left)  (slot . 3) (window-width . 0.20)))
            ;; TODO: what is repl-buffer(:python like)
            (,dap-ui--repl-buffer         . ((side . left)  (slot . 4) (window-width . 0.20)))
            (,dap-ui--locals-buffer       . ((side . right) (slot . 1) (window-width . 0.20)))
            ;; TODO: what is debug-window-buffer
            (,dap-ui--debug-window-buffer . ((side . right) (slot . 2) (window-width . 0.20)))
            )))
  (defun evil-goto-definition-other-window ()
    "Jump to definition around point in other window.
Rewrite `spacemacs/jump-to-definition' to use `evil-goto-definition' instead since after jumping using `spacemacs/jump-to-definition', point can get stuck."
    (interactive)
    (let ((pos (point)))
      ;; since `spacemacs/jump-to-definition' can be asynchronous we cannot use
      ;; `save-excursion' here, so we have to bear with the jumpy behavior.
      (switch-to-buffer-other-window (current-buffer))
      (goto-char pos)
      (evil-goto-definition)))
  )

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
