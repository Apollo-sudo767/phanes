{pkgs, ...}: {

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

  environment.etc."uwsm/sessions/niri.desktop".text = ''
    [Desktop Entry]
    Name=Niri
    Comment=Niri Wayland Compositor
    Exec=niri --session
    Type=Application
  '';
      
    
  
}
