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

  imports = [
    ./clojure.nix
    ./git.nix
    ./gpg.nix
    ./neovim.nix
  ];

  home.packages = [
    (pkgs.ripgrep.override { withPCRE2 = true; })
  ] ++ (with pkgs; [
    # aider-chat
    agenix
    # berkeley-mono
    coreutils
    curl
    devenv
    fd
    ffmpeg
    jetbrains-mono
    localsend
    pandoc
    shellcheck
    tokei
  ]);

  home.sessionVariables = {
    PAGER = "less -FR";
  };

  programs.jujutsu = {
    enable = true;
    settings = {
      signing = {
        backend = "gpg";
        key = "nate@theinternate.com";
        sign-all = true;
      };
      ui = {
        diff-editor = ":builtin";
        default-command = "log";
      };
      user = {
        email = "nate@theinternate.com";
        name = "Nate Smith";
      };
    };
  };

  programs.jq.enable = true;

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

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.zsh = {
    enable = true;
    autosuggestion = {
      enable = true;
      highlight = "fg=#595959";
    };
    enableCompletion = true;
    enableVteIntegration = true;
    initExtra = ''
      setopt interactive_comments
      export DIRENV_LOG_FORMAT=""
    '';
    syntaxHighlighting.enable = true;
  };

  programs.zoxide.enable = true;

  programs.eza = {
    enable = true;
    enableZshIntegration = true;
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
    extraPackages = (epkgs: with epkgs; [ treesit-grammars.with-all-grammars vterm ]);
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
      window-vsync = false;
    };
  };
}
