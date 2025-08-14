# Common NixOS configuration shared by all machines
{ lib, config, pkgs, inputs, outputs, ... }:

{
  # Import your hardware configuration but we'll handle this per-host
  # imports = [ ./hardware-configuration.nix ];
  
  imports = [
    ../configuration.nix
    ./hardware-configuration.nix
    ../../../modules/systems/desktop.nix
    # ../../../modules/DE+WM/hyprland.nix
    ../../../modules/DE+WM/niri.nix
  ];

  # Bootloader and kernel
  boot.loader = {
    efi = {
      efiSysMountPoint = "/boot"; # ← use the same mount point here.
    };
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
  
  # Enable SSH service
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = true;
    };
  };
 
  # User Settings
  users = {
    groups.apollo = {};
    users = {
      apollo ={
        isNormalUser = true;
        group = "apollo";
        extraGroups = [ "wheel" "networkmanager" ];
        shell = pkgs.zsh;
        openssh.authorizedKeys.keys = [
          "SHA256:Ib5d4lKSIShSxgx02cOAsIi+vCeImZoBBMB2Ees3aGc fireshifter767@gmail.com"
        ];
      };
    };
  };

  # Enable networking
  networking.networkmanager.enable = true;
  networking.defaultGateway = "192.168.1.254";
  networking.hostName = "nyx";
  # Hardware + nvidia
  services.xserver.videoDrivers = [ "nvidia" ];
 
  services.hardware.openrgb = { 
    enable = true; 
    package = pkgs.openrgb-with-all-plugins; 
    motherboard = "amd"; 
  };

  hardware = {
    graphics = {
      enable = true;
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

  # System Version
  system.stateVersion = "25.11";
}
