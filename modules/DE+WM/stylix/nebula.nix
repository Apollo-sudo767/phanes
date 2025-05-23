{ pkgs, ... }: {

  stylix = {
    enable = true;
    image = pkgs.fetchurl {
      url = "https://live.staticflickr.com/65535/52211883799_9642668157_o_d.png";
      sha256 = "5bdc52f583da6dc14c26ac3f00d1e5ff45ae7a1da3820d5abf4076b512e18e76";
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
    targets = {
      qt.enable = true;
    };
  };
}
