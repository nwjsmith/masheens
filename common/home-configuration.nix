{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.home-manager.enable = true;

  imports = [
    ./clojure.nix
    ./neovim.nix
  ];

  home.packages = [
    (pkgs.ripgrep.override { withPCRE2 = true; })
    (pkgs.tree-sitter.withPlugins (_: pkgs.tree-sitter.allGrammars))
  ] ++ (with pkgs; [
    asciinema
    coreutils
    curl
    fd
    ffmpeg
    flameshot
    gh
    go
    gopls
    jq
    jujutsu
    localsend
    nodejs
    scc
    shellcheck
    sqlite
    tmux
  ]);

  programs.emacs = {
    enable = true;
    extraPackages = (epkgs: [ epkgs.vterm ]);
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

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.zsh = {
    enable = true;
    autosuggestion = {
      enable = true;
      highlight = "fg=#595959";
    };
    enableCompletion = true;
    enableVteIntegration = true;
    initExtra = ''
      setopt interactive_comments
      export DIRENV_LOG_FORMAT=""
    '';
    syntaxHighlighting.enable = true;
  };

  programs.zoxide.enable = true;

  programs.eza = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.bat = {
    enable = true;
    config.theme = "ansi";
  };

  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;
  };

  programs.fzf = {
    enable = true;
    defaultCommand = "${pkgs.fd}/bin/fd --type f";
    changeDirWidgetCommand = "${pkgs.fd}/bin/fd --type d";
    fileWidgetCommand = "${pkgs.fd}/bin/fd --type f";
    defaultOptions = [
      "--color=fg:#000000,bg:#ffffff,hl:#0031a9"
      "--color=fg+:#000000,bg+:#c4c4c4,hl+:#0031a9"
      "--color=info:#005e8b"
      "--color=border:#9f9f9f"
      "--color=header:#193668"
      "--color=prompt:#0031a9"
      "--color=pointer:#a60000"
      "--color=marker:#a60000"
      "--color=spinner:#005e8b"
    ];
  };

  home.activation = {
    installDoom = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      DOOM="${config.xdg.configHome}/emacs"
      [ ! -d $DOOM ] && \
        $DRY_RUN_CMD ${pkgs.git}/bin/git clone --depth 1 https://github.com/doomemacs/doomemacs.git $DOOM
    '';
  };
  home.sessionPath = [ "${config.xdg.configHome}/emacs/bin" ];

  home.file.".doom.d/init.el".source = ./doom.d/init.el;
  home.file.".doom.d/packages.el".source = ./doom.d/packages.el;
  home.file.".doom.d/config.el".source = ./doom.d/config.el;
  home.file.".doom.d/w.svg".source = ./doom.d/w.svg;

  xdg.configFile."shellcheckrc".source = ./shellcheckrc;
  xdg.configFile."ghostty/config".source = ./config/ghostty/config;
}
