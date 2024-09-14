{ pkgs, ... }:

{
  imports = [
    ./gpg.nix
  ];

  programs.emacs.package = pkgs.emacs-macport;

  programs.ghostty.settings.font-size = 16;
}
