{
  description = "Nate Smith's Nix configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager.url = "github:nix-community/home-manager";
  };

  outputs =
    { self
    , nixpkgs
    , nix-darwin
    , home-manager
    }:
    let
      forSystems = systems: f: nixpkgs.lib.genAttrs systems (system: f rec {
        inherit system;
        pkgs = import nixpkgs { inherit system; };
      });
      forAllSystems = forSystems [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" ];
      makeSystem =
        { osSystem
        , system
        , cm
        , hm
        , user
        , home
        , hm-config
        }: osSystem {
          inherit system;

          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };

          modules = [
            cm
            hm
            {
              users.users.${user}.home = home;
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.nwjsmith = import hm-config;
              };
            }
          ];
        };
    in
    {
      nixosConfigurations.dev = makeSystem {
        osSystem = nixpkgs.lib.nixosSystem;
        system = "x86_64-linux";
        cm = ./configuration-dev.nix;
        hm = home-manager.nixosModules.home-manager;
        user = "nwjsmith";
        home = "/home/nwjsmith";
        hm-config = ./home.nix;
      };

      nixosConfigurations.dev-vm = makeSystem {
        osSystem = nixpkgs.lib.nixosSystem;
        system = "aarch64-linux";
        cm = ./configuration-dev-vm.nix;
        hm = home-manager.nixosModules.home-manager;
        user = "nwjsmith";
        home = "/home/nwjsmith";
        hm-config = ./home.nix;
      };

      darwinConfigurations.nsmith0dae = makeSystem {
        osSystem = nix-darwin.lib.darwinSystem;
        system = "aarch64-darwin";
        hm = home-manager.darwinModules.home-manager;
        user = "nsmith";
        home = "/Users/nsmith";
        hm-config = ./darwin/home.nix;
      };

      devShells = forAllSystems ({ system, pkgs, ... }:
        {
          default = pkgs.mkShell {
            buildInputs = with pkgs; [
              nixpkgs-fmt
            ];
          };
        });
    };
}
