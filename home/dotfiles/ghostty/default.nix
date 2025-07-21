{
  pkgs,
  config,
  ...
}: {
    # wallpaper, binary file
  home.file.".config/ghostty/config".source = ./ghostty;

}
