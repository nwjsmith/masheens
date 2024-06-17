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
