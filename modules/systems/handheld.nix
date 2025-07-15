{ config, pkgs, ... }:

{
  # X11 setup with startx and auto-login
  services.xserver.enable = true;
  services.xserver.displayManager.startx.enable = true;
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "steam";
  services.displayManager.gdm.enable = true;

  # Disable screen blanking / power saving
  services.xserver.serverFlagsSection = ''
    Option "BlankTime" "0"
    Option "StandbyTime" "0"
    Option "SuspendTime" "0"
    Option "OffTime" "0"
  '';

  # TTY auto-login (correct syntax)
  services.getty.autologinUser = "steam";

  # Create a minimal steam user
  users.users.steam = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "audio" "input" ];
    initialPassword = "steam"; # Change securely after first boot
    createHome = true;
    home = "/home/steam";
    shell = pkgs.bash;
  };

  # Provide .xinitrc that launches Steam Big Picture mode
  environment.etc."skel/.xinitrc".text = ''
    exec ${pkgs.steam}/bin/steam -tenfoot -fullscreen
  '';
  
  # Audio
  services.pipewire = {
    audio.enable = true;
    wireplumber.enable = true;
  };

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

