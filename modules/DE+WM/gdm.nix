{pkgs, ...}: {

  services.displayManager = {
    gdm.enable = true;
    sessionPackages = with pkgs; [
      niri
    ];
  };
}
