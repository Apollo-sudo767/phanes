{pkgs, ...}: {

  # Stylix
  imports = [
    ./stylix/gruvbox.nix
    ./gdm.nix
  ];

  xdg = {
    autostart.enable = true;
    portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gnome
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal-wlr
        pkgs.xdg-desktop-portal
      ];
      config.common.default = [ "gnome" ];
    };
  };

  programs = {
   niri.enable = true;
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
    swaybg
    hypridle
    swaylock
    xdg-desktop-portal-gtk
    xdg-desktop-portal-gnome
    xdg-desktop-portal-wlr
    xdg-desktop-portal
   ];
}
