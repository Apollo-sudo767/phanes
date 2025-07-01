# Common NixOS configuration shared by all machines
{ lib, config, pkgs, inputs, outputs, ... }:

{
  # Import your hardware configuration but we'll handle this per-host
  imports = [
    ../configuration.nix
    ./hardware-configuration.nix
    ../../../modules/systems/handheld.nix
  ];

  # Common user settings - specific users will be defined per host
  users.users = {
    aphrodite = {
      isNormalUser = true;
      group = "aphrodite";
      extraGroups = [ "networkmanager" "wheel" ];
      shell = pkgs.zsh;
    };
  };
  
  users.groups.aphrodite = {};

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

  # System Version
  system.stateVersion = "25.11";
}
