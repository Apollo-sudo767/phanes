{ config, pkgs, ... }:

{
  systemd.services.minecraft-backup = {
    description = "Backup Minecraft World";
    script = ''
      set -eu
      BACKUP_DIR="/var/minecraft/backups"
      WORLD_DIR="/var/minecraft/world"
      TIMESTAMP=$(${pkgs.coreutils}/bin/date +"%Y-%m-%d_%H-%M-%S")
      BACKUP_FILE="$BACKUP_DIR/world_backup_$TIMESTAMP.tar.gz"

      ${pkgs.coreutils}/bin/mkdir -p "$BACKUP_DIR"
      ${pkgs.gnutar}/bin/tar -czf "$BACKUP_FILE" -C "$WORLD_DIR" .
      ${pkgs.findutils}/bin/find "$BACKUP_DIR" -type f -mtime +7 -name "*.tar.gz" -exec ${pkgs.coreutils}/bin/rm {} \;
    '';
    serviceConfig = {
      Type = "oneshot";
      User = "minecraft"; # Change this if necessary
    };
  };

  systemd.timers.minecraft-backup = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "*-*-* 00,08,16:00";
      Persistent = true;
      Unit = "minecraft-backup.service";
    };
  };
}
