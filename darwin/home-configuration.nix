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

      background = "#000000";
      cursor-color = "#ffffff";
      cursor-text = "#000000";
      foreground = "#ffffff";
      palette = [
        # black
        "0=#000000"
        "8=#595959"
        # red
        "1=#ff5f59"
        "9=#ff7f9f"
        # green
        "2=#44bc44"
        "10=#70b900"
        # yellow
        "3=#d0bc00"
        "11=#fec43f"
        # blue
        "4=#2fafff"
        "12=#79a8ff"
        # purple
        "5=#feacd0"
        "13=#b6a0ff"
        # aqua
        "6=#00d3d0"
        "14=#6ae4b9"
        # white
        "7=#ffffff"
        "15=#989898"
      ];
      selection-foreground = "#ffffff";
      selection-background = "#3c3c3c";
    };
  };

  home.sessionPath = [
    "/Applications/IntelliJ IDEA.app/Contents/MacOS"
  ];
}
