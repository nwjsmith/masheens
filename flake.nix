{
  description = "Nate Smith's Nix configurations";

  inputs = {
    agenix.url = "github:ryantm/agenix";
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/0.1";
    ghostty = {
      url = "github:ghostty-org/ghostty";
      inputs = {
        nixpkgs-stable.follows = "nixpkgs";
        nixpkgs-unstable.follows = "nixpkgs";
      };
    };
    ghostty-hm.url = "github:clo4/ghostty-hm-module";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager.url = "github:nix-community/home-manager";
    nixcasks = {
      url = "github:jacekszymanski/nixcasks";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs = {
        nix-darwin.follows = "nix-darwin";
        home-manager.follows = "home-manager";
      };
    };
  };

  outputs =
    {
      agenix,
      determinate,
      ghostty,
      ghostty-hm,
      nixpkgs,
      nix-darwin,
      nixcasks,
      nixvim,
      home-manager,
      ...
    }@inputs:
    let
      lib = nixpkgs.lib;
      forSystems =
        systems: f:
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
      makeSystem =
        {
          system,
          host,
          user,
          home,
        }:
        let
          os = lib.lists.last (lib.strings.splitString "-" system);
          osSystem = if os == "linux" then lib.nixosSystem else nix-darwin.lib.darwinSystem;
          hm =
            if os == "linux" then
              home-manager.nixosModules.home-manager
            else
              home-manager.darwinModules.home-manager;
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
                ghostty = ghostty.packages.${system}.default;
              })
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
                  { ... }:
                  {
                    imports = [
                      agenix.homeManagerModules.default
                      ghostty-hm.homeModules.default
                      nixvim.homeManagerModules.nixvim
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

      formatter = forAllSystems ({ pkgs, ... }: pkgs.nixfmt-rfc-style);

      devShells = forAllSystems (
        { pkgs, ... }:
        {
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
