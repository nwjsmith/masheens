{ config, lib, pkgs, ... }:

{
  imports = [
    ./clojure.nix
  ];

  home.packages = with pkgs; [
    asciinema
    coreutils
    curl
    # discount
    editorconfig-core-c
    fd
    ffmpeg
    gh
    # ghostty
    jq
    niv
    nodejs
    pandoc
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

  home.sessionPath = [ "${config.home.homeDirectory}/.emacs.d/bin" ];

  xdg.configFile."shellcheckrc".source = ./shellcheckrc;
}
