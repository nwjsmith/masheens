{ lib, pkgs, config, ... }:

{
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.zsh = {
    defaultKeymap = "viins";
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    enableVteIntegration = true;
    initExtra = ''
      setopt interactive_comments
      export DIRENV_LOG_FORMAT=""
    '';
    syntaxHighlighting.enable = true;
  };

  programs.zoxide.enable = true;

  home.sessionVariables = {
    PAGER = "less -FR";
  };

  home.sessionPath = [ "${config.home.homeDirectory}/.local/bin" ];

  programs.eza = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.fzf = {
    enable = true;
    defaultCommand = "${pkgs.fd}/bin/fd --type f";
    changeDirWidgetCommand = "${pkgs.fd}/bin/fd --type d";
    fileWidgetCommand = "${pkgs.fd}/bin/fd --type f";
    defaultOptions = [
      "--color=fg:#000000,bg:#ffffff,hl:#0031a9"
      "--color=fg+:#595959,bg+:#ffffff,hl+:#2544bb"
      "--color=info:#005e00,prompt:#a60000,pointer:#5317ac"
      "--color=marker:#315b00,spinner:#721045,header:#00538b"
    ];
  };

  programs.bat = {
    enable = true;
    config = { theme = "gruvbox-light"; };
  };

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

  home.file.".local/bin/gem-constraint" = {
    source = ./local/bin/gem-constraint;
    executable = true;
  };
  home.file.".local/bin/gem-latest" = {
    source = ./local/bin/gem-latest;
    executable = true;
  };

  home.file.".local/bin/show-emacs" = {
    source = ./local/bin/show-emacs;
    executable = true;
  };

  home.file.".local/bin/git-churn" = {
    source = ./local/bin/git-churn;
    executable = true;
  };
  home.file.".local/bin/git-original-branch" = {
    source = ./local/bin/git-original-branch;
    executable = true;
  };
  home.file.".local/bin/git-cclone" = {
    source = ./local/bin/git-cclone;
    executable = true;
  };
  home.file.".local/bin/git-run-branch" = {
    source = ./local/bin/git-run-branch;
    executable = true;
  };

  home.file.".local/bin/ordinalize" = {
    source = ./local/bin/ordinalize;
    executable = true;
  };

  home.file.".local/bin/cycles" = {
    source = ./local/bin/cycles;
    executable = true;
  };

  home.file.".local/bin/gpt-prepare-commit-msg" = {
    source = ./local/bin/gpt-prepare-commit-msg;
    executable = true;
  };
}
