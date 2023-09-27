{ config, pkgs, ... }:

{
  home.username = "nwjsmith";
  home.homeDirectory = "/home/nwjsmith";

  home.packages = with pkgs; [
    _1password-gui
    fd
    ibm-plex
    inter
    (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
    nodejs-slim
    pandoc
    racket
    ripgrep
    shellcheck
    sqlite
  ];

  wayland.windowManager.sway = {
    enable = true;

    config = {
      modifier = "Mod4";
      output = {
        Virtual-1 = {
          mode = "3840x2160";
          scale = "2";
        };
      };
    };
  };

  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        size = 16.0;
        normal.family = "IBM Plex Mono";
      };
      colors = {
        primary = {
          background = "#ffffff";
          foreground = "#000000";
          dim_foreground = "#595959";
          bright_foreground = "#ffffff";
        };

        normal = {
          black = "#000000";
          red = "#a60000";
          green = "#006800";
          yellow = "#6f5500";
          blue = "#0031a9";
          magenta = "#721045";
          cyan = "#00538b";
          white = "#e1e1e1";
        };

        bright = {
          black = "#585858";
          red = "#972500";
          green = "#316500";
          yellow = "#884900";
          blue = "#354fcf";
          magenta = "#531ab6";
          cyan = "#00538b";
          white = "#ffffff";
        };

        dim = {
          black = "#f0f0f0";
          red = "#7f0000";
          green = "#2a5045";
          yellow = "#624416";
          blue = "#003497";
          magenta = "#7c318f";
          cyan = "#005077";
          white = "#595959";
        };
      };
    };
  };

  programs.direnv.enable = true;

  programs.firefox = {
    enable = true;
    package = pkgs.firefox-wayland;
  };

  programs.git = {
    enable = true;
    userEmail = "nate@theinternate.com";
    userName = "Nate Smith";

    aliases = {
      co = "checkout";
      dc = "diff --cached";
      di = "diff";
      st = "status";
      unstage = "reset --";
      yolo = "push --force-with-lease";
    };

    extraConfig = {
      github.user = "nwjsmith";
      fetch.prune = true;
      init.defaultBranch = "main";
      push.default = "current";
      pull.rebase = true;
      rebase = {
        autoSquash = true;
        autoStash = true;
      };
      merge.conflictStyle = "diff3";
    };

    ignores = [
      ".#*"
      ".dir-locals.el"
      ".direnv/"
      ".idea/"
      ".vscode/"
      ".clj-kondo/"
      ".lsp/"
      "*.iml"
    ];
  };

  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;
  };

  fonts.fontconfig.enable = true;

  programs.emacs = {
    enable = true;
    package = pkgs.emacs29-pgtk;
    extraPackages = (epkgs: with epkgs; [ vterm ]);
  };

  programs.zoxide.enable = true;
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableVteIntegration = true;
    syntaxHighlighting.enable = true;
  };

  programs.home-manager.enable = true;

  home.stateVersion = "23.05";
}
