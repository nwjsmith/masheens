{
  description = "Nate Smith's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/23.05";
  };

  outputs = {
    self,
    nixpkgs,
  }: {
    nixosConfigurations.dev = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";

      modules = [
        ./configuration.nix
      ];
    };
  };
}
