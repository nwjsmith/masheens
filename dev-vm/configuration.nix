{
  ...
}:

{
  networking = {
    hostName = "dev-vm";
    interfaces.enp0s1.useDHCP = true;
  };

  services.qemuGuest.enable = true;

  services.spice-vdagentd.enable = true;

  virtualisation.spiceUSBRedirection.enable = true;

  system.stateVersion = "23.05";
}
