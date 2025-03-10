# Common NixOS configuration shared by all machines
{ lib, config, pkgs, inputs, outputs, ... }:

{
  # Import your hardware configuration but we'll handle this per-host
  # imports = [ ./hardware-configuration.nix ];

  # Bootloader and kernel
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot"; # ← use the same mount point here.
    };
    systemd-boot.enable = true;
    systemd-boot.extraFiles."efi/shell.efi" = "${pkgs.edk2-uefi-shell}/shell.efi";
    systemd-boot.extraEntries = {
       # Chainload Windows bootloader via EDK2 Shell
      "windows.conf" =
        let
          # To determine the name of the windows boot drive, boot into edk2 first, then run
          # `map -c` to get drive aliases, and try out running `FS1:`, then `ls EFI` to check
          # which alias corresponds to which EFI partition.
          boot-drive = "FS1";
        in
        ''
          title Windows Bootloader
          efi /efi/shell.efi
          options -nointerrupt -nomap -noversion HD0b:EFI\Microsoft\Boot\Bootmgfw.efi
          sort-key y_windows
        '';
      # Make EDK2 Shell available as a boot option
      "edk2-uefi-shell.conf" = ''
        title EDK2 UEFI Shell
        efi /efi/shell.efi
        sort-key z_edk2
      '';
    };
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
    apollo = {
      isNormalUser = true;
      description = "Apollo";
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
  networking.defaultGateway = "192.168.1.254";

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
  
  # Fix Regreet?
  services.greetd.enable = false;
  services.regreet.enable = false;

  # Don't require password for sudo
  security.sudo.wheelNeedsPassword = true;

    # for Nvidia GPU
  # Hardware
  hardware = {
    opengl = {
      enable = true;
      # driSupport = true;
      # driSupport32Bit = true;
      extraPackages = with pkgs; [
        vaapiVdpau
        libvdpau-va-gl
        vulkan-loader
        vulkan-headers
        nvidia-vaapi-driver
        mesa
        vulkan-tools
        vulkan-validation-layers
        #  pkgsi686Linux.vulkan-loader
      ];
      extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
      # setLdLibraryPath = true;
    };
    nvidia = {
      modesetting.enable = true;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.beta;
      forceFullCompositionPipeline = true;
      powerManagement.enable = true;
    };
  };

  # System state version
  system.stateVersion = "24.11";
}
