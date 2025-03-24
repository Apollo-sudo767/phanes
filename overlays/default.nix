# Default overlay configuration
{ inputs, ... }:

final: prev: {
  # Example overlay - you can customize this based on your needs
  # customPackage = prev.customPackage.override { ... };
  
  # Access to unstable packages
  unstable = inputs.nixpkgs-unstable.legacyPackages.${final.system};
  
  # Global vosk-api override (always available)
  vosk-api = final.callPackage ../pkgs/vosk-api { };

  # Conditional override: only on `aether` system
  factorio-headless = if final.system == "x86_64-linux" && final.hostname == "aether" then
    final.unstable.factorio-headless.override {
      # Add override args here if needed (like custom mods)
      # You can also patch the derivation to include mods in the store.
    }
  else
    prev.factorio-headless;
  
}
