(setq auth-sources '("~/.authinfo.gpg")
      display-line-numbers-type nil
      doom-font (font-spec :family "Berkeley Mono" :size 16.0)
      doom-variable-pitch-font (font-spec :family "Berkeley Mono Variable"))

(after! cider
  (setq cider-clojure-cli-aliases "dev"
        cider-save-file-on-load nil
        cider-repl-pop-to-buffer-on-connect nil))

(after! clj-refactor
  (setq cljr-warn-on-eval nil
        cljr-add-ns-to-blank-clj-files nil
        cljr-eagerly-build-asts-on-startup nil))

(after! clojure-mode
  (setq clojure-thread-all-but-last t))

(after! magit
  (setq magit-section-visibility-indicator '("..." . t)))

(after! nix
  (map! :localleader :map nix-mode-map "F" #'nix-flake))

(use-package! evil-cleverparens
  :init (setq evil-cleverparens-use-s-and-S nil)
  :hook ((lisp-mode . evil-cleverparens-mode)
         (emacs-lisp-mode . evil-cleverparens-mode)
         (ielm-mode . evil-cleverparens-mode)
         (scheme-mode . evil-cleverparens-mode)
         (racket-mode . evil-cleverparens-mode)
         (clojure-mode . evil-cleverparens-mode)
         (fennel-mode . evil-cleverparens-mode)))

(use-package! copilot
  :hook (prog-mode . copilot-mode)
  :bind (:map copilot-completion-map
              ("<tab>" . 'copilot-accept-completion)
              ("TAB" . 'copilot-accept-completion)
              ("C-TAB" . 'copilot-accept-completion-by-word)
              ("C-<tab>" . 'copilot-accept-completion-by-word))
  :config
  (setq copilot-indent-offset-warning-disable t))

(use-package! modus-themes :config (load-theme 'modus-operandi :no-confirm))

(after! typescript-mode
  (setq typescript-indent-level 2)
  (setq-hook! '(typescript-mode-hook typescript-tsx-mode-hook)
    +format-with-lsp nil))

(after! projectile
  (setq projectile-project-search-path '(("~/Code" . 2))))

(use-package! jest-test-mode
  :hook (typescript-mode js-mode typescript-tsx-mode)
  :config
  (setq jest-test-command-string "yarn %s jest %s %s")
  (set-popup-rule! "^\\*\\(rspec-\\)?compilation" :size 0.3 :ttl nil :select t)
  (map! (:localleader
         (:map (typescript-mode-map js-mode-map typescript-tsx-mode-map)
               (:prefix ("t" . "jest")
                        "a" #'jest-test-run-all-tests
                        "t" #'jest-test-run-at-point
                        "f" #'jest-test-run
                        "r" #'jest-test-rerun-test)))))
