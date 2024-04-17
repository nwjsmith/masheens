{ config, lib, pkgs, ... }:

{
  programs.home-manager.enable = true;

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
    go
    gopls
    jq
    lazygit
    nodejs
    (ripgrep.override { withPCRE2 = true; })
    scc
    shellcheck
    sqlite
    tmux
    (tree-sitter.withPlugins (_: tree-sitter.allGrammars))
  ];

  programs.emacs = {
    enable = true;
    extraPackages = (epkgs: [ epkgs.vterm ]);
  };

  home.activation = {
    installDoom = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      DOOM="${config.xdg.configHome}/emacs"
      [ ! -d $DOOM ] && \
        $DRY_RUN_CMD ${pkgs.git}/bin/git clone --depth 1 https://github.com/doomemacs/doomemacs.git $DOOM
    '';
  };
  home.sessionPath = [ "${config.xdg.configHome}/emacs/bin" ];

  home.file.".doom.d/init.el".source = ./doom.d/init.el;
  home.file.".doom.d/packages.el".source = ./doom.d/packages.el;
  home.file.".doom.d/config.el".source = ./doom.d/config.el;
  home.file.".doom.d/w.svg".source = ./doom.d/w.svg;

  xdg.configFile."shellcheckrc".source = ./shellcheckrc;
}
