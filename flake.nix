{
  description = "Nate Smith's Nix configurations";

  inputs = {
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixos-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    home-manager.url = "github:nix-community/home-manager";
  };

  outputs = {
    self,
    nixpkgs-unstable,
    nixos-unstable,
    nix-darwin,
    home-manager,
  }: {
    nixosConfigurations.dev = nixos-unstable.lib.nixosSystem {
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

    nixosConfigurations.dev-vm = nixos-unstable.lib.nixosSystem {
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

    darwinConfigurations.nsmith0dae = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";

      pkgs = import nixpkgs-unstable {
        system = "aarch64-darwin";
        config.allowUnfree = true;
      };

      modules = [
        home-manager.darwinModules.home-manager
        ./darwin/darwin.nix
        ({...}: {
          users.users.nsmith.home = "/Users/nsmith";
          home-manager = {
            useGlobalPkgs = true;
            users.nsmith = import ./darwin/home.nix;
          };
        })
      ];
    };
  };
}
