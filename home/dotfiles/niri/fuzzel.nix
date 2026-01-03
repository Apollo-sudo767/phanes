{ pkgs, ... }:

{
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        font = "JetBrainsMono Nerd Font:size=16";
        horizontal-padding = 15;
        vertical-padding = 15;
        lines = 15;
        width = 22;
        tabs = 10;
        inner-padding = 10;
        outer-padding = 20;
        notification-timeout = 2000;
        exit-on-keyboard-focus-loss = true;
        layer = "overlay";
      };

      colors = {
        background = "1d1d1dff";
        text = "f0e6d2ff";
        match = "f0e6d2ff";
        selection = "2a2a2aff";
        selection-text = "f0e6d2ff";
        border = "f0e6d2ff";
      };

      border = {
        width = 0;
        radius = 0;
      };
    };
  };
}
