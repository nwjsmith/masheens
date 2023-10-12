{ config, lib, pkgs, ... }:

{
  imports =
    [ ./clojure.nix ./git.nix ./gpg.nix ./kitty.nix ./neovim.nix ./zsh.nix ];

  home.packages = with pkgs; [
    asciinema
    awscli2
    curl
    d2
    docker-client
    docker-compose
    docker-credential-helpers
    fd
    ffmpeg
    gh
    jq
    nodePackages.mermaid-cli
    niv
    nodejs
    (ripgrep.override { withPCRE2 = true; })
    scc
    sqlite
    tmux
    yt-dlp

    # Doom Emacs stuff
    coreutils
    discount
    editorconfig-core-c
    fontconfig
    gnuplot
    pandoc
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
