{ config, inputs, pkgs, ... }:

{
  services.nix-daemon.enable = true;

  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [
      (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
      inter
    ];
  };

  nixpkgs.pkgs = pkgs;

  nix = {
    configureBuildUsers = true;
    extraOptions = ''
      experimental-features = nix-command flakes repl-flake
      extra-nix-path = nixpkgs=${inputs.nixpkgs}
    '';
  };

  programs.zsh = {
    enable = true;
    enableBashCompletion = false;
    enableCompletion = false;
    loginShellInit = ''
      eval "$(${config.homebrew.brewPrefix}/brew shellenv)"
    '';
  };

  environment = {
    systemPackages = with pkgs; [ kitty terminal-notifier ];
    shells = with pkgs; [ bashInteractive zsh ];
    variables = {
      SHELL = "${pkgs.zsh}/bin/zsh";
    };
  };

  security.pam.enableSudoTouchIdAuth = true;

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

  services.karabiner-elements.enable = true;

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
    brews = [
      "bazel"
    ];
    casks = [
      "1password"
      "alloy"
      "android-studio"
      "bartender"
      {
        name = "chromium";
        args.no_quarantine = true;
      }
      "cleanshot"
      "dash"
      "deckset"
      "discord"
      "firefox"
      "google-chrome"
      "intellij-idea"
      "monodraw"
      "notion"
      "obs"
      "obsidian"
      "qmk-toolbox"
      "utm"
      "raycast"
      "reflect"
      "rescuetime"
      "signal"
      "slack"
      "soulver"
      "spotify"
      "sublime-merge"
      "sublime-text"
      "the-unarchiver"
      "tuple"
      "vlc"
      "zoom"
    ];
    masApps = {
      "Flow" = 1423210932;
      "Ivory" = 6444602274;
      "1Password for Safari" = 1569813296;
      "Kindle" = 302584613;
      "Things" = 904280696;
    };
  };
}
