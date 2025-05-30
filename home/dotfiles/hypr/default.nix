{
  pkgs,
  config,
  ...
}: {
    # wallpaper, binary file
  home.file.".config/hypr/hypr1.jpg".source = ../wallpapers/hypr1.jpg;
  home.file.".config/hypr/hypr2.jpg".source = ../wallpapers/hypr2.jpg;
  home.file.".config/hypr/Space.jpg".source = ../wallpapers/moon.jpg;
  home.file.".config/hypr/hyprblur.png".source = ../wallpapers/moon.png;
  home.file.".config/hypr/space13.png".source = ../wallpapers/space13.png;
  home.file.".config/hypr/hyprland.conf".source = ./hyprland.conf;
  home.file.".config/hypr/hyprlock.conf".source = ./hyprlock.conf;
  home.file.".config/hypr/hypridle.conf".source = ./hypridle.conf;
  home.file.".config/waybar/config".source = ./waybar/config;
  home.file.".config/waybar/colors.css".source = ./waybar/colors.css;
  home.file.".config/ashell/config.toml".source = ./ashell.toml;
  # home.file.".config/waybar/gruvbox.css".source = ./waybar/gruvbox.css;
  home.file.".config/waybar/style.css".source = ./waybar/style.css;
  # home.file.".config/waybar/style.css.bac".source = ./waybar/style.css.bac;
  home.file.".config/hypr/hyprpaper.conf".source = ./hyprpaper.conf;
  home.file.".config/hypr/scripts" = {
    source = ./scripts;
    # copy the scripts directory recursively
      recursive = true;
      executable = true;  # make all scripts executable
  };


}
