{ pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    settings = [{
      layer = "top";
      position = "bottom";
      height = 30;
      modules-left = [ "custom/power" "niri/workspaces" "niri/window" ];
      modules-center = [ "custom/branding" "mpris" ];
      modules-right = [ "cpu" "memory" "pulseaudio" "clock" "tray" ];

      "custom/power" = {
        format = "⏻";
        on-click = "systemctl suspend";
        on-click-right = "systemctl poweroff";
        on-click-middle = "systemctl reboot";
        interval = 0;
      };

      "niri/workspaces" = {
        format = "{icon}";
        on-click = "activate";
        sort-by-number = true;
        format-icons = {
          default = "";
          focused = "";
          urgent = "";
        };
      };

      "niri/window" = {
        format = "{title}";
        icon-size = 18;
      };

      "custom/branding" = {
        format = " Apollo - Gruvbox ";
        tooltip = false;
      };

      mpris = {
        format = "|  {player_icon} {artist} - {title}";
        format-paused = "|  {status_icon} <i>{artist} - {title}</i>";
        player-icons = {
          default = "";
          spotify = "";
          ncspot = "";
          vlc = "󰕼";
          cmus = "󰓠";
        };
        status-icons = {
          paused = "";
          playing = "";
        };
        max-length = 60;
        on-click = "playerctl play-pause";
        on-click-right = "playerctl next";
      };

      cpu = { format = "CPU: {usage}%"; interval = 5; };
      memory = { format = "Ram: {}%"; interval = 5; };

      pulseaudio = {
        format = "{icon} {volume}% {format_source}";
        format-source = " {volume}%";
        format-source-muted = "";
        format-icons.default = [ "" "" "" ];
        on-click = "pavucontrol";
      };

      clock = {
        format = "󰥔    {:%H:%M  %A, %B %e}";
        tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
      };

      tray = { icon-size = 16; spacing = 10; };
    }];

    style = ''
      /* Gruvbox Palette Variables */
      @define-color bg0-soft #32302f;
      @define-color bg1 #3c3836;
      @define-color fg0 #fbf1c7;
      @define-color fg1 #ebdbb2;
      @define-color red #cc241d;
      @define-color green #98971a;
      @define-color yellow #d79921;
      @define-color blue #458588;
      @define-color purple #b16286;
      @define-color aqua #689d6a;

      * {
        font-family: "Firacode Nerd Font", monospace;
        border: none;
        border-radius: 0;
        font-size: 10px;
        font-weight: 500;
      }

      window#waybar {
        background-color: @bg0-soft;
        color: @fg1;
        border-bottom: 1px solid #504945;
      }

      #custom-power, #niri-workspaces button, #niri-window, 
      #custom-branding, #mpris, #cpu, #memory, #pulseaudio, #clock, #tray {
        padding: 0 10px;
        background-color: @bg0-soft;
      }

      #custom-power { background-color: @red; color: @fg0; }
      
      #niri-workspaces button.focused { background-color: @blue; color: @fg0; }
      #niri-workspaces button.urgent { background-color: @red; color: @fg0; }

      #niri-window, #custom-branding, #mpris, #cpu, #memory, #pulseaudio {
        background-color: @bg1;
      }

      #niri-window { color: @green; }
      #mpris.playing { color: @green; }
      #mpris.paused { color: @yellow; }
    '';
  };
}
