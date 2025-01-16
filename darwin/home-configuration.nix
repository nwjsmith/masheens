{ config, pkgs, ... }:

{
  imports = [
    ./gpg.nix
  ];

  programs.emacs.package = pkgs.emacs-macport;

  programs.fish = {
    enable = true;
    plugins = [
      {
        name = "brew";
        src = pkgs.fetchFromGitHub {
          owner = "oh-my-fish";
          repo = "plugin-brew";
          rev = "328fc82e1c8e6fd5edc539de07e954230a9f2cef";
          sha256 = "sha256-ny82EAz0K4XYASEP/K8oxyhyumrITwC5lLRd+HScmNQ=";
        };
      }
    ];
  };

  programs.ghostty = {
    enable = true;
    package = pkgs.nur.repos.DimitarNestorov.ghostty;
    installBatSyntax = false;
    settings = {
      font-family = "JetBrains Mono";
      font-feature = "-calt";
      font-size = 15;

      macos-option-as-alt = true;

      background = "#ffffff";
      cursor-color = "#000000";
      cursor-text = "#ffffff";
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

  home.sessionPath = [
    "/Applications/IntelliJ IDEA.app/Contents/MacOS"
  ];
}
