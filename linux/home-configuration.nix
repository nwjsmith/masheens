{ pkgs, ... }:

{
  home.username = "nwjsmith";

  home.homeDirectory = "/home/nwjsmith";

  home.packages = with pkgs; [
    _1password-gui
    ibm-plex
    inter
    jetbrains.idea-community-bin
    keymapp
    localsend
    (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
    obsidian
    racket
    spotify
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

  systemd.user.services.ulauncher = {
    Unit = {
      Description = "Linux Application Launcher";
      Documentation = [ "https://ulauncher.io/" ];
    };

    Service = {
      Type = "Simple";
      Restart = "Always";
      RestartSec = 1;
      ExecStart = pkgs.writeShellScript "ulauncher-env-wrapper.sh" ''
        export PATH="''${XDG_BIN_HOME}:$HOME/.nix-profile/bin:/etc/profiles/per-user/$USER/bin:/nix/var/nix/profiles/default/bin:/run/current-system/sw/bin"
        export GDK_BACKEND=x11
        exec ${pkgs.ulauncher}/bin/ulauncher --hide-window
      '';
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };

  programs.emacs.package = pkgs.emacs29-pgtk;

  home.stateVersion = "23.05";
}
