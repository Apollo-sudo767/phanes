{ config, pkgs, lib, ... }:

{
  programs.niri.settings = {
    # Input Configuration
    input = {
      keyboard.xkb.layout = "us";
      keyboard.numlock = true;
      touchpad = {
        tap = true;
        natural-scroll = true;
      };
      warp-mouse-to-focus = true;
      focus-follows-mouse.enable = false;
    };

    # Monitor Setup
    outputs."DP-4" = {
      mode = "1920x1080@165";
      scale = 1.0;
      position = { x = 0; y = 0; };
    };
    outputs."DP-5" = {
      mode = "1920x1080@165";
      scale = 1.0;
      position = { x = 1920; y = 0; };
    };

    # Layout & Appearance
    layout = {
      gaps = 0;
      center-focused-column = "never";
      default-column-width.proportion = 0.5;
      
      focus-ring = {
        width = 4;
        active-color = "#FE8019";
        inactive-color = "#505050";
      };
      
      shadow = {
        enable = true;
        softness = 30;
        spread = 5;
        offset = { x = 0; y = 5; };
        color = "#0007";
      };
    };

    # Window Rules
    window-rules = [
      {
        match.app-id = "firefox$";
        match.title = "^Picture-in-Picture$";
        open-floating = true;
      }
      {
        match.app-id = "ghostty$";
        opacity = 0.8;
        draw-border-with-background = false;
      }
      {
        geometry-corner-radius = 0;
        clip-to-geometry = true;
      }
    ];

    # Keybinds
    binds = with config.lib.niri.actions; {
      "Alt+Shift+Slash".action = show-hotkey-overlay;
      "Alt+Q".action = spawn "ghostty";
      "Alt+D".action = spawn "fuzzel";
      "Alt+Shift+Q".action = spawn "firefox";
      "Super+Alt+L".action = spawn "swaylock" "-i" "/home/apollo/.config/wallpapers/niri.jpg";
      
      "Alt+C".action = close-window;
      "Alt+R".action = switch-preset-column-width;
      "Alt+F".action = maximize-column;
      "Alt+Shift+F".action = fullscreen-window;
      "Alt+V".action = toggle-window-floating;

      # Navigation (Vim-style)
      "Alt+H".action = focus-column-left;
      "Alt+J".action = focus-window-down;
      "Alt+K".action = focus-window-up;
      "Alt+L".action = focus-column-right;

      # Workspace Switching (1-9)
      "Alt+1".action = focus-workspace 1;
      "Alt+2".action = focus-workspace 2;
      "Alt+3".action = focus-workspace 3;
      "Alt+4".action = focus-workspace 4;
      "Alt+5".action = focus-workspace 5;
      "Alt+6".action = focus-workspace 6;
      "Alt+7".action = focus-workspace 7;
      "Alt+8".action = focus-workspace 8;
      "Alt+9".action = focus-workspace 9;

      # Multimedia (XF86 Keys)
      "XF86AudioRaiseVolume".action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+";
      "XF86AudioLowerVolume".action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-";
      "XF86AudioMute".action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle";
    };

    # Startup
    spawn-at-startup = [
      { command = [ "swaybg" "-i" "/home/apollo/.config/wallpapers/niri.jpg" ]; }
      { command = [ "waybar" ]; }
      { command = [ "hypridle" ]; }
    ];

    prefer-no-csd = true;
  };
}
