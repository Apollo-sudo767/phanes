{
  pkgs,
  config,
  ...
}: {
    # wallpaper, binary file
  home.file.".config/niri/cold.jpg".source = ../cold.jpg;
  home.file.".config/niri/config.kdl".source = ../config.kdl;
  home.file.".config/fuzzel/fuzzel.ini".source = ../fuzzel;
  home.file.".config/mako/config".source = ../mako;
  home.file.".config/hypr/space13.png".source = ../wallpapers/space13.png;
  home.file.".config/hypr/hyprland.conf".source = ./hyprland.conf;
  # home.file.".config/hypr/scripts" = {
  #  source = ./scripts;
  #  # copy the scripts directory recursively
  #    recursive = true;
  #    executable = true;  # make all scripts executable
  #};


}
