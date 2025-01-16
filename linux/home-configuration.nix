{pkgs, ...}: {
  home.username = "nwjsmith";

  home.homeDirectory = "/home/nwjsmith";

  home.packages = with pkgs; [
    _1password-gui
    google-chrome
    inter
    jetbrains.idea-community-bin
    keymapp
    nerd-fonts.symbols-only
    obsidian
    racket
    spotify
    tlaplusToolbox
    ulauncher
    vlc
  ];

  programs.firefox = {
    enable = true;
    package = pkgs.firefox-wayland;
  };

  programs.ghostty.settings.font-size = 11;

  fonts.fontconfig.enable = true;

  services.espanso = {
    enable = true;
    matches.default.matches = [
      {
        trigger = ";em";
        replace = "nate@theinternate.com";
      }
      {
        trigger = ";wem";
        replace = "nsmith@wealthsimple.com";
      }
      {
        trigger = ";gem";
        replace = "nwjsmith@gmail.com";
      }
      {
        trigger = ";date";
        replace = "{{currentdate}}";
        vars = [
          {
            name = "currentdate";
            type = "date";
            params.format = "%Y-%m-%d";
          }
        ];
      }
    ];
  };

  services.gpg-agent.pinentryPackage = pkgs.pinentry-gnome3;

  programs.emacs.package = pkgs.emacs29-pgtk;
}
