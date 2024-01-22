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

  home.file.".doom.d/init.el".source = ./doom.d/init.el;
  home.file.".doom.d/packages.el".source = ./doom.d/packages.el;
  home.file.".doom.d/config.el".source = ./doom.d/config.el;
  home.file.".doom.d/w.svg".source = ./doom.d/w.svg;

  xdg.configFile."karabiner/assets/complex_modifications/escape.json".source =
    ./config/karabiner/assets/complex_modifications/escape.json;
}
