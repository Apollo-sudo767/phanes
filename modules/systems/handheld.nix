{ config, pkgs, lib, username, ... }:

{

  ### SteamOS Section

  # Enable auto-login
  
  services = {
    getty.autologinUser = "steam";
    xserver = {
      enable = true;
      displayManager.startx.enable = true;
    };
  }; 

  users.users.steam = {
    isNormalUser = true;
    extraGroups = [ "video" "audio" "input" ];
    packages = with pkgs; [ steam ];
  };

  ### End of SteamOS Section



  # Trusted users
  nix.settings.trusted-users = [username];

  # Xbox controller support
  hardware = {
    xone.enable = true;
    xpadneo.enable = true;
  };

  # Programs
  programs = {
    gamescope = {
      enable = true;
      capSysNice = true;
    };
    steam = {
      enable = true;
      gamescopeSession.enable = true;
    };
    dconf.enable = true;
    firefox.enable = true;
  };
 

  environment.systemPackages = with pkgs; [
    xfce.thunar
    blueman
    mangohud
    bluez
    pamixer
    playerctl
  ];

  # Home Manager
  home-manager.backupFileExtension = "backup";

  # Bluetooth
  hardware.bluetooth.enable = true;
  
  # Power profiles and policy kit
  # services.power-profiles-daemon.enable = true; # Battery Daemon replaced by TLP
  security.polkit.enable = true;
  
  # XDG Portal
  xdg.portal = {
    enable = true;
    config.common.defaukt = "*";
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
    ];
  };

  # Services
  services.dbus.packages = [pkgs.gcr];
  services.geoclue2.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  services.flatpak.enable = true;
}
