{ config, lib, pkgs, ... }:

{
  home.stateVersion = "22.05";

  imports =
    [ ./git.nix ./gpg.nix ./kitty.nix ./neovim.nix ./zsh.nix ];

  home.packages = with pkgs; [
    amazon-ecr-credential-helper
    colima
    awscli2
    d2
    docker-client
    docker-compose
    docker-credential-helpers
    nodePackages.mermaid-cli
    yt-dlp
  ];

  programs.emacs.package = pkgs.emacs29-macport;

  home.activation = {
    installDoom = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      DOOM="${config.home.homeDirectory}/.emacs.d"
      [ ! -d $DOOM ] && \
        $DRY_RUN_CMD ${pkgs.git}/bin/git clone --depth 1 https://github.com/doomemacs/doomemacs.git $DOOM
    '';
  };

  home.file.".doom.d/init.el".source = ./doom.d/init.el;
  home.file.".doom.d/packages.el".source = ./doom.d/packages.el;
  home.file.".doom.d/config.el".source = ./doom.d/config.el;
  home.file.".doom.d/w.svg".source = ./doom.d/w.svg;
  home.file.".emacs.d/profiles.el".source = ./emacs.d/profiles.el;

  xdg.configFile."karabiner/assets/complex_modifications/escape.json".source =
    ./config/karabiner/assets/complex_modifications/escape.json;
}
