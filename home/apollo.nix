# Home configuration for apollo
{ inputs, lib, pkgs, self, system, nixvim, ... }:

{
  imports = [
    # Nixvim Module
    nixvim.homeManagerModules.nixvim
    # File Imports
    # ./nixvim/default.nix
    ./programs/default.nix
    #./terminals/default.nix
    ./dotfiles/niri/default.nix
    # ./dotfiles/rofi/default.nix
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
    userName = "Apollo-sudo767";
    userEmail = "blured767@gmail.com";  # Replace with your actual email
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
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
  home.stateVersion = "25.11";
}
