{ pkgs, config, ... }: {

  # Wallpaper Binary File
  home.file.".config/sway/moon.jpg".source = ../wallpapers/moon.jpg;
  home.file.".config/sway/config".source = ./config;
  home.file.".config/wlogout/layout".source = ./wlogout/layout;
  home.file.".config/wlogout/style.css".source = ./wlogout/style.css;
  home.file.".config/waybar/config".source = ./waybar/config;
  home.file.".config/waybar/style.css".source = ./waybar/style.css;
  home.file.".config/swaync/config.json".source = ./swaync/config.jsonc;
  home.file.".config/swaync/style.css".source = ./swaync/style.css;
}
