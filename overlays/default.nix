# Default overlay configuration
{ inputs, ... }:

final: prev: {
  # Example overlay - you can customize this based on your needs
  # customPackage = prev.customPackage.override { ... };
  
  # Access to unstable packages
  unstable = inputs.nixpkgs-unstable.legacyPackages.${prev.system};
  
  # Example of a package from unstable
  # Use this pattern to get newer versions of packages:
  # firefox = inputs.nixpkgs-unstable.legacyPackages.${prev.system}.firefox;
  # Add this to fix the bemenu module issue
  bemuFixOverlay = final: prev: {
    # This creates a dummy version of the bemenu module
    # that should prevent errors during evaluation
    homeManagerModules = (prev.homeManagerModules or {}) // {
      bemenu = { ... }: { config = {}; options = {}; };
    };
  };
}
