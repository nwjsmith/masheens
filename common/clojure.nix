{...}: {
  home.file = {
    ".clojure/deps.edn".source = ./clojure/deps.edn;
    ".clj-kondo/config.edn".source = ./clj-kondo/config.edn;
    ".clj-kondo/hooks/checking.clj".source = ./clj-kondo/hooks/checking.clj;
  };
}
