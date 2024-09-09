{ config, inputs, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableBashCompletion = false;
    enableCompletion = false;
    loginShellInit = ''
      eval "$(${config.homebrew.brewPrefix}/brew shellenv)"
    '';
  };

  security.pam.enableSudoTouchIdAuth = true;

  environment = {
    systemPackages = with pkgs; [
      neovim
      git
    ];
    shells = with pkgs; [
      bashInteractive
      zsh
    ];
    variables = {
      SHELL = "${pkgs.zsh}/bin/zsh";
    };
  };

  system = {
    defaults = {
      dock = {
        autohide = true;
        show-recents = false;
        static-only = true;
      };
      LaunchServices.LSQuarantine = false;
      NSGlobalDomain = {
        "com.apple.trackpad.scaling" = 3.0;
        AppleFontSmoothing = 0;
        AppleKeyboardUIMode = 3;
        AppleMeasurementUnits = "Centimeters";
        AppleMetricUnits = 1;
        ApplePressAndHoldEnabled = false;
        AppleTemperatureUnit = "Celsius";
        InitialKeyRepeat = 15;
        KeyRepeat = 2;
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticDashSubstitutionEnabled = false;
        NSAutomaticPeriodSubstitutionEnabled = false;
        NSAutomaticQuoteSubstitutionEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
        NSDisableAutomaticTermination = true;
        NSNavPanelExpandedStateForSaveMode = true;
        NSNavPanelExpandedStateForSaveMode2 = true;
        PMPrintingExpandedStateForPrint = true;
        PMPrintingExpandedStateForPrint2 = true;
      };
      trackpad = {
        Clicking = true;
        TrackpadRightClick = true;
      };
    };
  };

  services.nix-daemon.enable = true;

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
    inter
  ];

  nixpkgs.pkgs = pkgs;

  nix = {
    configureBuildUsers = true;
    extraOptions = ''
      experimental-features = nix-command flakes repl-flake
    '';
    registry.nixpkgs.flake = inputs.nixpkgs;
  };

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };
    global.brewfile = true;
    taps = [
      "homebrew/bundle"
      "homebrew/cask"
      "homebrew/core"
    ];
    casks = [
      "1password"
      "alloy"
      "android-studio"
      "bruno"
      {
        name = "chromium";
        args.no_quarantine = true;
      }
      "cleanshot"
      "dash"
      "deckset"
      "discord"
      "firefox"
      "flameshot"
      "intellij-idea"
      "jordanbaird-ice"
      "keymapp"
      "monodraw"
      "movist-pro"
      "obs"
      "obsidian"
      "ollama"
      "qmk-toolbox"
      "utm"
      "raycast"
      "reflect"
      "rescuetime"
      "signal"
      "soulver"
      "steermouse"
      "the-unarchiver"
      "tuple"
    ];
    masApps = {
      "Flow" = 1423210932;
      "Ivory" = 6444602274;
      "1Password for Safari" = 1569813296;
      "Kindle" = 302584613;
      "Things" = 904280696;
    };
  };

  services.karabiner-elements.enable = true;
}
