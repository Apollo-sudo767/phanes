{ config, ... }: let
  d = config.xdg.dataHome;
  c = config.xdg.configHome;
  cache = config.xdg.cacheHome;
in {
  imports = [
    ./common.nix
    ./starship.nix
    ./terminals.nix
  ];

  # Add environment variables
  home.sessionVariables = {
    # Clean up ~
    LESSHISTFILE = cache + "/less/history";
    LESSKEY = c + "/less/lesskey";
    WINEPREFIX = d + "/wine";

    # Set default applications
    EDITOR = "helix";
    BROWSER = "firefox";
    TERMINAL = "ghostty";

    # Enable scrolling in git diff
    DELTA_PAGER = "less -R";

    MANPAGER = "sh -c 'col -bx | bat -l man -p'";
  };

  }

