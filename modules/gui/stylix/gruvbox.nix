{ pkgs, ... }:
let
  gruvboxWallpaper = builtins.path {
    path = ../../../home/dotfiles/wallpapers/gruvbox.jpg;
  };
in
{
  stylix = {
    enable = true;
    autoEnable = true;
    image = gruvboxWallpaper;
    imageScalingMode = "fill";
    polarity = "dark";

    cursor = {
      package = pkgs.vanilla-dmz;
      name = "Vanilla-DMZ";
      size = 12;
    };

    fonts = {
      monospace = {
        package = pkgs.jetbrains-mono;
        name = "JetBrainsMono Nerd Font Mono";
      };
      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "Dejavu Sans";
      };
      serif = {
        package = pkgs.dejavu_fonts;
        name = "Dejavu Serif";
      };
      sizes = {
        applications = 10;
        desktop = 10;
        popups = 10;
        terminal = 12;
      };
    };

    opacity = {
      applications = 1.0;
      terminal = 0.8;
      desktop = 1.0;
      popups = 1.0;
    };

    targets = {
      qt.enable = true;
      gtk.enable = true;
    };
  };
}
