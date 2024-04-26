{
  lib,
  pkgs,
  config,
  ...
}:

{
  home.sessionVariables = {
    PAGER = "less -FR";
  };

  home.sessionPath = [ "${config.home.homeDirectory}/.local/bin" ];

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
