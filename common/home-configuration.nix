{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.home-manager.enable = true;

  home.sessionPath = [ "${config.home.homeDirectory}/.local/bin" ];
  home.file.".local/bin/jj-colocate" = {
    source = ./local/bin/jj-colocate;
    executable = true;
  };
  home.file.".local/bin/jj-pr" = {
    source = ./local/bin/jj-pr;
    executable = true;
  };
  home.file.".local/bin/jj-merge" = {
    source = ./local/bin/jj-merge;
    executable = true;
  };

  programs.fish = let
    modusTheme = builtins.fetchurl {
      url = "https://raw.githubusercontent.com/miikanissi/modus-themes.nvim/35980f19daef4745c96f1cb292d484fb1f33f822/extras/fish/modus_operandi.fish";
      sha256 = "sha256:0l3k2jkv2gd4mwbnpq2mq13hrb67wdk7mkq37z58lxl861zpmabq";
    };
  in {
    enable = true;
    interactiveShellInit = ''
      fish_vi_key_bindings
      source ${modusTheme}
    '';
    functions = {
      fish_greeting = "";
      fish_mode_prompt = "";
      fish_prompt = ''
        if test "$status" -ne 0
            set -f prompt_colour red
        else
            set -f prompt_colour green
        end
        if test "$CMD_DURATION" -gt 1000
            set -f duration " took " (set_color yellow) (math --scale 2 $CMD_DURATION / 1000) "s" (set_color normal)
        else
            set -f duration ""
        end
        string join "" -- (set_color $fish_color_cwd) (prompt_pwd) (set_color normal) $duration \n (set_color $prompt_colour) "❯" (set_color normal) " "
      '';
    };
  };

  imports = [
    ./clojure.nix
    ./git.nix
    ./gpg.nix
    ./neovim.nix
  ];

  home.packages =
    [
      (pkgs.ripgrep.override { withPCRE2 = true; })
    ]
    ++ (with pkgs; [
      agenix
      coreutils
      curl
      fd
      ffmpeg
      fh
      jetbrains-mono
      localsend
      pandoc
      shellcheck
      tokei
    ]);

  home.sessionVariables = {
    PAGER = "less -FR";
    EDITOR = "nvim";
    VISUAL = "zed --wait";
    MANPAGER = "nvim +Man!";
  };

  programs.jujutsu = {
    enable = true;
    settings = {
      aliases = {
        sync = [
          "rebase"
          "--source"
          "all:roots(trunk()..@)"
          "--destination"
          "trunk()"
        ];
      };
      signing = {
        backend = "ssh";
        key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKtWR1nXAvSmsd92TC9rMuZIh1Ec8cqxYr3BIyUxdNyy";
        sign-all = true;
      };
      ui = {
        default-command = "log";
        diff.format = "git";
        pager = [
          "${pkgs.delta}/bin/delta"
          "--line-numbers"
        ];
      };
      user = {
        email = "nate@theinternate.com";
        name = "Nate Smith";
      };
    };
  };

  programs.jq.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.zoxide.enable = true;

  programs.eza = {
    enable = true;
    git = true;
    icons = "auto";
  };

  programs.bat = {
    enable = true;
    config.theme = "modus_operandi";
    themes.modus_operandi = {
      src = pkgs.fetchFromGitHub {
        owner = "miikanissi";
        repo = "modus-themes.nvim";
        rev = "7ba45f2";
        sha256 = "sha256-pLjQhhxifUY0ibU82bRd6qSNMYwtNZitFSbcOmO18JQ=";
      };
      file = "extras/bat/modus_operandi.tmTheme";
    };
  };

  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;
  };

  programs.emacs = {
    enable = true;
    extraPackages = (
      epkgs: with epkgs; [
        treesit-grammars.with-all-grammars
        vterm
      ]
    );
  };

  home.file.".psqlrc".source = ./psqlrc;

  programs.fzf = {
    enable = true;
    colors = {
      fg = "#000000";
      bg = "#ffffff";
      hl = "#0031a9";
      "fg+" = "#000000";
      "bg+" = "#c4c4c4";
      "hl+" = "#0031a9";
      border = "#9f9f9f";
      header = "#193668";
      spinner = "#005e8b";
      info = "#005e8b";
      pointer = "#a60000";
      marker = "#a60000";
      prompt = "#0031a9";
    };
    changeDirWidgetCommand = "${pkgs.fd}/bin/fd --type d";
    defaultCommand = "${pkgs.fd}/bin/fd --type f";
    fileWidgetCommand = "${pkgs.fd}/bin/fd --type f";
  };

  programs.btop = {
    enable = true;
    settings.color_theme = "whiteout";
  };

  programs.ghostty = {
    enable = true;
    settings = {
      background = "#ffffff";
      cursor-color = "#000000";
      cursor-text = "#ffffff";
      font-family = "JetBrains Mono";
      font-feature = "-calt";
      foreground = "#000000";
      palette = [
        # black
        "0=#000000"
        "8=#595959"
        # red
        "1=#a60000"
        "9=#972500"
        # green
        "2=#006800"
        "10=#00663f"
        # yellow
        "3=#6f5500"
        "11=#884900"
        # blue
        "4=#0031a9"
        "12=#3548cf"
        # purple
        "5=#721045"
        "13=#531ab6"
        # aqua
        "6=#005e8b"
        "14=#005f5f"
        # white
        "7=#a6a6a6"
        "15=#ffffff"
      ];
      selection-foreground = "#000000";
      selection-background = "#bdbdbd";
    };
  };

  programs.yazi.enable = true;
  programs.yt-dlp.enable = true;
}
