{ config, pkgs, lib, username, ... }:

{
  # Trusted users
  nix.settings.trusted-users = [username];

  # Printing
  services.printing = {
    enable = true;
    drivers = [ pkgs.hplipWithPlugin ];
  };
  
  # GDM
  services.xserver.displayManager.gdm.enable = true;

  # Xbox controller support
  hardware.xone.enable = true;

  # Fonts
  fonts = {
    packages = with pkgs;  [
        material-design-icons
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-emoji
        nerd-fonts.jetbrains-mono
        nerd-fonts.fira-code
        cinzel
      ];
    
    enableDefaultPackages = false;
    fontconfig.defaultFonts = {
      serif = ["Noto Serif" "Noto Color Emoji"];
      sansSerif = ["Noto Sans" "Noto Color Emoji"];
      monospace = ["JetBrainsMono Nerd Font" "Noto Color Emoji"];
      emoji = ["Noto Color Emoji"];
    };
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
  };
 
  # Fix Nix Error?

  # System packages
  environment.systemPackages = with pkgs; [
    xfce.thunar
    nnn
    blueman
    mangohud
    bluez
    pamixer
    playerctl
    gh
    cmus
    gnutar
    gzip
    vulkan-tools
    mesa
    neovim
    protontricks
    libreoffice-qt6-fresh
    vlc
    thunderbird
    ncspot
    spotify
    
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
  
   # Stylix
  stylix = {
    enable = true;
    image = pkgs.fetchurl {
      url = "https://live.staticflickr.com/65535/52211883799_9642668157_o_d.png";
      sha256 = "5bdc52f583da6dc14c26ac3f00d1e5ff45ae7a1da3820d5abf4076b512e18e76";
    };
    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font Mono";

      };
      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "Dejavu Sans";

      };
      serif = {
        package = pkgs.dejavu_fonts;
        name = "Dejavu Serif";
      };
      sizes = {
        applications = 10;
        desktop = 10;
        popups = 10;
        terminal = 12;
      };
    };
    opacity = {
      applications = 1.0;
      terminal = 0.8;
      desktop = 1.0;
      popups = 1.0;
    };
    polarity = "dark";
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
  services.udev.packages = with pkgs; [gnome-settings-daemon];
}
