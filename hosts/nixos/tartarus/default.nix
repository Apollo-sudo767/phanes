# Common NixOS configuration shared by all machines
{ lib, config, pkgs, inputs, outputs, ... }:

{
  # Import your hardware configuration but we'll handle this per-host
  # imports = [ ./hardware-configuration.nix ];

  # Bootloader and kernel
  boot = {
    # Use latest kernel
    kernelPackages = pkgs.linuxPackages_latest;
    
    # Boot loader configuration (from your original config)
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  # Networking basics - host-specific configs will be in their respective directories
  networking = {
    networkmanager.enable = true;
  };

  # Time zone and locale settings from your original config
  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.UTF-8";
  
  # Console keymap
  console.keyMap = "us";

  # Common system packages for all machines
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    htop
    pciutils
    usbutils
    curl
    tmux
    fastfetch
  ];

  # Enable sound with pipewire (from your original config)
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Common user settings - specific users will be defined per host
  users.users = {
    aries = {
      isNormalUser = true;
      description = "Aries";
      extraGroups = [ "networkmanager" "wheel" ];
    };
  };

  # Enable SSH service
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = true;
    };
  };

   # Enable networking
  networking.networkmanager.enable = true;

  # Nix daemon settings
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
  };

  # Don't require password for sudo
  security.sudo.wheelNeedsPassword = true;

  # System state version
  system.stateVersion = "24.11";
}
