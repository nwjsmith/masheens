{
  config,
  lib,
  pkgs,
  ...
}:

{
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking.hostName = "dev";

  system.stateVersion = "23.11";
}
