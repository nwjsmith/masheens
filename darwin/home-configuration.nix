{ lib, pkgs, ... }:

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

  programs.ghostty.settings = {
    font-size = 16;
    # macos-non-native-fullscreen = true;
    macos-titlebar-style = "tabs";
    window-save-state = "never";
  };

  home.sessionPath = [
    "/Applications/IntelliJ IDEA.app/Contents/MacOS"
  ];
}
