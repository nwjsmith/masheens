{
  config,
  lib,
  pkgs,
  ...
}:

{
  boot.loader.efi = {
    canTouchEfiVariables = true;
    efiSysMountPoint = "/boot/efi";
  };

  networking.hostName = "dev";

  system.stateVersion = "22.11";
}
