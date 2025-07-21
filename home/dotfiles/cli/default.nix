{
  pkgs,
  config,
  ...
}: {
    # wallpaper, binary file
  home.file.".config/ghostty/config".source = ./ghostty;
  home.file.".config/helix/themes/dracula.toml".source = ./dracula.toml;
}
