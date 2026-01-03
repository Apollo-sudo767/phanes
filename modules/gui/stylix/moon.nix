{ pkgs, ... }: {
   stylix = {
    enable = true;
    image = pkgs.fetchurl {
      url = "https://w.wallhaven.cc/full/j8/wallhaven-j8y2l5.jpg";
      sha256 = "2472b185dfa4c49ba68c401ab99b6713ee3e1cd4f4327e92ec02301b6f507aac";
    };
    fonts = {
      monospace = {
        package = pkgs.jetbrains-mono;
        name = "JetBrainsMono Nerd Font Mono";
  
      };
      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "Dejavu Sans";
  
      };
      serif = {
        package = pkgs.dejavu_fonts;
        name = "Dejavu Serif";
      };
      sizes = {
        applications = 10;
        desktop = 10;
        popups = 10;
        terminal = 12;
      };
    };
    opacity = {
      applications = 1.0;
      terminal = 0.8;
      desktop = 1.0;
      popups = 1.0;
    };
    polarity = "dark";
    targets.qt.enable = true; 
  };
}
