{ pkgs, ... }: {
   stylix = {
    enable = true;
    image = pkgs.fetchurl {
      url = "https://github.com/dharmx/walls/blob/main/cold/a_snowy_landscape_with_trees_and_a_light_on_it.jpg";
      sha256 = "1982qv0kpahixzpm8kr6s70n40lwrpgp83nhqx4s1mcdwlk6j5dl";
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
