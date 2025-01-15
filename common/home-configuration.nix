{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.home-manager.enable = true;

  home.sessionPath = [ "${config.home.homeDirectory}/.local/bin" ];
  home.file.".local/bin/jj-colocate" = {
    source = ./local/bin/jj-colocate;
    executable = true;
  };
  home.file.".local/bin/jj-pr" = {
    source = ./local/bin/jj-pr;
    executable = true;
  };
  home.file.".local/bin/jj-merge" = {
    source = ./local/bin/jj-merge;
    executable = true;
  };

  programs.fish = let
    modusTheme = builtins.fetchurl {
      url = "https://raw.githubusercontent.com/miikanissi/modus-themes.nvim/35980f19daef4745c96f1cb292d484fb1f33f822/extras/fish/modus_vivendi.fish";
      sha256 = "sha256:08hqxzchghf3k8rjfi2nnklh74m5ws4qkagixvnbvyqvgj7d4nn2";
    };
  in {
    enable = true;
    interactiveShellInit = ''
      fish_vi_key_bindings
      set -g fish_last_login ""
      set -g pure_enable_git false
      set -g pure_show_subsecond_command_duration true
      set -g pure_threshold_command_duration 2
      set -g pure_check_for_new_release false
      set -g pure_color_success green
      source ${modusTheme}
    '';
    functions.fish_greeting = "";
    plugins = [
      {
        inherit (pkgs.fishPlugins.pure) src;
        name = "pure";
      }
    ];
  };

  imports = [
    ./clojure.nix
    ./git.nix
    ./gpg.nix
    ./neovim.nix
  ];

  home.packages =
    [
      (pkgs.ripgrep.override { withPCRE2 = true; })
    ]
    ++ (with pkgs; [
      agenix
      coreutils
      curl
      fd
      ffmpeg
      fh
      jetbrains-mono
      localsend
      pandoc
      shellcheck
      tokei
    ]);

  home.sessionVariables = {
    PAGER = "less -FR";
    VISUAL = "zed --wait";
    MANPAGER = "nvim +Man!";
  };

  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings.theme = "modus_vivendi";
  };

  programs.jujutsu = {
    enable = true;
    settings = {
      aliases.sync = [
        "rebase"
        "--source"
        "all:roots(trunk()..@)"
        "--destination"
        "trunk()"
      ];
      signing = {
        backend = "ssh";
        key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKtWR1nXAvSmsd92TC9rMuZIh1Ec8cqxYr3BIyUxdNyy";
        sign-all = true;
      };
      ui = {
        default-command = "log";
        diff.format = "git";
        pager = [
          "${pkgs.delta}/bin/delta"
          "--line-numbers"
        ];
      };
      user = {
        email = "nate@theinternate.com";
        name = "Nate Smith";
      };
    };
  };

  programs.jq.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.eza = {
    enable = true;
    git = true;
    icons = "auto";
  };

  programs.bat = {
    enable = true;
    config.theme = "modus_vivendi";
    themes.modus_vivendi = {
      src = pkgs.fetchFromGitHub {
        owner = "miikanissi";
        repo = "modus-themes.nvim";
        rev = "7ba45f2";
        sha256 = "sha256-pLjQhhxifUY0ibU82bRd6qSNMYwtNZitFSbcOmO18JQ=";
      };
      file = "extras/bat/modus_vivendi.tmTheme";
    };
  };

  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;
  };

  programs.emacs = {
    enable = true;
    extraPackages = (
      epkgs: with epkgs; [
        treesit-grammars.with-all-grammars
        vterm
      ]
    );
  };
  xdg.configFile."doom/init.el".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Code/nwjsmith/masheens/doom.d/init.el";
  xdg.configFile."doom/config.el".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Code/nwjsmith/masheens/doom.d/config.el";
  xdg.configFile."doom/packages.el".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Code/nwjsmith/masheens/doom.d/packages.el";

  home.file.".psqlrc".source = ./psqlrc;

  programs.fzf = {
    enable = true;
    colors = {
      bg = "#282828";
      "bg+" = "#3c3836";
      "fg" = "#bdae93";
      "fg+" = "#ebdbb2";
      spinner = "#8ec07c";
      hl = "#83a598";
      header = "#83a598";
      info = "#fabd2f";
      pointer = "#8ec07c";
      marker = "#8ec07c";
      prompt = "#fabd2f";
      "hl+" = "#83a598";
    };
    changeDirWidgetCommand = "${pkgs.fd}/bin/fd --type d";
    defaultCommand = "${pkgs.fd}/bin/fd --type f";
    fileWidgetCommand = "${pkgs.fd}/bin/fd --type f";
  };

  programs.btop = {
    enable = true;
    settings.color_theme = "whiteout";
  };

  programs.yazi.enable = true;
  programs.yt-dlp.enable = true;

  programs.zoxide.enable = true;
}
