{
  description = "Apollo's NixOS, Darwin, and Home Manager configurations";

  inputs = {
    # Core nixpkgs channels
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.05";

    # Home Manager channels
    home-manager-unstable.url = "github:nix-community/home-manager/master";
    home-manager-stable.url = "github:nix-community/home-manager/release-25.05";

    # Stylix themes
    stylix-stable.url = "github:danth/stylix/release-25.05";
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

    # macOS support
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = { self, nixpkgs-unstable, nixpkgs-stable, home-manager-unstable, home-manager-stable, stylix-stable, stylix-unstable, nix-minecraft, nixvim-stable, nixvim-unstable, darwin, ... }@inputs:
  let
    getNixvim = hmInputs: if hmInputs.home-manager == home-manager-stable then nixvim-stable else nixvim-unstable;

    mkNixosConfig = { system, hostname, username, nixpkgs, hmInputs, extraModules ? [], overlays ? [] }:
      nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/nixos/configuration.nix
          hmInputs.home-manager.nixosModules.home-manager
          {
            home-manager.users.${username} = import ./home/${username}.nix {
              pkgs = nixpkgs.legacyPackages.${system};
              lib = nixpkgs.lib;
              inherit nixpkgs self system inputs;
              nixvim = getNixvim hmInputs;
            };
            home-manager.useGlobalPkgs = false;
	    home-manager.useUserPackages = true;
	    home-manager.backupFileExtension = "backup";
            home-manager.extraSpecialArgs = {
              inherit self inputs;
              nixvim = getNixvim hmInputs;
            };
          }
          ./hosts/nixos/${hostname}/default.nix
          ./hosts/nixos/${hostname}/hardware-configuration.nix
        ] ++ extraModules;
        specialArgs = {
          inherit username self nixpkgs system inputs;
          nixvim = getNixvim hmInputs;
        };
      };

    mkDarwinConfig = { system, username, nixpkgs, hmInputs, extraModules ? [] }:
      darwin.lib.darwinSystem {
        inherit system;
        modules = [
          hmInputs.home-manager.darwinModules.home-manager
          {
            home-manager.users.${username} = import ./home/${username}.nix {
              pkgs = nixpkgs.legacyPackages.${system};
              lib = nixpkgs.lib;
              inherit nixpkgs self system inputs;
              nixvim = getNixvim hmInputs;
            };
            home-manager.useGlobalPkgs = true;
            home-manager.extraSpecialArgs = {
              inherit self inputs;
              nixvim = getNixvim hmInputs;
            };
          }
          ./hosts/darwin/macbook/default.nix
          ./hosts/darwin/configuration.nix
        ] ++ extraModules;
        specialArgs = {
          inherit username self nixpkgs system inputs;
          nixvim = getNixvim hmInputs;
        };
      };

    mkHomeConfig = { username, system, nixpkgs, hmInput, stylixInput ? null }:
      hmInput.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        extraSpecialArgs = {
          inherit self inputs;
          nixvim = getNixvim { home-manager = hmInput; };
        };
          modules = (if stylixInput != null then [ stylixInput.homeManagerModules.stylix ] else []) ++ 
            [
          (import ./home/${username}.nix {
            pkgs = nixpkgs.legacyPackages.${system};
            lib = nixpkgs.lib;
            inherit nixpkgs self system inputs;
            nixvim = getNixvim { home-manager = hmInput; };
          })
        ];
      };

  in {
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
        extraModules = [
          stylix-unstable.nixosModules.stylix
        ];
        overlays = [];
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
        extraModules = [
          stylix-unstable.nixosModules.stylix
        ];
        overlays = [];
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
          # Stylix stable could be added if needed
        overlays = [
          (final: prev: {
            factorio-server-headless = nixpkgs-unstable.legacyPackages.x86-64-linux.factorio-headless;
            })
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
      };
    };

    homeConfigurations = {
      apollo = mkHomeConfig {
        username = "apollo";
        system = "x86_64-linux";
        nixpkgs = nixpkgs-unstable;
        hmInput = home-manager-unstable;
        stylixInput = stylix-unstable;
        overlays = [ inputs.hyprpanel.overlay ];
      };

      aries = mkHomeConfig {
        username = "aries";
        system = "x86_64-linux";
        nixpkgs = nixpkgs-unstable;
        hmInput = home-manager-unstable;
        stylixInput = stylix-unstable;
      };

      hermes = mkHomeConfig {
        username = "hermes";
        system = "x86_64-linux";
        nixpkgs = nixpkgs-stable;
        hmInput = home-manager-stable;
        stylixInput = stylix-stable;
      };
    };
  };
}
