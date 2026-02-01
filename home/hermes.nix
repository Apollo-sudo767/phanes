# Home configuration for apollo
{ inputs, lib, pkgs, nixvim, self, ... }:

{
  imports = [
    #Nixvim
    #nixvim.homeManagerModules.nixvim
    #./terminals/default.nix
    ./programs/default.nix
    ./dotfiles/cli/default.nix
    ./dotfiles/wallpapers/default.nix
    ./dotfiles/niri/default.nix
    # ./nixvim/default.nix
  ];
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "hermes";
  home.homeDirectory = lib.mkDefault (
    if pkgs.stdenv.isDarwin then "/Users/hermes" else "/home/hermes"
  );

  # Git configuration
  programs.git = {
    enable = true;
  };

  # Enable home-manager
  programs.home-manager.enable = true;
  
  # Nicely reload system units when changing configs
  #  systemd.user.startServices = "sd-switch";

  # Home Manager state version
  home.stateVersion = "25.11";
}
