# Home configuration for apollo
{ inputs, lib, pkgs, nixvim, self, ... }:

{
  imports = [
    nixvim.homeManagerModules.nixvim
    # File Imports
    # ./nixvim/default.nix
    #./terminals/default.nix
    ./handheld/default.nix
    ./dotfiles/ghostty/default.nix
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "aphrodite";
  home.homeDirectory = lib.mkDefault (
    if pkgs.stdenv.isDarwin then "/Users/aphrodite" else "/home/aphrodite"
  );

  # Git configuration
  programs.git = {
    enable = false;
  };

  # Enable home-manager
  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  # systemd.user.startServices = "sd-switch";
  
  gtk = {
    enable = true;
    cursorTheme = {
      package = pkgs.vanilla-dmz;
      name = "Vanilla-DMZ";
    };
  };

  # Home Manager state version
  home.stateVersion = "25.11";
}
