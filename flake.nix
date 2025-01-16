{
  description = "Nate Smith's Nix configurations";

  inputs = {
    agenix.url = "github:ryantm/agenix";
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/0.1";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager.url = "github:nix-community/home-manager";
  };

  outputs = {
    agenix,
    determinate,
    nixpkgs,
    nix-darwin,
    home-manager,
    nur,
    ...
  } @ inputs: let
    lib = nixpkgs.lib;
    forSystems = systems: f:
      lib.genAttrs systems (
        system:
          f {
            inherit system;
            pkgs = import nixpkgs {
              inherit system;
            };
          }
      );
    forAllSystems = forSystems [
      "x86_64-linux"
      "aarch64-linux"
      "aarch64-darwin"
    ];
    makeSystem = {
      system,
      host,
      user,
      home,
    }: let
      os = lib.lists.last (lib.strings.splitString "-" system);
      osSystem =
        if os == "linux"
        then lib.nixosSystem
        else nix-darwin.lib.darwinSystem;
      hm =
        if os == "linux"
        then home-manager.nixosModules.home-manager
        else home-manager.darwinModules.home-manager;
    in
      osSystem {
        inherit system;

        specialArgs = {
          inherit inputs;
        };

        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
          overlays = [
            (final: prev: {
              agenix = agenix.packages.${system}.default;
            })
            nur.overlays.default
          ];
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
              users.${user} = (
                {...}: {
                  imports = [
                    agenix.homeManagerModules.default
                    ./common/home-configuration.nix
                    ./${os}/home-configuration.nix
                    ./${host}/home-configuration.nix
                  ];
                }
              );
            };
          }
          agenix.nixosModules.default
          determinate.darwinModules.default
        ];
      };
  in {
    nixosConfigurations.dev = makeSystem {
      system = "x86_64-linux";
      host = "dev";
      user = "nwjsmith";
      home = "/home/nwjsmith";
    };

    darwinConfigurations.nsmith0dae = makeSystem {
      system = "aarch64-darwin";
      host = "nsmith0dae";
      user = "nsmith";
      home = "/Users/nsmith";
    };

    formatter = forAllSystems ({pkgs, ...}: pkgs.alejandra);

    devShells = forAllSystems (
      {pkgs, ...}: {
        default = pkgs.mkShell {
          buildInputs = with pkgs; [
            bash-language-server
            clojure-lsp
            clj-kondo
            nil
            nodePackages.prettier
            shellcheck
            treefmt
          ];
        };
      }
    );
  };
}
