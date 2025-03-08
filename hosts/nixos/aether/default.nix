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

  # Server-specific services
  services = {
    # Example Minecraft server using nix-minecraft
    minecraft-server = {
      enable = true;
      eula = true;
      package = pkgs.minecraftServers.vanilla-1-19;
      openFirewall = true;
      declarative = true;
      serverProperties = {
        server-port = 25565;
        difficulty = 3;
        gamemode = "survival";
        max-players = 10;
        motd = "Aether Minecraft Server";
        white-list = true;
      };
    };

    # Secure SSH configuration
    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
      };
    };
  };

  # Networking for server
  networking = {
    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 25565 ];
    };
  };

  # Server user configuration
  users.users.hermes = {
    isNormalUser = true;
    description = "Hermes";
    extraGroups = [ "wheel" ];
  };

  # System-specific state version
  system.stateVersion = "23.11";
}
