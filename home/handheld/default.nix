{
  pkgs,
  config,
  ...
}: {
    # wallpaper, binary file
  home.file.".xinitrc".source = ./xinitrc;
  home.file.".zprofile".source = ./zprofile;
}
