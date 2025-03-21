{
  description = "Apollo's NixOS configuration for multiple machines";

  inputs = {
    # NixOS official package source, stable version
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.11";
    
    # Unstable packages
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Home Manager Stable for managing user configuration
    home-manager-stable = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };

    # Home Manager Unstable
    home-manager-unstable = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    # Stylix for consistent theming
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    # Minecraft server configuration
    nix-minecraft = {
      url = "github:misterio77/nix-minecraft";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    # NixVim for Neovim configuration 
    nixvim = {
      url = "github:nix-community/nixvim/nixos-24.11";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = inputs @ { 
    self, 
    nixpkgs-stable, 
    nixpkgs-unstable, 
    home-manager-stable,
    home-manager-unstable,
    stylix, 
    nix-minecraft, 
    nixvim,
    ... 
  }: 
  let
    inherit (self) outputs;
    
    # Supported systems for your flake packages, shell, etc.
    systems = [
      "x86_64-linux"
      "aarch64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];
    
    # This is a function that generates an attribute by calling a function you
    # pass it, with each system as an argument
    forAllSystems = nixpkgs-stable.lib.genAttrs systems;

    # Overlays to add packages from unstable channel
    overlays = {
      default = import ./overlays { inherit inputs; };
      unstable = final: prev: {
        unstable = nixpkgs-unstable.legacyPackages.${prev.system};
      };
      bemuFix = final: prev: {
        homeManagerModules = (prev.homeManagerModules or {}) // {
          bemenu = { ... }: { config = {}; options = {}; };
        };
      }; 
    };

    # Create nixpkgs config for each system
    mkPkgs = system: nixpkgs: import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      overlays = [
        overlays.default
        overlays.unstable
        overlays.bemuFix
      ];
    };

    # Define pkgs for each system
    pkgsFor = forAllSystems (system: mkPkgs system nixpkgs-stable);
    pkgsUnstableFor = forAllSystems (system: mkPkgs system nixpkgs-unstable);

    # NixOS configuration for different machines
    mkNixosConfig = {
      hostname,
      system ? "x86_64-linux", 
      username ? "apollo",
      stateVersion ? "24.11",
      useUnstable ? false, #Flag for using unstable packages
      useUnstableHomeManager ? false,
    }: let
      pkgs = if useUnstable then pkgsUnstableFor.${system} else pkgsFor.${system};
      homeManagerInput = if useUnstableHomeManager then home-manager-unstable else home-manager-stable;
    in  nixpkgs-stable.lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit inputs outputs hostname username stateVersion;
        pkgs-unstable = pkgsUnstableFor.${system};
      };
      modules = [
        # Default configuration for all machines
        ./hosts/nixos/configuration.nix
        # Machine-specific configuration
        ./hosts/nixos/${hostname}
        # Home manager module
        homeManagerInput.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = {
            inherit inputs outputs hostname username stateVersion;
            pkgs-unstable = pkgsUnstableFor.${system};
          };
          home-manager.users.${username} = import ./home/${username}.nix;
        }
        # Stylix module for system-wide theming
        stylix.nixosModules.stylix
        # NixVim module
        nixvim.nixosModules.nixvim
        # Any additional modules you might need
      ];
    };

    # Darwin configuration for macOS
    mkDarwinConfig = {
      hostname,
      system ? "aarch64-darwin",
      username ? "apollo",
      stateVersion ? "23.11",
    }: nixpkgs-stable.lib.darwinSystem {
      inherit system;
      specialArgs = {
        inherit inputs outputs hostname username stateVersion;
        pkgs-unstable = pkgsUnstableFor.${system};
      };
      modules = [
        # Default configuration for Darwin
        ./hosts/darwin/configuration.nix
        # Machine-specific configuration
        ./hosts/darwin/${hostname}
        # Home manager module
        home-manager-stable.darwinModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = {
            inherit inputs outputs hostname username stateVersion;
            pkgs-unstable = pkgsUnstableFor.${system};
          };
          home-manager.users.${username} = import ./home/${username}.nix;
        }
        # Any additional modules you might need
      ];
    };
  in {
    # Return packages for each system
    packages = forAllSystems (system: import ./pkgs { 
      pkgs = pkgsFor.${system}; 
    });
    
    # Return formatter package for each system
    formatter = forAllSystems (system: pkgsFor.${system}.nixpkgs-fmt);

    # Return dev shells
    devShells = forAllSystems (system:
      let
        pkgs = pkgsFor.${system};
        shell = import ./shell.nix { inherit pkgs; };
      in  {
          default = shell;
      }
    );
    

    # Return overlays
    inherit overlays;

    # NixOS configurations for your machines
    nixosConfigurations = {
      # Desktop - nyx
      nyx = mkNixosConfig {
        hostname = "nyx";
        username = "apollo";
        system = "x86_64-linux";
        useUnstable = true;
        useUnstableHomeManager = true;
      };
      
      # Laptop - tartarus
      tartarus = mkNixosConfig {
        hostname = "tartarus";
        username = "aries";
        system = "x86_64-linux";
        useUnstable = true;
        useUnstableHomeManager = true;
      };
      
      # Server - aether
      aether = mkNixosConfig {
        hostname = "aether";
        username = "hermes";
        system = "x86_64-linux";
      };
    };

    # Darwin (macOS) configuration
    darwinConfigurations = {
      # Macbook
      macbook = mkDarwinConfig {
        hostname = "macbook";
        username = "apollo";
        system = "aarch64-darwin"; # Assuming M1/M2 Mac
      };
    };

    # Home-manager standalone configurations (useful for non-NixOS systems)
    homeConfigurations = {
      "apollo@nyx" = home-manager-unstable.lib.homeManagerConfiguration {
        pkgs = pkgsFor.x86_64-linux;
        extraSpecialArgs = {
          inherit inputs outputs;
          hostname = "nyx";
          username = "apollo";
        };
        modules = [
          ./home/apollo.nix
        ];
      };

      "aries@tartarus" = home-manager-unstable.lib.homeManagerConfiguration {
        pkgs = pkgsFor.x86_64-linux;
        extraSpecialArgs = {
          inherit inputs outputs;
          hostname = "tartarus";
          username = "aries";
        };
        modules = [
          ./home/aries.nix
        ];
      };

      "hermes@aether" = home-manager-stable.lib.homeManagerConfiguration {
        pkgs = pkgsFor.x86_64-linux;
        extraSpecialArgs = {
          inherit inputs outputs;
          hostname = "aether";
          username = "hermes";
        };
        modules = [
          ./home/hermes.nix
        ];
      };

      "apollo@macbook" = home-manager-stable.lib.homeManagerConfiguration {
        pkgs = pkgsFor.aarch64-darwin;
        extraSpecialArgs = {
          inherit inputs outputs;
          hostname = "macbook";
          username = "apollo";
        };
        modules = [
          ./home/apollo.nix
        ];
      };
    };
  };
}
