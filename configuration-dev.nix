{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./dev/hardware-configuration.nix
    ./linux/configuration.nix
    ./dev/configuration.nix
  ];
}
