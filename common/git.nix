{config, ...}: {
  programs.git = {
    enable = true;
    userEmail = "nate@theinternate.com";
    userName = "Nate Smith";
    delta = {
      enable = true;
      options.syntax-theme = "modus_operandi";
    };
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
      gpg.format = "ssh";
      init.defaultBranch = "main";
      merge.conflictStyle = "zdiff3";
      pull.rebase = true;
      push.default = "current";
      user.signingkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKtWR1nXAvSmsd92TC9rMuZIh1Ec8cqxYr3BIyUxdNyy";
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
  xdg.configFile."git/gitmessage".source = ./git/gitmessage;
}
