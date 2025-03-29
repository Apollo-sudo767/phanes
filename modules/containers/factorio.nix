{ config, pkgs, lib, inputs, ... }:
{
  nixpkgs.config.allowUnfree = true; # Ensure unfree is enabled globally

  nixpkgs.overlays = [
    (final: prev: {
      factorio-headless = prev.factorio-headless.override {
        meta = prev.factorio-headless.meta // { license = lib.licenses.unfree; };
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
