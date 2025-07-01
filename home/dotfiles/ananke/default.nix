{
  pkgs,
  config,
  ...
}: {
    # wallpaper, binary file
  home.file.".xinitrc".source = ./xinitrc;
}
