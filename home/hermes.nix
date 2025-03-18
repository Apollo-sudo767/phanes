# Home configuration for apollo
{ inputs, outputs, lib, config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "hermes";
  home.homeDirectory = lib.mkDefault (
    if pkgs.stdenv.isDarwin then "/Users/hermes" else "/home/hermes"
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

  # Enable home-manager
  programs.home-manager.enable = true;
  
  home-manager.users.apollo = {
    programs.nixvim = {
      enable = true;
      autoCmd = [
        {
          event = [ "FileType" ];
          callback = "SetCFileTypeSettings()";
        }
      ];
    };
  };
  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # Home Manager state version
  home.stateVersion = "24.11";
}
