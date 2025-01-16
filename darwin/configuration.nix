{pkgs, ...}: {
  security.pam.enableSudoTouchIdAuth = true;

  environment = {
    shells = with pkgs; [
      fish
    ];
  };

  programs.fish.enable = true;

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
    stateVersion = 5;
  };

  fonts.packages = with pkgs; [
    nerd-fonts.symbols-only
    inter
  ];

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
      "bettermouse"
      "bruno"
      "chatgpt"
      {
        name = "chromium";
        args.no_quarantine = true;
      }
      "cursor"
      "cleanshot"
      "dash"
      "deckset"
      "discord"
      "firefox"
      "intellij-idea"
      "jordanbaird-ice"
      "karabiner-elements"
      "keymapp"
      "meetingbar"
      "monodraw"
      "obs"
      "obsidian"
      "ollama"
      "omnifocus"
      "utm"
      "raindropio"
      "raycast"
      "sf-symbols"
      "signal"
      "soulver"
      "spotify"
      "the-unarchiver"
      "tuple"
      "zed"
    ];
    masApps = {
      "1Password for Safari" = 1569813296;
      "Kindle" = 302584613;
    };
  };
}
