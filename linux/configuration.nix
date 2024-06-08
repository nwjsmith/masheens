{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:

{
  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 8;
  };

  networking.networkmanager.enable = true;

  services.tailscale = {
    enable = true;
    extraUpFlags = [ "--ssh" ];
  };

  time.timeZone = "America/Toronto";

  i18n.defaultLocale = "en_CA.UTF-8";

  nix = {
    registry.nixpkgs.flake = inputs.nixpkgs;
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

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

  environment = {
    systemPackages = with pkgs; [
      git
      neovim
    ];
  };

  users = {
    mutableUsers = false;
    users.nwjsmith = {
      isNormalUser = true;
      description = "Nate Smith";
      home = "/home/nwjsmith";
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
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

  services.xserver = {
    enable = true;
    desktopManager.gnome.enable = true;
    displayManager = {
      autoLogin = {
        enable = true;
        user = "nwjsmith";
      };
      gdm.enable = true;
    };
  };
  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
}
