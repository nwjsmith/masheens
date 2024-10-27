{ pkgs, ... }:

{
  home.username = "nwjsmith";

  home.homeDirectory = "/home/nwjsmith";

  home.packages = with pkgs; [
    _1password-gui
    google-chrome
    inter
    jetbrains.idea-community-bin
    keymapp
    (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
    obsidian
    racket
    spotify
    todoist-electron
    tlaplusToolbox
    ulauncher
    vlc
  ];

  programs.zed-editor = {
    enable = true;
    extensions = [
      "clojure"
      "deno"
      "docker-compose"
      "dockerfile"
      "elisp"
      "env"
      "git-firefly"
      "graphql"
      "helm"
      "html"
      "just"
      "kotlin"
      "lua"
      "make"
      "mermaid"
      "nix"
      "ruby"
      "sql"
      "terraform"
      "toml"
      "xml"
      "zig"
    ];
    userSettings = {
      assistant = {
        default_model = {
          provider = "zed.dev";
          model = "claude-3-5-sonnet-latest";
        };
        version = "2";
      };
      buffer_font = "JetBrains Mono";
      buffer_font_fallbacks = ["Symbols Nerd Font Mono"];
      buffer_font_features.calt = false;
      buffer_font_size = 16;
      file_scan_exclusions = [
        "**/.DS_Store"
        "**/.classpath"
        "**/.direnv"
        "**/.git"
        "**/.hg"
        "**/.settings"
        "**/.svn"
        "**/CVS"
        "**/Thumbs.db"
      ];
      git.git_gutter = "hide";
      languages = {
        "Nix".tab_size = 2;
      };
      load_direnv = "shell_hook";
      project_panel.git_status = false;
      scrollbar.git_diff = false;
      terminal.font_features.calt = false;
      theme = {
          mode = "system";
          light = "One Light";
          dark = "One Dark";
      };
      ui_font_size = 16;
      vim_mode = true;
    };
  };

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
