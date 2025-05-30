{ pkgs, inputs, ... }:

{
  environment.systemPackages = [inputs.ashell.defaultPackage.${pkgs.system}];
  # or home.packages = ...
}
