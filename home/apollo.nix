# Home configuration for apollo
{ inputs, lib, pkgs, self, system, nixvim, ... }:

{
  imports = [
    # Nixvim Module
    nixvim.homeModules.nixvim
    # File Imports
    # ./nixvim/default.nix
    ./programs/default.nix
    #./terminals/default.nix
    ./dotfiles/niri/default.nix
    ./dotfiles/cli/default.nix
    # ./dotfiles/rofi/default.nix
    ./dotfiles/wallpapers/default.nix
  ];
  
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "apollo";
  home.homeDirectory = lib.mkDefault (
    if pkgs.stdenv.isDarwin then "/Users/apollo" else "/home/apollo"
  );
  
  # Git configuration
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Apollo-sudo767";
        email = "blured767@gmail.com";
      };
      extraConfig = {
        init.defaultBranch = "main";
        pull.rebase = true;
      };
    };
  };
  
  gtk = {
    enable = true;
    cursorTheme = {
      package = pkgs.vanilla-dmz;
      name = "Vanilla-DMZ";
    };
  };
 
  # Enable home-manager
  programs.home-manager.enable = true;
  
  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # Home Manager state version
  home.stateVersion = "26.05";
}
