# Home configuration for apollo
{ inputs, lib, pkgs, nixvim, self, ... }:

{
  imports = [
    nixvim.homeManagerModules.nixvim
    # File Imports
    # ./nixvim/default.nix
    ./terminals/default.nix
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "aries";
  home.homeDirectory = lib.mkDefault (
    if pkgs.stdenv.isDarwin then "/Users/aries" else "/home/aries"
  );

  # Git configuration
  programs.git = {
    enable = false;
    # userName = "Aries";
    # userEmail = "aries@example.com";  # Replace with your actual email
    # extraConfig = {
    #   init.defaultBranch = "main";
    #   pull.rebase = true;
    # };
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
