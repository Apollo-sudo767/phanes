{ config, pkgs, ... }:

{
  # X11 setup with startx and auto-login
  services.xserver.enable = true;
  services.xserver.displayManager.startx.enable = true;
  services.getty = {
    autologinUser = "aphrodite";
  };

  # Audio
  services.pipewire = {
    audio.enable = true;
    wireplumber.enable = true;
  };
  
  environment.systemPackages = with pkgs; [
    steam
    xorg.xinit
    xterm
  ];
  

  # Steam and dependencies
  programs.steam.enable = true;
  hardware.graphics.enable = true;
  services.blueman.enable = true;
  hardware.bluetooth.enable = true;

  # Allow unfree (for Steam and possibly GPU drivers)
  nixpkgs.config.allowUnfree = true;

  # Networking
  networking.networkmanager.enable = true;
  systemd.network.wait-online.enable = false;

}

