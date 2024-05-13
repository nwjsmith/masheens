{ ... }:

{
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
      "bartender"
      {
        name = "chromium";
        args.no_quarantine = true;
      }
      "cleanshot"
      "dash"
      "deckset"
      "discord"
      "intellij-idea"
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
      "the-unarchiver"
    ];
    masApps = {
      "Flow" = 1423210932;
      "Ivory" = 6444602274;
      "1Password for Safari" = 1569813296;
      "Kindle" = 302584613;
      "Things" = 904280696;
    };
  };

  environment.variables = {
    EDITOR = "zed --wait";
    VISUAL = "zed --wait";
  };

  services.karabiner-elements.enable = true;
}
