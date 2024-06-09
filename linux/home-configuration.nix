{
  pkgs,
  ...
}:

{
  home.username = "nwjsmith";

  home.homeDirectory = "/home/nwjsmith";

  home.packages = with pkgs; [
    _1password-gui
    ibm-plex
    inter
    jetbrains.idea-community-bin
    (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
    obsidian
    racket
    tlaplusToolbox
    tuba
    vlc
  ];

  programs.firefox = {
    enable = true;
    package = pkgs.firefox-wayland;
  };

  programs.git = {
    enable = true;
    userEmail = "nate@theinternate.com";
    userName = "Nate Smith";
    aliases = {
      co = "checkout";
      dc = "diff --cached";
      di = "diff";
      st = "status";
      unstage = "reset --";
      yolo = "push --force-with-lease";
    };
    extraConfig = {
      github.user = "nwjsmith";
      fetch.prune = true;
      init.defaultBranch = "main";
      push.default = "current";
      pull.rebase = true;
      rebase = {
        autoSquash = true;
        autoStash = true;
      };
      merge.conflictStyle = "diff3";
    };
    ignores = [
      ".#*"
      ".dir-locals.el"
      ".direnv/"
      ".idea/"
      ".vscode/"
      ".clj-kondo/"
      ".lsp/"
      "*.iml"
    ];
  };

  fonts.fontconfig.enable = true;

  programs.emacs.package = pkgs.emacs29-pgtk;

  home.stateVersion = "23.05";
}
