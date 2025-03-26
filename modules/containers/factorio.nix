{ config, pkgs, lib, inputs, ... }:
{
  nixpkgs.overlays = [
    (final: prev: {
      factorio-headless = inputs.nixpkgs-unstable.legacyPackages.${prev.system}.factorio-headless.override {
        # Potential overrides — e.g., add default mods or tweak versions
      };
    })
  ];

  services.factorio = {
    enable = true;
    package = pkgs.factorio-headless;
    openFirewall = true;
    description = "Space Age Server for Phas-Gang";
    public = true;
    game-name = "Phastorio";
    game-password = "Giggity";
    autosave-interval = 10;
    saveName = "space-age-save";
  };
}
