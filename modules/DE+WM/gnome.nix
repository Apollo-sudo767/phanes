{ config, lib, pkgs, ... }:

{
  # Stylix
  imports = [
    ./stylix/nebula.nix
  ];

  # Enable GNOME without a display manager
  services.xserver = {
    enable = true;
    desktopManager.gnome.enable = true; # Only GNOME itself
  };

  # Use Wayland by default
  environment.sessionVariables.XDG_SESSION_TYPE = "wayland";
}
