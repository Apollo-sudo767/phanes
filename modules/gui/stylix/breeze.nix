{ pkgs, ... }: {
   stylix = {
    enable = true;
    autoEnable = true;
    cursor = {
      package = pkgs.vanilla-dmz;
      name = "Vanilla-DMZ";
      size = 12;
    };

    image = pkgs.fetchurl {
      url = "https://4kwallpapers.com/images/wallpapers/lone-tree-crescent-moon-half-moon-starry-sky-night-lake-3840x2160-7701.jpg";
      sha256 = "1chz2hikdjcjk6yvr6jl4x7h6xr9lqd59i0kx3p43rv2fak4q48v";
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
      gtk.enable = true;
    };
  };
}
