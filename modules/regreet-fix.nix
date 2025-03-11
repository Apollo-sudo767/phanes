# modules/regreet-fix.nix
{ lib, ... }:

{
  # Define all potentially missing options for regreet
  options.programs.regreet = {
    enable = lib.mkEnableOption "regreet";
    
    # Individual options
    cursorTheme = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "Cursor theme for ReGreet";
    };
    
    font = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "Font for ReGreet";
    };
    
    theme = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "Theme for ReGreet";
    };
    
    # Container for other settings
    settings = lib.mkOption {
      type = lib.types.attrsOf lib.types.anything;
      default = {};
      description = "Settings for ReGreet";
    };
  };
  
  # Set default values to prevent errors
  config.programs.regreet = {
    enable = lib.mkDefault false;
    cursorTheme = null;
    font = null;
    theme = null;
    settings = {};
  };
}
