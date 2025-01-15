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
    background = #000000
    foreground = #ffffff
    palette = 0=#000000
    palette = 1=#ff5f59
    palette = 2=#44bc44
    palette = 3=#d0bc00
    palette = 4=#2fafff
    palette = 5=#feacd0
    palette = 6=#00d3d0
    palette = 7=#ffffff
    palette = 8=#1e1e1e
    palette = 9=#ff5f5f
    palette = 10=#44df44
    palette = 11=#efef00
    palette = 12=#338fff
    palette = 13=#ff66ff
    palette = 14=#00eff0
    palette = 15=#989898

    font-family = JetBrains Mono
    font-feature = -calt
    font-size = 15
    macos-option-as-alt = true
  '';

  home.sessionPath = [
    "/Applications/IntelliJ IDEA.app/Contents/MacOS"
  ];
}
