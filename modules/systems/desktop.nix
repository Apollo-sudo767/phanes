{ config, pkgs, lib, username, ... }:

{
  # Trusted users
  nix.settings.trusted-users = [username];

  # Printing
  services.printing = {
    enable = true;
    # drivers = [ pkgs.hplipWithPlugin ];
  };

  # DM will be on a per WM/DE basis
  # 
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
 
  # Fix Nix Error?

  # System packages
  environment.systemPackages = with pkgs; [
    xfce.thunar
    blueman
    mangohud
    bluez
    pamixer
    playerctl
    gh
    cmus
    gzip
    vulkan-tools
    protontricks
    vlc
    openrgb
    ncspot
    spotify
    mumble
    davinci-resolve
    ghostty

    # Style Packages
    cbonsai
    cmatrix
    pipes
    asciiquarium
    cava
    vitetris
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
