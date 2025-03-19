{pkgs, ...}: {
  
    # Stylix
  imports = [
    ./stylix/moon.nix
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
    waybar = {
      enable = true;
      package = pkgs.waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      });
    };
        
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
  ];

}
