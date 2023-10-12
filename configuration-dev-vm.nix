{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./dev-vm/hardware-configuration.nix
    ./linux/configuration.nix
    ./dev-vm/configuration.nix
  ];
}
