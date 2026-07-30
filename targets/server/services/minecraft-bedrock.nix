{ pkgs, ... }:
let
  dataDir = "/srv/minecraft";
  backupDir = "/var/backup/minecraft";
  containerName = "minecraft-bedrock";
in
{
  virtualisation.docker.enable = true;

  users.users.minecraft = {
    isSystemUser = true;
    group = "minecraft";
    home = dataDir;
  };
  users.groups.minecraft = {};

  systemd.tmpfiles.rules = [
    "d '${dataDir}'  0750 minecraft minecraft -"
    "d '${backupDir}' 0750 root root -"
  ];

  # Build a local Ubuntu-based image once; re-runs only if image is missing
  systemd.services.minecraft-bedrock-image = {
    description = "Build Minecraft Bedrock server Docker image";
    wantedBy = [ "multi-user.target" ];
    after = [ "docker.service" ];
    requires = [ "docker.service" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      if ! ${pkgs.docker}/bin/docker image inspect bedrock-ubuntu:latest &>/dev/null; then
        ${pkgs.docker}/bin/docker build -t bedrock-ubuntu:latest - < ${../../../files/server/minecraft/bedrock.Dockerfile}
      fi
    '';
  };

  systemd.services.minecraft-bedrock = {
    description = "Minecraft Bedrock Edition Server";
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" "docker.service" "minecraft-bedrock-image.service" ];
    requires = [ "docker.service" "minecraft-bedrock-image.service" ];

    serviceConfig = {
      # Recreate the container only if it doesn't exist or the image has changed
      ExecStartPre = pkgs.writeShellScript "prep-bedrock" ''
        current_image=$(${pkgs.docker}/bin/docker inspect --format='{{.Id}}' bedrock-ubuntu:latest 2>/dev/null)
        container_image=$(${pkgs.docker}/bin/docker inspect --format='{{.Image}}' ${containerName} 2>/dev/null)
        if [ "$container_image" != "$current_image" ]; then
          ${pkgs.docker}/bin/docker rm -f ${containerName} 2>/dev/null || true
          ${pkgs.docker}/bin/docker create \
            --name ${containerName} \
            --network host \
            -v ${dataDir}:${dataDir} \
            bedrock-ubuntu:latest
        fi
      '';
      ExecStart = "${pkgs.docker}/bin/docker start -a ${containerName}";
      ExecStop = "${pkgs.docker}/bin/docker stop ${containerName}";
      Restart = "on-failure";
      RestartSec = "5s";
    };
  };

  systemd.services.minecraft-bedrock-backup = {
    description = "Minecraft Bedrock Server Backup";
    serviceConfig = {
      Type = "oneshot";
    };
    script = ''
      set -e
      trap 'systemctl start minecraft-bedrock.service' EXIT
      systemctl stop minecraft-bedrock.service

      timestamp=$(date +%Y%m%d-%H%M%S)
      ${pkgs.zip}/bin/zip -r "${backupDir}/bedrock-$timestamp.zip" \
        -j ${dataDir}/server.properties \
        -j ${dataDir}/allowlist.json \
        -j ${dataDir}/permissions.json \
        && ${pkgs.zip}/bin/zip -r "${backupDir}/bedrock-$timestamp.zip" \
        ${dataDir}/worlds \
        ${dataDir}/behavior_packs \
        ${dataDir}/resource_packs

      # Keep only the latest 7 backups
      ls -1t ${backupDir}/bedrock-*.zip | tail -n +8 | xargs -r rm --
    '';
  };

  systemd.timers.minecraft-bedrock-backup = {
    description = "Daily Minecraft Bedrock Server Backup at 05:00";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "*-*-* 05:00:00";
      Persistent = true;
    };
  };

  networking.firewall.allowedUDPPorts = [ 19132 19133 ];
}
