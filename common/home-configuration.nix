{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.home-manager.enable = true;

  imports = [ ./clojure.nix ];

  home.packages = with pkgs; [
    asciinema
    coreutils
    curl
    fd
    ffmpeg
    gh
    go
    gopls
    jq
    jujutsu
    lazygit
    nodejs
    (ripgrep.override { withPCRE2 = true; })
    scc
    shellcheck
    sqlite
    tmux
    (tree-sitter.withPlugins (_: tree-sitter.allGrammars))
  ];

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
      "--color=fg:#000000"
      "--color=bg:#ffffff"
      "--color=preview-fg:#595959"
      "--color=preview-bg:#f0f0f0"
      "--color=hl:#193668"
      "--color=fg+:#ffffff"
      "--color=bg+:#c4c4c4"
      "--color=gutter:#c4c4c4"
      "--color=hl+:#193668"
      "--color=info:#005f5f"
      "--color=border:#9f9f9f"
      "--color=prompt:#0031a9"
      "--color=pointer:#b2b2b2"
      "--color=marker:#94d4ff"
      "--color=spinner:#0000ff"
      "--color=header:#0000b0"
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
