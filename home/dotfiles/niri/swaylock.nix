{ pkgs, ... }:

{
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects; # Use effects for better visuals if desired
    settings = {
      image = "/home/apollo/.config/wallpapers/niri.jpg";
      font = "JetBrainsMono Nerd Font";
      font-size = 24;
      indicator-radius = 100;
      indicator-thickness = 7;
      
      # Gruvbox Colors
      color = "1d2021";
      ring-color = "fe8019";
      key-hl-color = "fabd2f";
      text-color = "fbf1c7";
      line-color = "00000000";
      inside-color = "1d2021";
      separator-color = "00000000";
    };
  };
}
