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
    ffmpeg
    localsend
    tokei
  ]);

  programs.jujutsu.enable = true;

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
  };

  programs.bat = {
    enable = true;
    config.theme = "ansi";
  };

  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;
  };

  home.file.".psqlrc".source = ./psqlrc;

  programs.fzf = {
    enable = true;
    defaultCommand = "${pkgs.fd}/bin/fd --type f";
    changeDirWidgetCommand = "${pkgs.fd}/bin/fd --type d";
    fileWidgetCommand = "${pkgs.fd}/bin/fd --type f";
    defaultOptions = [
      "--color=fg:#000000,bg:#ffffff,hl:#0031a9"
      "--color=fg+:#000000,bg+:#c4c4c4,hl+:#0031a9"
      "--color=info:#005e8b"
      "--color=border:#9f9f9f"
      "--color=header:#193668"
      "--color=prompt:#0031a9"
      "--color=pointer:#a60000"
      "--color=marker:#a60000"
      "--color=spinner:#005e8b"
    ];
  };

  programs.ghostty = {
    enable = true;
    settings = {
      background = "#f5f5f5";
      cursor-color = "#de5735";
      cursor-text = "#f5f5f5";
      font-family = "Berkeley Mono";
      foreground = "#1f1f1f";
      palette = [
        "0=#f5f5f5"
        "1=#cb3a2a"
        "2=#14710a"
        "3=#846e15"
        "4=#644ac9"
        "5=#a3144d"
        "6=#036a96"
        "7=#1f1f1f"
        "8=#635d97"
        "9=#d74c3d"
        "10=#198d0c"
        "11=#9e841a"
        "12=#7862d0"
        "13=#bf185a"
        "14=#047fb4"
        "15=#2c2b31"
      ];
      selection-foreground = "#f5f5f5";
      selection-background = "#de5735";
      window-vsync = false;
    };
  };
}
