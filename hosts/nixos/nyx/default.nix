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
    ../../../modules/gui/wm/niri.nix
  ];

  # Bootloader and kernel
  boot.loader.limine.extraConfig = ''
      timeout: 5

      :Windows
        protocl: efi_chainload
        image_path=hdd(1:1):/EFI/Microsoft/Boot/bootmgfw.efi

      :EDK2 UEFI Shell
        protocol: efi_chainload
        image_path: boot://efi/efi/shell.efi
  '';
  
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
        extraGroups = [ "wheel" "networkmanager" "cdrom" "optical" ];
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
        libva-vdpau-driver
        libvdpau-va-gl
        vulkan-loader
        vulkan-headers
        nvidia-vaapi-driver
        mesa
        vulkan-tools
        vulkan-validation-layers        #  pkgsi686Linux.vulkan-loader
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
  system.stateVersion = "26.05";
}
