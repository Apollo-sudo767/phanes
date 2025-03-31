{ config, lib, pkgs, ... } : {
  systemd.services.joker-ddns = {
    description = "Update Joker.com Dynamic DNS";
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = ''
        /run/current-system/sw/bin/curl -u 'your-joker-ddns-username:your-ddns-password' \
        "https://svc.joker.com/nic/update?hostname=yourdomain.com"
      '';
    };
  };

  systemd.timers.joker-ddns = {
    description = "Run Joker DDNS Update Every 5 Minutes";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnBootSec = "5min";
      OnUnitActiveSec = "5min";
      Persistent = true;
    };
  };
}
