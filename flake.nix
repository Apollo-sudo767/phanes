{
  description = "Apollo's NixOS, Darwin, and Home Manager configurations";

  inputs = {
    # Core nixpkgs channels
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.11";

    # Home Manager channels
    home-manager-unstable.url = "github:nix-community/home-manager/master";
    home-manager-stable.url = "github:nix-community/home-manager/release-24.11";

    # Stylix themes
    stylix-stable.url = "github:danth/stylix/release-24.11";
    stylix-unstable.url = "github:danth/stylix";

    # Extras
    nix-minecraft.url = "github:Infinidoge/nix-minecraft";
    nixvim-stable = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
    nixvim-unstable = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    # macOS
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = { self, nixpkgs-unstable, nixpkgs-stable, home-manager-unstable, home-manager-stable, stylix-stable, stylix-unstable, nix-minecraft, nixvim-stable, nixvim-unstable, darwin, ... }@inputs:
  let
    mkNixosConfig = { system, hostname, username, nixpkgs, hmInputs, nixvim, extraModules ? [] }:
      nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/nixos/configuration.nix
          hmInputs.home-manager.nixosModules.home-manager
          {
            home-manager.users.${username} = import ./home/${username}.nix {
              pkgs = nixpkgs.legacyPackages.${system};
              lib = nixpkgs.lib;
              inherit nixpkgs nixvim self system inputs;
            };
            home-manager.useGlobalPkgs = false;
            home-manager.extraSpecialArgs = {
              inherit nixvim self inputs;
            };
          }
          ./hosts/nixos/${hostname}/default.nix
          ./hosts/nixos/${hostname}/hardware-configuration.nix
        ] ++ extraModules;
        specialArgs = {
          inherit username self nixpkgs system nixvim inputs;
        };
      };

    mkDarwinConfig = { system, username, nixpkgs, hmInputs, nixvim, extraModules ? [] }:
      darwin.lib.darwinSystem {
        inherit system;
        modules = [
          hmInputs.home-manager.darwinModules.home-manager
          {
            home-manager.users.${username} = import ./home/${username}.nix {
              pkgs = nixpkgs.legacyPackages.${system};
              lib = nixpkgs.lib;
              inherit nixpkgs nixvim self system inputs;
            };
            home-manager.useGlobalPkgs = true;
          }
          ./hosts/darwin/macbook/default.nix
          ./hosts/darwin/configuration.nix
        ] ++ extraModules;
        specialArgs = {
          inherit username self nixpkgs system nixvim inputs;
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
        nixvim = nixvim-unstable;
        extraModules = [
          stylix-unstable.nixosModules.stylix
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
        nixvim = nixvim-unstable;
        extraModules = [
          stylix-unstable.nixosModules.stylix
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
        nixvim = nixvim-stable;
        # No stylix for stable by default (unless desired)
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
        nixvim = nixvim-unstable;
        # Add stylix or other modules here if desired
      };
    };

    packages.x86_64-linux = {
      nixvim = nixvim-unstable.packages.x86_64-linux.nixvim;
    };
  };
}
