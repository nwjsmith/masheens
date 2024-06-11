{
  config,
  ...
}:
{
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
      commit = {
        gpgsign = true;
        template = "${config.xdg.configHome}/git/gitmessage";
      };
      fetch.prune = true;
      github.user = "nwjsmith";
      init.defaultBranch = "main";
      merge.conflictStyle = "diff3";
      pull.rebase = true;
      push.default = "current";
      rebase = {
        autoSquash = true;
        autoStash = true;
      };
    };
    ignores = [
      ".#*"
      ".DS_Store"
      ".dir-locals.el"
      ".direnv/"
      ".idea/"
      ".vscode/"
      ".clj-kondo/"
      ".lsp/"
      "*.iml"
      ".zed/"
    ];
  };
  xdg.configFile."git/gitmessage".source = ./config/git/gitmessage;
}
