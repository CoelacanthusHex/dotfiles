
;; Disable startup buffer.
(setq inhibit-startup-message t)

;; Contrary to what many Emacs users have in their configs, you only need this
;; to make UTF-8 the default coding system.
(set-language-environment "UTF-8")
;; `set-language-enviornment` sets `default-input-method`, which is unwanted.
(setq default-input-method nil)

;; Use y or n instead yes or no.
(fset 'yes-or-no-p 'y-or-n-p)

;; Don't clean font-caches during GC.
(setq inhibit-compacting-font-caches t)

;; Packages.

;; Before we can require packages, there are two things to do, first is loading
;; packages and second is activating packages, `package-initialize` does both,
;; but you can pass a `no-activate` argument to let it only load packages and,
;; then call `package-activate-all` manually.
(require 'package)
;; Use TUNA mirrors for faster downloading.
(setq package-archives
      '(("gnu" . "https://mirrors.bfsu.edu.cn/elpa/gnu/")
        ("nongnu" . "https://mirrors.bfsu.edu.cn/elpa/nongnu/")
        ("melpa" . "https://mirrors.bfsu.edu.cn/elpa/melpa/")))

(make-directory (locate-user-emacs-file ".local/") t)
(make-directory (locate-user-emacs-file ".cache/") t)

;; Enable `package-quickstart`, it will cache autoload files of all packages
;; into a single file cache to speed up loading. This reduces only 0.1s for me,
;; but maybe very helpful for HDD users.
;; See <https://git.savannah.gnu.org/cgit/emacs.git/commit/?id=6dfdf0c9e8e4aca77b148db8d009c862389c64d3>.
(setq package-quickstart t)
;; Put quick start cache into cache dir.
(setq package-quickstart-file
      (locate-user-emacs-file ".cache/package-quickstart.el"))
;; Cache will not enable until we call `package-quickstart-refresh` manually.
(unless (file-exists-p package-quickstart-file)
  (package-quickstart-refresh))
;; Make sure quick start cache is refreshed after operations in package menu,
;; for example upgrading packages.
;; See <https://www.manueluberti.eu/emacs/2021/03/08/package/>.
(advice-add 'package-menu-execute :after-while #'package-quickstart-refresh)
;; It should be enough to run `package-activate-all` only if we enable quick
;; start, because we won't load packages with `package-initialize` and only load
;; quick start cache.
(package-activate-all)

;; Load `use-package`.
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

;; My favorite theme.
;; Don't defer this, I need it all time.
(use-package atom-one-dark-theme
             :ensure t
             :config
             (load-theme 'atom-one-dark t))

(use-package lsp-mode
             :ensure t
             :commands lsp
             :hook ((c-mode . lsp-deferred)
                    (c++-mode . lsp-deferred)
                    (c-or-c++-mode . lsp-deferred)
                    (css-mode . lsp-deferred)
                    (cuda-mode . lsp-deferred)
                    (objc-mode . lsp-deferred)
                    (html-mode . lsp-deferred)
                    (java-mode . lsp-deferred)
                    (js-mode . lsp-deferred)
                    (js2-mode . lsp-deferred)
                    (python-mode . lsp-deferred)
                    ;; Don't enable lsp for `web-mode`, lsp cannot understand nunjucks.
                    ;; (web-mode . lsp-deferred)
                    (lsp-mode . lsp-enable-which-key-integration))
             :bind (:map lsp-mode-map
                         ("M-." . lsp-find-definition)
                         ("M-," . lsp-find-references))
             ;; Move lsp files into local dir.
             :custom
             (lsp-server-install-dir (locate-user-emacs-file ".local/lsp/"))
             (lsp-session-file (locate-user-emacs-file ".local/lsp-session"))
             (lsp-keymap-prefix "C-c l")
             ;; Only enable log for debug.
             ;; (lsp-log-io nil)
             ;; For better performance
             (lsp-enable-symbol-highlighting nil)
             (lsp-enable-on-type-formatting nil)
             (lsp-lens-enable nil)
             (lsp-signature-auto-activate nil)
             (lsp-signature-render-documentation nil)
             (lsp-semantic-tokens-enable nil)
             (lsp-enable-folding nil)
             (lsp-enable-imenu nil)
             (lsp-enable-snippet nil)
             (lsp-enable-file-watchers nil)
             ;; JavaScript (ts-ls) settings.
             ;; Uncomment those lines if you want get `ts-ls` logs.
             ;; (lsp-clients-typescript-server-args '("--stdio" "--tsserver-log-file" "/tmp/tsserver-log.txt"))
             ;; (lsp-clients-typescript-log-verbosity "verbose")
             (lsp-javascript-format-insert-space-after-opening-and-before-closing-nonempty-braces nil))

;; High CPU usage on scrolling.
(use-package tree-sitter
             :ensure t
             ;; :disabled
             :defer 1
             :config
             ;; Enable `tree-sitter` for all supported major modes.
             (global-tree-sitter-mode 1)
             ;; Use `tree-sitter` for highlight on supported major modes.
             ;; `tree-sitter` currently does not support multi-language files,
             ;; for example JSDoc comments and HTML with CSS and JS.
             ;; I use `web-mode` for HTML, which is not supported by `tree-sitter`,
             ;; but I am not sure how to disable it for `js2-mode`. Anyway, no highlight in
             ;; comments is fine.
             :hook ((tree-sitter-after-on . tree-sitter-hl-mode)))

(use-package tree-sitter-langs
             :ensure t
             ;; :disabled
             :defer 1)

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
  '(package-selected-packages
     '(tree-sitter-langs tree-sitter lsp-mode atom-one-dark-theme use-package)))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
  )

;; kate: space-indent on; indent-width 4; syntax lisp;
