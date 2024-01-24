;; Garbage collection is a large contributor to startup times. Reset
;; later by `gcmh-mode`.
(setq gc-cons-threshold most-positive-fixnum)

;; Disable package.el, we're using elpaca instead.
(setq package-enable-at-startup nil)
