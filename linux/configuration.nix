{ config, lib, pkgs, ... }:

{
  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 8;
  };

  networking.networkmanager.enable = true;

  services.tailscale = {
    enable = true;
    extraUpFlags = [
      "--ssh"
    ];
  };

  time.timeZone = "America/Toronto";

  i18n.defaultLocale = "en_CA.UTF-8";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "prohibit-password";
    };
  };

  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = [ "*" ];
      settings.main.capslock = "overload(control, esc)";
    };
  };

  environment.systemPackages = with pkgs; [ ibm-plex neovim git ];

  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    MANPAGER = "nvim +Man!";
  };

  users = {
    mutableUsers = false;
    users.nwjsmith = {
      isNormalUser = true;
      description = "Nate Smith";
      home = "/home/nwjsmith";
      extraGroups = [ "networkmanager" "wheel" ];
      hashedPassword = "$y$j9T$aJNKS3JG64FqRJKIWTq5f1$OfZVU/eVlqrU/O4XMZo/G9OocZtZGZ1ddd7Tg5HSwUB";
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKtWR1nXAvSmsd92TC9rMuZIh1Ec8cqxYr3BIyUxdNyy"
      ];
      shell = pkgs.zsh;
    };
    users.root.openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKtWR1nXAvSmsd92TC9rMuZIh1Ec8cqxYr3BIyUxdNyy"
    ];
  };


  programs.zsh.enable = true;

  security.sudo.wheelNeedsPassword = false;

  console.earlySetup = true;

  services.greetd = {
    enable = true;
    settings.default_session.command = ''
      ${pkgs.greetd.tuigreet}/bin/tuigreet \
        --time \
        --asterisks \
        --user-menu \
        --cmd sway
    '';
  };

  environment.etc."greetd/environments".text = "sway";

  security.polkit.enable = true;

  sound.enable = true;

  hardware.pulseaudio.enable = true;

  hardware.opengl.enable = true;

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = [ "IBM Plex Mono" ];
      sansSerif = [ "IBM Plex Sans" ];
      serif = [ "IBM Plex Serif" ];
      emoji = [ "Noto Color Emoji" ];
    };
    hinting.enable = false;
  };
}
