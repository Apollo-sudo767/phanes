{ config, pkgs, lib, username, ... }:

{
  # Time zone and locales
  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Printing
  services.printing = {
    enable = true;
    # drivers = [ pkgs.hplipWithPlugin ];
  };

  # Fonts
  fonts = {
    packages = with pkgs;  [
        material-design-icons
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-emoji
      # nerdfonts.jetbrains-mono
      #nerdfonts.fira-code
      # cinzel
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
    dconf.enable = true;
  };
  #Docker
  virtualisation.docker.enable = true;

  # System packages
  environment.systemPackages = with pkgs; [
    nnn
    pamixer
    playerctl
    gh
    gnutar
    gzip
    vulkan-tools
    mesa
    neovim
    vlc
    thunderbird
    ncspot
    waypipe
    xdg-desktop-portal
    xdg-user-dirs
    xdg-desktop-portal-gtk
    docker
    kitty
  ];
  
  # xdg.portal.enable = true;
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

  # programs.kitty.enable = true;
  
  programs.starship = {
    enable = true;
  };

  # LightDM
  services.xserver.displayManager.lightdm.enable = false;
  #services.flatpak.enable = true; # This will stay as a reminder of my mistakes. I DO REPENT
}
