{ config, pkgs, lib, username, ... }:

{
  # Trusted users
  nix.settings.trusted-users = [username];

  # Printing
  services.printing = {
    enable = true;
    # drivers = [ pkgs.hplipWithPlugin ];
  };
  
  # GDM
  services.xserver.displayManager.gdm.enable = true;

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
    mesa
    protontricks
    vlc
    openrgb
    ncspot
    spotify
    mumble
    davinci-resolve
    
    # Style Packages
    cbonsai
    cmatrix
    pipes
    asciiquarium
  ];

  # Home Manager
  home-manager.backupFileExtension = "backup";

  # Kitty Config
  environment.etc."kitty/kitty.conf".text = ''
    background_opacity 0.8
    '';

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
