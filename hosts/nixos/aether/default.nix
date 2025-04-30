# Configuration for server (aether)
{ lib, config, pkgs, inputs, outputs, ... }:

{
  imports = [
    ../configuration.nix
    # Include hardware configuration when available
    ./hardware-configuration.nix
    ../../../modules/systems/server.nix
    # ../../../modules/containers/factorio.nix
    ../../../modules/containers/joker.nix
    # ../../../modules/containers/minecraftserver.nix # Finish setting up nix-minecraft
  ];

  # Define hostname
  networking.hostName = "aether";


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
    defaultGateway = "192.168.1.254";
    firewall = {
      enable = true;
      allowedTCPPorts = [ 24454 25565 8080 2456 2457 34197 ];
      allowedUDPPorts = [ 24454 25565 8080 2456 2457 34197 ];
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
    group = "hermes";
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.zsh;
  };

  users.groups.hermes = {};

  # Version
  system.stateVersion = "24.11";

}
