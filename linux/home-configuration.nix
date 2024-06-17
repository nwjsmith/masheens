{
  pkgs,
  ...
}:

{
  home.username = "nwjsmith";

  home.homeDirectory = "/home/nwjsmith";

  home.packages = with pkgs; [
    _1password-gui
    ibm-plex
    inter
    jetbrains.idea-community-bin
    (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
    obsidian
    racket
    tlaplusToolbox
    tuba
    ulauncher
    vlc
  ];

  programs.firefox = {
    enable = true;
    package = pkgs.firefox-wayland;
  };

  programs.ghostty = {
    package = pkgs.ghostty;
    settings.font-size = 11;
  };

  fonts.fontconfig.enable = true;

  programs.emacs.package = pkgs.emacs29-pgtk;

  home.stateVersion = "23.05";
}
