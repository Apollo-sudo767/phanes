{pkgs, ...}: {

  # Stylix
  imports = [
    ./stylix/breeze.nix
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

  programs.uwsm = {
    enable = true;
    waylandCompositors.niri = {
      binPath = "${pkgs.niri}/bin/niri";
      prettyName = "Niri";
      comment = "Niri compositor session via UWSM";
    };
  };

  # Disable if not swaylock startup
  #services = {
  #  getty = {
  #    autoLogin = {
  #      enable = true;
  #      user = config.users.users.${username}.name;
  #    };
  #  };
  #};

  # Automatic Launch on tty1

  environment.shellInit = ''
      if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
         exec uwsm niri
      fi
  '';
  
  environment.systemPackages = with pkgs; [
    fuzzel
    mako
    swaybg
    hypridle
    swaylock
    xwayland-satellite
    xdg-desktop-portal-gtk
    xdg-desktop-portal-gnome
    xdg-desktop-portal-wlr
    xdg-desktop-portal
  ];
}
