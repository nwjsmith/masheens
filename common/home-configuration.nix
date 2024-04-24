{ config, lib, pkgs, ... }:

{
  programs.home-manager.enable = true;

  imports = [
    ./clojure.nix
  ];

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
    config.theme = "gruvbox-light";
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
      "--color=bg+:#EBDBB2"     # Background color for current line (soft light)
      "--color=bg:#FBF1C7"      # Background color for other lines (light)
      "--color=spinner:#CC241D" # Spinner color (strong red)
      "--color=hl:#B16286"      # Highlight color for matched text (muted purple)
      "--color=fg:#3C3836"      # Foreground color for text (dark gray for light backgrounds)
      "--color=header:#7C6F64"  # Header color (muted foreground)
      "--color=info:#98971A"    # Info color (muted green)
      "--color=pointer:#9D0006" # Pointer color (strong red)
      "--color=marker:#CC241D"  # Marker color (strong red)
      "--color=fg+:#282828"     # Foreground color for current line (dark background)
      "--color=prompt:#CC241D"  # Prompt color (strong red)
      "--color=hl+:#FB4934"     # Highlight color for matched text on current line (strong red)
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
}
