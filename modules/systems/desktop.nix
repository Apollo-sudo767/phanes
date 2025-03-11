{ pkgs, lib, username, ... }:

{
  # Trusted users
  nix.settings.trusted-users = [username];

  # Printing
  services.printing = {
    enable = true;
    drivers = [ pkgs.hplipWithPlugin ];
  };
  
  # GDM
  services.xserver.displayManager.gdm = true;

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
  
  # Sound
  services.pulseaudio.enable = false;

  # Power profiles and policy kit
  # services.power-profiles-daemon.enable = true; # Battery Daemon replaced by TLP
  security.polkit.enable = true;
   
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
