{ config, lib, pkgs, ... }:

{
  home.stateVersion = "22.05";

  imports =
    [ ./git.nix ./gpg.nix ./kitty.nix ./neovim.nix ./zsh.nix ];

  home.packages = with pkgs; [
    amazon-ecr-credential-helper
    colima
    awscli2
    docker-client
    docker-compose
    docker-credential-helpers
    nodePackages.mermaid-cli
    yt-dlp
    libyaml
  ];

  programs.mise.enable = true;
}
