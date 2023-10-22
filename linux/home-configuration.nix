{ config, lib, pkgs, ... }:

{
  home.username = "nwjsmith";

  home.homeDirectory = "/home/nwjsmith";

  home.packages = with pkgs; [
    _1password-gui
    ibm-plex
    inter
    (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
    obsidian
    racket
    tlaplusToolbox
    tofi
  ];

  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures = {
      base = true;
      gtk = true;
    };
    config = {
      modifier = "Mod4";
      menu = "${pkgs.tofi}/bin/tofi-drun --drun-launch=true";
      terminal = "${pkgs.alacritty}/bin/alacritty";
      output."LG Electronics LG HDR 4K 0x00005F34".scale = "2";
    };
  };

  programs.waybar = {
    enable = true;
    systemd.enable = true;
  };

  programs.alacritty = {
    enable = true;
    settings = {
      dynamic_padding = true;
      padding = {
        x = 5;
        y = 5;
      };
      font = {
        size = 12.0;
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

  programs.emacs.package = pkgs.emacs29-pgtk;

  programs.fzf = {
    enable = true;
    defaultCommand = "${pkgs.fd}/bin/fd --type f";
    changeDirWidgetCommand = "${pkgs.fd}/bin/fd --type d";
    fileWidgetCommand = "${pkgs.fd}/bin/fd --type f";
    defaultOptions = [
      "--color=fg:#000000,bg:#ffffff,hl:#0031a9"
      "--color=fg+:#595959,bg+:#ffffff,hl+:#2544bb"
      "--color=info:#005e00,prompt:#a60000,pointer:#5317ac"
      "--color=marker:#315b00,spinner:#721045,header:#00538b"
    ];
  };

  programs.starship = {
    enable = true;
    settings = {
      format = lib.concatStrings [
        "$directory"
        "$cmd_duration"
        "$line_break"
        "$character"
      ];
    };
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
