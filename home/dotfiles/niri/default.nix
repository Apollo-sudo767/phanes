{
  pkgs,
  config,
  ...
}: {
    # wallpaper, binary file
  home.file.".config/niri/cold.jpg".source = ./cold.jpg;
  home.file.".config/niri/config.kdl".source = ./config.kdl;
  home.file.".config/fuzzel/fuzzel.ini".source = ./fuzzel.ap;
  home.file.".config/mako/config".source = ./mako.ap;
  home.file.".config/hypr/hypridle.conf".source = ./hypridle.conf;
  home.file.".config/swaylock/config".source = ./swaylock.conf;
  home.file.".config/waybar/config".source = ./waybar/config;
  home.file.".config/waybar/colors.css".source = ./waybar/colors.css;
  home.file.".config/waybar/style.css".source = ./waybar/style.css;
  home.file.".config/niri/scripts" = {
    source = ./scripts;
    # copy the scripts directory recursively
    recursive = true;
    executable = true;  # make all scripts executable
  };


}
