{
  pkgs,
  config,
  ...
}: {
    # wallpaper, binary file
  home.file.".config/ghostty/config".source = ./ghostty;
  #home.file.".config/helix/themes/cold_night.toml".source = ./cold_night.toml;
  home.file.".config/helix/config.toml".source = ./helix;

}
