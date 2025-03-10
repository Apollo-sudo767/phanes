{ config, lib, pkgs, ... }:

{
  # Enable GNOME without a display manager
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = false;  # No display manager
    desktopManager.gnome.enable = true; # Only GNOME itself
  };

  # Use Wayland by default
  environment.sessionVariables.XDG_SESSION_TYPE = "wayland";
}
