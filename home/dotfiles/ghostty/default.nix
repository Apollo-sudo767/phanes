{
  pkgs,
  config,
  ...
}: {
    # wallpaper, binary file
  home.file.".config/ghostty/config".source = ./ghostty;
  home.file.".config/niri/scripts" = {
    source = ./scripts;
    # copy the scripts directory recursively
    recursive = true;
    executable = true;  # make all scripts executable
  };


}
