{
  description = "Nate Smith's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
  }: {
    nixosConfigurations.dev = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        ./configuration-dev.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.nwjsmith = import ./home.nix;
        }
      ];
    };
    nixosConfigurations.dev-vm = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";

      modules = [
        ./configuration-dev-vm.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.nwjsmith = import ./home.nix;
        }
      ];
    };
  };
}
