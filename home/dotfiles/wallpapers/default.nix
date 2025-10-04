{
  pkgs,
  config,
  ...
}: {
    # wallpaper, binary file
  home.file.".config/wallpapers/niri.jpg".source = ./gruvbox.jpg;
  #home.file.".config/helix/themes/cold_night.toml".source = ./cold_night.toml;
  home.file.".config/wallpapers/hyprland.jpg".source = ./hypr1.jpg;

}
