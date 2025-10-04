{ pkgs, ... }:
let
  # This uses a special Nix function to get the path to the file you want,
  # relative to the file where the stylix config is being read from.
  # This path is: go 3 levels up (to the flake root) and then down to the image.
  gruvboxWallpaper = builtins.path {
    path = ../../../home/dotfiles/wallpapers/gruvbox.jpg;
  };
in

 {
   stylix = {
    enable = true;
    autoEnable = true;
    cursor = {
      package = pkgs.vanilla-dmz;
      name = "Vanilla-DMZ";
      size = 12;
    };

    image = gruvboxWallpaper;
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
    polarity = "dark";
    targets = {
      qt.enable = true;
      gtk.enable = true;
    };
  };
}
