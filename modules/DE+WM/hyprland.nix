{pkgs, ...}: {
  
    # Stylix
  imports = [
    ./stylix/moon.nix
    ./ashell.nix
  ];

  xdg = {
    autostart.enable = true;
    portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal
        pkgs.xdg-desktop-portal-gtk
      ];
    };
  };
  
  programs = {
    uwsm.enable = true;
    hyprland = {
      enable = true;
      withUWSM = true;
      xwayland = {
        enable = true;
      };
    };

    waybar = {
      enable = true;
      package = pkgs.waybar.overrideAttrs (old: {
        mesonFlags = (old.mesonFlags or []) ++ [
          "-Dexperimental=true"
          "-Dmpd=enabled"
          "-Dpulseaudio=enabled"
          "-Dmpris=enabled"
        ];
      });
    };
  };

  # Autologin
  # environment.shellInit = ''
  #  if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
  #    exec uwsm hyprland
  #  fi
  # '';
  
  environment.systemPackages = with pkgs; [
    rofi-wayland
    hyprpicker
    hyprcursor
    hyprlock
    hypridle
    hyprpaper
    grim
    slurp
    xdg-desktop-portal
    xdg-user-dirs
    xdg-desktop-portal-hyprland
    adwaita-icon-theme
    gnome-themes-extra
    waypipe
    mpd
    mpc
    ncmpcpp
    swaynotificationcenter
  ];

}
