{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking.hostName = "dev";
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

  users = {
    mutableUsers = false;

    users.nwjsmith = {
      isNormalUser = true;
      home = "/home/nwjsmith";
      extraGroups = ["wheel"];
      hashedPassword = "$6$PUhJVThTRYeN3KJP$Bz6iTc4rbVAQmFGCX9ou15JXqG8IlEpVTjyEMRPhn3ALJ6uIPzgCj7.RY3L1fC3ZZwM97UTUYzER/vSiAzUm6.";
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKtWR1nXAvSmsd92TC9rMuZIh1Ec8cqxYr3BIyUxdNyy"
      ];
    };

    users.root.openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKtWR1nXAvSmsd92TC9rMuZIh1Ec8cqxYr3BIyUxdNyy"
    ];
  };
  security.sudo.wheelNeedsPassword = false;

  system.stateVersion = "23.05";
}
