{ pkgs, ... }:

{
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        # This triggers when you run 'loginctl lock-session'
        lock_cmd = "swaylock"; 
        before_sleep_cmd = "loginctl lock-session";
      };

      listener = [
        {
          timeout = 300; # 5 minutes
          on-timeout = "loginctl lock-session";
        }
        {
          timeout = 600; # 10 minutes
          on-timeout = "niri msg action power-off-monitors";
          on-resume = "niri msg action power-on-monitors";
        }
      ];
    };
  };
}
