{
  config,
  inputs,
  pkgs,
  ...
}:

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
    '';
    registry.nixpkgs.flake = inputs.nixpkgs;
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
    systemPackages = with pkgs; [
      kitty
      terminal-notifier
    ];
    shells = with pkgs; [
      bashInteractive
      zsh
    ];
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

  homebrew = {
    taps = [ "wealthsimple/tap" ];
    casks = [
      "google-chrome"
      "intellij-idea"
      "notion"
      "slack"
      "tuple"
      "zoom"
    ];
  };
}
