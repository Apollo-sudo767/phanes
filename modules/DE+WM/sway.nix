{ pkgs, ... }: {
  imports = [
    ./stylix/moon.nix
  ]; 
  programs = {
    sway = {
      enable = true;
      wrapperFeatures.gtk = true;
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
    wl-clipboard
    swayidle
    swaylock-effects
    swaybg
    swaynotificationcenter
    swaylock-effects
    grim
    slurp
    wf-recorder
    kanshi  # for automatic display profiles
    xdg-desktop-portal
    xdg-user-dirs
    xdg-desktop-portal-wlr
    adwaita-icon-theme
    gnome-themes-extra
    waypipe
  ];
  
  xdg = {
    autostart.enable = true;
    portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal-wlr
      ];
    };
  };
}
