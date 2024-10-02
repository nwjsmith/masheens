{ pkgs, ... }:

{
  imports = [
    ./gpg.nix
  ];

  programs.emacs.package = pkgs.emacs-macport;

  programs.ghostty.settings = {
    font-size = 16;
    macos-non-native-fullscreen = true;
    macos-titlebar-style = "tabs";
    window-save-state = "never";
  };
}
