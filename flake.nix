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
    }@inputs:
    let
      lib = nixpkgs.lib;
      forSystems = systems: f: lib.genAttrs systems (system: f rec {
        inherit system;
        pkgs = import nixpkgs { inherit system; };
      });
      forAllSystems = forSystems [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" ];
      makeSystem =
        { system
        , host
        , user
        , home
        }:
        let
          os = lib.lists.last (lib.strings.splitString "-" system);
          osSystem = if os == "linux" then lib.nixosSystem else nix-darwin.lib.darwinSystem;
          hm = if os == "linux" then home-manager.nixosModules.home-manager else home-manager.darwinModules.home-manager;
        in
        osSystem {
          inherit system;

          specialArgs = { inherit inputs; };

          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };

          modules = [
            {
              imports = [
                ./${host}/hardware-configuration.nix
                ./common/configuration.nix
                ./${os}/configuration.nix
                ./${host}/configuration.nix
              ];
            }
            hm
            {
              users.users.${user}.home = home;
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.${user} = ({ ... }: {
                  imports = [
                    ./common/home-configuration.nix
                    ./${os}/home-configuration.nix
                    ./${host}/home-configuration.nix
                  ];
                });
              };
            }
          ];
        };
    in
    {
      nixosConfigurations.dev = makeSystem {
        system = "x86_64-linux";
        host = "dev";
        user = "nwjsmith";
        home = "/home/nwjsmith";
      };

      nixosConfigurations.dev-vm = makeSystem {
        system = "aarch64-linux";
        host = "dev-vm";
        user = "nwjsmith";
        home = "/home/nwjsmith";
      };

      darwinConfigurations.nsmith0dae = makeSystem {
        system = "aarch64-darwin";
        host = "nsmith0dae";
        user = "nsmith";
        home = "/Users/nsmith";
      };

      devShells = forAllSystems ({ system, pkgs, ... }:
        {
          default = pkgs.mkShell {
            buildInputs = with pkgs; [
              nixpkgs-fmt
              treefmt
              nodePackages.prettier
              # clj-kondo
              shellcheck
            ];
          };
        });
    };
}
