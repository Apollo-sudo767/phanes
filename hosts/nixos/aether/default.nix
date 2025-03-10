# Configuration for server (aether)
{ lib, config, pkgs, inputs, outputs, ... }:

{
  imports = [
    # Include hardware configuration when available
    # ./hardware-configuration.nix
  ];

  # Define hostname
  networking.hostName = "aether";

  # Server-specific packages
  environment.systemPackages = with pkgs; [
    htop
    tmux
    iotop
    iftop
    nethogs
    nmap
  ];

  # Secure SSH configuration
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = true;
    };
  };

  # Networking for server
  networking = {
    networkmanager.enable = true;
    networking.defaultGateway = "192.168.1.254";
    firewall = {
      enable = true;
      allowedTCPPorts = [ 24454 25565 8080 ];
      allowedUDPPorts = [ 24454 25565 8080 ];
    };
  };
  networking.interfaces.enp3s0.ipv4.addresses = [
    {
      address = "192.168.1.170";
      prefixLength = 24;
    }
  ];

  # Server user configuration
  users.users.hermes = {
    isNormalUser = true;
    description = "Hermes";
    extraGroups = [ "wheel" ];
  };

  # System-specific state version
  system.stateVersion = "24.11";
}
