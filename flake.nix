{
  description = "Apollo's NixOS and Home Manager configurations";

  inputs = {
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-23.11"; # or whatever stable version you want
    home-manager-unstable.url = "github:nix-community/home-manager/master";
    home-manager-stable.url = "github:nix-community/home-manager/release-23.11";
    stylix.url = "github:danth/stylix";
    nix-minecraft.url = "github:Infinidoge/nix-minecraft";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = { self, nixpkgs-unstable, nixpkgs-stable, home-manager-unstable, home-manager-stable, stylix, nix-minecraft, nixvim, darwin, ... }:
  let
    systemForHost = { host, pkgs }:
      pkgs.lib.systems.examples.${host.system};

    mkNixosConfig = { system, hostname, modules, username, nixpkgs, hmInputs }:
      nixpkgs.lib.nixosSystem {
        inherit system;
        modules = modules ++ [
          ./hosts/nixos/configuration.nix
          {
            imports = [
              ./modules/systems/desktop.nix
              stylix.nixosModules.stylix
            ];
          }
          hmInputs.home-manager.nixosModules.home-manager
          {
            home-manager.users.${username} = {
              imports = [
                ./home/${username}.nix
              ];
            };
            home-manager.useGlobalPkgs = true;
          }
          ./hosts/nixos/${hostname}/default.nix
          ./hosts/nixos/${hostname}/hardware-configuration.nix
        ];
        specialArgs = {
          inherit username; 
          inherit self; 
          inherit nixpkgs;
          inherit system;
          inherit nixvim;
        };
      };

    mkDarwinConfig = { system, modules, username, nixpkgs, hmInputs }:
      darwin.lib.darwinSystem {
        inherit system;
        modules = modules ++ [
          hmInputs.home-manager.darwinModules.home-manager
          {
            home-manager.users.${username} = import ./home/${username}.nix;
            home-manager.useGlobalPkgs = true;
            home-manager.users.${username}.imports = [
              ./home/programs/default.nix
              ./home/terminals/default.nix
              ./home/nixvim/default.nix
            ];
          }
          ./hosts/darwin/macbook/default.nix
          ./hosts/darwin/configuration.nix
        ];
        specialArgs = {
          inherit username self nixpkgs-unstable system nixvim;
        };
      };

  in
  {
    nixosConfigurations = {
      nyx = mkNixosConfig {
        system = "x86_64-linux";
        hostname = "nyx";
        username = "apollo";
        nixpkgs = nixpkgs-unstable;
        hmInputs = {
          home-manager = home-manager-unstable;
          nixpkgs = nixpkgs-unstable;
        };
        modules = [
          ./hosts/nixos/nyx/default.nix
        ];
      };
      tartarus = mkNixosConfig {
        system = "x86_64-linux";
        hostname = "tartarus";
        username = "aries";
        nixpkgs = nixpkgs-unstable;
        hmInputs = {
          home-manager = home-manager-unstable;
          nixpkgs = nixpkgs-unstable;
        };
        modules = [
          ./hosts/nixos/tartarus/default.nix
        ];
      };
      aether = mkNixosConfig {
        system = "x86_64-linux";
        hostname = "aether";
        username = "hermes";
        nixpkgs = nixpkgs-stable;
        hmInputs = {
          home-manager = home-manager-stable;
          nixpkgs = nixpkgs-stable;
        };
        modules = [
          ./hosts/nixos/aether/default.nix
        ];
      };
    };
    darwinConfigurations = {
      macbook = mkDarwinConfig {
        system = "aarch64-darwin";
        username = "apollo";
        nixpkgs = nixpkgs-unstable;
        hmInputs = {
          home-manager = home-manager-unstable;
          nixpkgs = nixpkgs-unstable;
        };
        modules = [
          ./hosts/darwin/configuration.nix
        ];
      };
    };
  };

}
