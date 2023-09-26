{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration-dev.nix
  ];

  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 8;
    };
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
  };

  networking.networkmanager.enable = true;
  networking.hostName = "dev";
  services.tailscale.enable = true;

  time.timeZone = "America/Toronto";
  i18n.defaultLocale = "en_CA.UTF-8";

  nix.settings.experimental-features = ["nix-command" "flakes"];
  nixpkgs.config.allowUnfree = true;

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "prohibit-password";
    };
  };

  environment.systemPackages = with pkgs; [ neovim git ];
  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    MANPAGER = "nvim +Man!";
  };

  programs.zsh.enable = true;
  users = {
    mutableUsers = false;

    users.nwjsmith = {
      isNormalUser = true;
      description = "Nate Smith";
      home = "/home/nwjsmith";
      extraGroups = ["networkmanager" "wheel"];
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
  nixpkgs.config.pulseaudio = true;
  hardware.pulseaudio.enable = true;

  programs.sway.enable = true;
  hardware.opengl.enable = true;

  system.stateVersion = "22.11";
}
