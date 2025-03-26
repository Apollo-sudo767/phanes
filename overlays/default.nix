# Default overlay configuration
{ inputs, config, pkgs, ... }:
let
  unstablePkgs = import <nixos-unstable/nixpkgs> {
    system = pkgs.system;
  };
in
{
  environment.systemPackages = with pkgs; [
    unstablePkgs.factorio-server-headless
  ];

  # ... your other configuration ...
}
