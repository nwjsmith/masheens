{
  config,
  pkgs,
  ...
}: {
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
    package = pkgs.nur.repos.DimitarNestorov.ghostty;
    installBatSyntax = false;
    settings = {
      font-size = 15;
      macos-option-as-alt = true;
    };
  };

  home.sessionPath = [
    "/Applications/IntelliJ IDEA.app/Contents/MacOS"
  ];
}
