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
    hyprland = {
      enable = true;
      xwayland = {
        enable = true;
      };
    };

    #waybar = {
    #  enable = true;
    #  package = pkgs.waybar.overrideAttrs (old: {
    #    mesonFlags = (old.mesonFlags or []) ++ [
    #      "-Dexperimental=true"
    #      "-Dmpd=enabled"
    #      "-Dpulseaudio=enabled"
    #      "-Dmpris=enabled"
    #    ];
    #  });
    #};
  };

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
