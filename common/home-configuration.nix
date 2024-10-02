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
    agenix
    berkeley-mono
    coreutils
    curl
    fd
    ffmpeg
    localsend
    pandoc
    shellcheck
    tokei
  ]);

  programs.jujutsu.enable = true;

  programs.jq.enable = true;

  programs.ncspot = {
    enable = true;
    settings = {
      use_nerdfont = true;
      theme = {
        background = "#191724";
        primary = "#e0def4";
        secondary = "#908caa";
        title = "#ebbcba";
        playing = "#9ccfd8";
        playing_selected = "#31748f";
        playing_bg = "#26233a";
        highlight = "#ebbcba";
        highlight_bg = "#26233a";
        error = "#eb6f92";
        error_bg = "#1f1d2e";
        statusbar = "#e0def4";
        statusbar_progress = "#f6c177";
        statusbar_bg = "#26233a";
        cmdline = "#e0def4";
        cmdline_bg = "#1f1d2e";
      };
    };
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
    icons = true;
  };

  programs.bat = {
    enable = true;
    config.theme = "rosepine";
    themes.rosepine = {
      src = pkgs.fetchFromGitHub {
        owner = "rose-pine";
        repo = "tm-theme";
        rev = "c4235f9";
        sha256 = "sha256-jji8WOKDkzAq8K+uSZAziMULI8Kh7e96cBRimGvIYKY=";
      };
      file = "dist/themes/rose-pine.tmTheme";
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
      # background = "#ffffff";
      # cursor-color = "#000000";
      # cursor-text = "#ffffff";
      font-family = "Berkeley Mono";
      # foreground = "#000000";
      # palette = [
      #   "0=#ffffff"
      #   "1=#a60000"
      #   "2=#006800"
      #   "3=#6f5500"
      #   "4=#0031a9"
      #   "5=#721045"
      #   "6=#005e8b"
      #   "7=#000000"
      #   "8=#f2f2f2"
      #   "9=#d00000"
      #   "10=#008900"
      #   "11=#808000"
      #   "12=#0000ff"
      #   "13=#dd22dd"
      #   "14=#008899"
      #   "15=#595959"
      #   "16=#884900"
      #   "17=#7f0000"
      # ];
      selection-foreground = "#000000";
      selection-background = "#dfa0f0";
      theme = "rose-pine";
      window-vsync = false;
    };
  };
}
