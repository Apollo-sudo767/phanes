{ config, pkgs, lib, inputs, ... }:
{
  nixpkgs.overlays = [
    (final: prev: {
      factorio-headless = inputs.unstable.legacyPackages.${prev.system}.factorio-headless.override {
        # Potential overrides — e.g., add default mods or tweak versions
      };
    })
  ];

  services.factorio = {
    enable = true;
    package = pkgs.factorio-headless;
    openFirewall = true;
    settings = {
      name = "Phastorio";
      description = "A modded Space Age server!";
      visibility = { public = true; };
      requireUserVerification = false;
    };
    autosave-interval = 10;
    saveName = "space-age-save";
  };
}
