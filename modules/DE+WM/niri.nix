{pkgs, ...}: {

  # Stylix
  imports = [
    ./stylix/cold.nix
  ];

  xdg = {
    autostart.enable = true;
    portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gnome
        pkgs.xdg-desktop-portal-gtk
      ];
    };
  };

  programs = {
    niri = {
      enable = true;
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

  environment.systemPackages = with pkgs; [
    fuzzel
    mako
    ghostty
    swaybg
    swayidle
    swaylock
    xwayland-satellite
    ghostty
    xdg-desktop-portal-gtk
    xdg-desktop-portal-gnome
    alacritty
  ];
}
