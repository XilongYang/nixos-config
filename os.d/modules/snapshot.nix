{ config, pkgs, ... }:

let
  device = "/dev/disk/by-uuid/5b68ea29-4079-4d6c-a3f0-d95c67bae2bc"; 

  snapshotAges = [
    3600        # 1h
    7200        # 2h
    10800       # 3h
    43200       # 12h
    86400       # 24h
    259200      # 72h
    604800      # 7d
    2592000     # 30d
    7776000     # 90d
    15552000    # 180d
  ];

  snapshotScript = pkgs.writeShellScript "btrfs-auto-snapshot" ''
    set -euo pipefail

    ROOT=/mnt/btrfs-root
    SNAPDIR=".snapshots"
    NOW=$(date +%s)

    mkdir -p "$ROOT"
    mount -o subvolid=5 ${device} "$ROOT"
    mkdir -p "$ROOT/$SNAPDIR"

    ts=$(date +"%Y-%m-%dT%H:%M:%S")

    # === 创建只读快照 ===
    btrfs subvolume snapshot -r "$ROOT/@"     "$ROOT/$SNAPDIR/@-$ts"
    btrfs subvolume snapshot -r "$ROOT/@home" "$ROOT/$SNAPDIR/@home-$ts"

    # === 已有快照时间戳列表 ===
    snapshots=$(ls "$ROOT/$SNAPDIR" | grep '^@-' | sed 's/^@-//')

    # === 按时间锚点清理 ===
    for age in ${toString snapshotAges}; do
      target=$((NOW - age))
      candidate=""
      candidate_ts=0

      for s in $snapshots; do
        t=$(date -d "$s" +%s || true)
        if [ "$t" -le "$target" ] && [ "$t" -gt "$candidate_ts" ]; then
          candidate="$s"
          candidate_ts="$t"
        fi
      done

      for s in $snapshots; do
        [ "$s" = "$candidate" ] && continue
        t=$(date -d "$s" +%s || true)
        if [ "$t" -le "$target" ]; then
          btrfs subvolume delete "$ROOT/$SNAPDIR/@-$s"     2>/dev/null || true
          btrfs subvolume delete "$ROOT/$SNAPDIR/@home-$s" 2>/dev/null || true
        fi
      done
    done

    umount "$ROOT"
  '';
in
{
  systemd.services.btrfs-auto-snapshot = {
    description = "Btrfs automatic snapshots (@ and @home)";
    serviceConfig = {
      Type = "oneshot";
    };

    path = with pkgs; [
      btrfs-progs
      coreutils
      util-linux
      gawk
    ];

    script = ''
      exec ${snapshotScript}
    '';
  };

  systemd.timers.btrfs-auto-snapshot = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "hourly";
      Persistent = true;
    };
  };
}

