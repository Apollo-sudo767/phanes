{ pkgs, ... }:
let
  limineBackground = builtins.path {
    path = ../../../home/dotfiles/wallpapers/boot.png;
  };
in
{
  stylix.targets = {
    limine.enable = false;
    plymouth = {
      enable = true;
      logoAnimated = true;
      logo = "${pkgs.nixos-icons}/share/icons/hicolor/48x48/apps/nix-snowflake-white.png";
    };
  };

  boot = {
    plymouth.enable = true;
    loader.limine = {
      enable = true; # Ensure this is true if using Limine
      style = {
        wallpapers = [ limineBackground ];
      };
    };
  };
}
