{ config, lib, pkgs, ... }:

{
  # Stylix

  # Enable GNOME without a display manager
  services = {
    desktopManager.gnome.enable = true; # Only GNOME itself
  };

  # Use Wayland by default
  environment.sessionVariables.XDG_SESSION_TYPE = "wayland";
}
