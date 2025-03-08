# Configuration for MacBook
{ lib, config, pkgs, inputs, outputs, ... }:

{
  # Define hostname
  networking.hostName = "macbook";

  # MacBook-specific packages
  environment.systemPackages = with pkgs; [
    alacritty
    firefox
  ];

  # MacBook-specific settings
  system.defaults = {
    # Additional MacBook-specific settings can go here
    trackpad = {
      Clicking = true;
      TrackpadRightClick = true;
    };
    NSGlobalDomain = {
      "com.apple.swipescrolldirection" = false; # Natural scrolling
    };
  };

  # User configuration
  users.users.apollo = {
    home = "/Users/apollo";
    shell = pkgs.zsh;
  };
}
