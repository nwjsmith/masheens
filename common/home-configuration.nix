{ config, lib, pkgs, ... }:

{
  imports = [
    ./clojure.nix
  ];

  home.packages = with pkgs; [
    asciinema
    coreutils
    curl
    fd
    ffmpeg
    gh
    jq
    niv
    nodejs
    (ripgrep.override { withPCRE2 = true; })
    scc
    shellcheck
    sqlite
    sshuttle
    tmux
    (tree-sitter.withPlugins (_: tree-sitter.allGrammars))
  ];

  programs.emacs = {
    enable = true;
    extraPackages = (epkgs: [ epkgs.vterm ]);
  };

  programs.home-manager.enable = true;

  xdg.configFile."shellcheckrc".source = ./shellcheckrc;
}
