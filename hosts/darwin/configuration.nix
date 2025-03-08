# Common macOS configuration
{ lib, config, pkgs, inputs, outputs, ... }:

{
  # macOS-specific settings
  system = {
    defaults = {
      NSGlobalDomain = {
        AppleShowAllExtensions = true;
        AppleShowScrollBars = "Always";
        NSNavPanelExpandedStateForSaveMode = true;
        NSNavPanelExpandedStateForSaveMode2 = true;
      };
      dock = {
        autohide = true;
        show-recents = false;
        minimize-to-application = true;
      };
      finder = {
        AppleShowAllExtensions = true;
        FXEnableExtensionChangeWarning = false;
        CreateDesktop = true;
      };
    };
  };

  # Enable flakes and nix-command
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # List of common packages for all macOS systems
  environment.systemPackages = with pkgs; [
    vim
    git
    curl
    wget
    tmux
    htop
    coreutils
    findutils
    gnugrep
  ];

  # macOS system state version
  system.stateVersion = 4;
}
