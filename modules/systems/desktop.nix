{ config, pkgs, lib, username, inputs, system, ... }:

let
  # The 0xc000022070 flake uses 'extraPolicies' for its overrides
  myZen = inputs.zen-browser.packages."${system}".default.override {
    extraPolicies = {
      DisableTelemetry = true;
      ExtensionSettings = {
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
          installation_mode = "force_installed";
        };
      };
    };
  };
in
{
  # Trusted users
  nix.settings.trusted-users = [username];

  # Printing
  services.printing.enable = true;

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

  # System packages
  environment.systemPackages = with pkgs; [
    # Custom Zen
    myZen

    # Bitwarden Stack
    bitwarden-desktop   # The Desktop GUI
    bitwarden-cli       # Official CLI (bw)
    rbw                 # Better CLI for NixOS (handles sessions nicely)
    pinentry-gnome3     # Required for rbw/bitwarden to ask for passwords

    # File & System
    thunar
    blueman
    mangohud
    bluez
    pamixer
    playerctl
    gh
    gzip
    vulkan-tools
    protontricks
    vlc
    openrgb
    
    # Music & Media
    ncspot
    spotify
    mumble
    davinci-resolve
    ghostty
    kdePackages.okular
    yt-dlp
    tauon
    kew
    spotdl

    # Style Packages
    cbonsai
    cmatrix
    pipes
    asciiquarium
    cava
    vitetris
  ];

  # Bluetooth
  hardware.bluetooth.enable = true;

  # Security & Auth (Required for Bitwarden Biometrics/System Auth)
  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;

  # XDG Portal
  xdg.portal = {
    enable = true;
    # Use lib.mkForce to override the Niri module's default "gnome" value
    config.common.default = lib.mkForce "*"; 
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
  services.udisks2.enable = true;
}
