{pkgs, inputs, quickshell, ... }:

{
  # environment.systemPackages = [inputs.ashell.defaultPackage.${pkgs.system}];
  # or home.packages = ...

  environment.systemPackages = [ 
    quickshell.packages.${pkgs.system}.default 
    inputs.ashell.defaultPackage.${pkgs.system}
  ];
}
