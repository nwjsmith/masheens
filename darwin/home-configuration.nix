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

  home.file."${config.xdg.configHome}/ghostty/config".text = ''
    background = #ffffff
    cursor-color = #000000
    cursor-text = #ffffff
    font-family = JetBrains Mono
    font-feature = -calt
    font-size = 16
    foreground = #000000
    macos-option-as-alt = true
    palette = 0=#000000
    palette = 8=#595959
    palette = 1=#a60000
    palette = 9=#972500
    palette = 2=#006800
    palette = 10=#00663f
    palette = 3=#6f5500
    palette = 11=#884900
    palette = 4=#0031a9
    palette = 12=#3548cf
    palette = 5=#721045
    palette = 13=#531ab6
    palette = 6=#005e8b
    palette = 14=#005f5f
    palette = 7=#a6a6a6
    palette = 15=#ffffff
    selection-background = #bdbdbd
    selection-foreground = #000000
  '';

  home.sessionPath = [
    "/Applications/IntelliJ IDEA.app/Contents/MacOS"
  ];
}
