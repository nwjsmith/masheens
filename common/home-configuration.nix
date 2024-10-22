{
  lib,
  pkgs,
  ...
}:

{
  programs.home-manager.enable = true;

  imports = [
    ./clojure.nix
    ./git.nix
    ./gpg.nix
    ./neovim.nix
  ];

  home.packages = [
    (pkgs.ripgrep.override { withPCRE2 = true; })
  ] ++ (with pkgs; [
    aider-chat
    agenix
    # berkeley-mono
    coreutils
    curl
    devenv
    fd
    ffmpeg
    localsend
    pandoc
    shellcheck
    tokei
  ]);

  programs.jujutsu = {
    enable = true;
    settings = {
      signing = {
        backend = "gpg";
        key = "nate@theinternate.com";
        sign-all = true;
      };
      ui.default-command = "log";
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
      fg = "#908caa";
      bg = "#191724";
      hl = "#ebbcba";
      "fg+" = "#e0def4";
      "bg+" = "#26233a";
      "hl+" = "#ebbcba";
      border = "#403d52";
      header = "#31748f";
      gutter = "#191724";
      spinner = "#f6c177";
      info = "#9ccfd8";
      pointer = "#c4a7e7";
      marker = "#eb6f92";
      prompt = "#908caa";
    };
    changeDirWidgetCommand = "${pkgs.fd}/bin/fd --type d";
    defaultCommand = "${pkgs.fd}/bin/fd --type f";
    fileWidgetCommand = "${pkgs.fd}/bin/fd --type f";
  };

  programs.ghostty = {
    enable = true;
    settings = {
      background = "#ffffff";
      cursor-color = "#000000";
      cursor-text = "#ffffff";
      font-family = "Berkeley Mono";
      foreground = "#000000";
      palette = [
        "0=#ffffff"
        "1=#a60000"
        "2=#006800"
        "3=#6f5500"
        "4=#0031a9"
        "5=#721045"
        "6=#005e8b"
        "7=#000000"
        "8=#f2f2f2"
        "9=#d00000"
        "10=#008900"
        "11=#808000"
        "12=#0000ff"
        "13=#dd22dd"
        "14=#008899"
        "15=#595959"
        "16=#884900"
        "17=#7f0000"
      ];
      selection-foreground = "#000000";
      selection-background = "#dfa0f0";
      window-vsync = false;
    };
  };
}
