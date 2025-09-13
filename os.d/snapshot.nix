{ config, pkgs, lib, ... }:
{
  # 每次开机为 @ 和 @home 创建只读快照，并保留最近 7 组
  systemd.services.btrfs-auto-snapshot = {
    description = "Create read-only btrfs snapshots of @ and @home at every boot";
    wantedBy = [ "multi-user.target" ];
    after = [ "local-fs.target" ];
    path = [ pkgs.btrfs-progs pkgs.coreutils pkgs.util-linux pkgs.gnugrep pkgs.gnused ];

    serviceConfig = {
      Type = "oneshot";
      ExecStart = pkgs.writeShellScript "btrfs-auto-snapshot" ''
        set -euo pipefail

        DEVICE="/dev/disk/by-uuid/555335b4-d101-4818-a883-87982802278e"
        TOP="/mnt/btrfs-root"
        SNAP_DIR=".snapshots"
        SNAP_KEEP=7

        mkdir -p "$TOP"
        mount -o subvolid=5 "$DEVICE" "$TOP"

        mkdir -p "$TOP/$SNAP_DIR"
        TS="$(date +%Y-%m-%d_%H-%M-%S)"

        # 创建只读快照（注意这里的 @ 没有空格）
        btrfs subvolume snapshot -r "$TOP/@"     "$TOP/$SNAP_DIR/@-$TS"
        btrfs subvolume snapshot -r "$TOP/@home" "$TOP/$SNAP_DIR/@home-$TS"

        # 清理旧快照：按时间倒序，只保留最近 SNAP_KEEP 组（以 @- 前缀为基准）
        groups="$(ls -1t "$TOP/$SNAP_DIR" | grep -E '^@-[0-9]{4}-[0-9]{2}-[0-9]{2}_[0-9]{2}-[0-9]{2}-[0-9]{2}$' || true)"
        idx=0
        for g in $groups; do
          idx=$((idx+1))
          if [ "$idx" -le "$SNAP_KEEP" ]; then
            continue
          fi

          # 取出时间戳
          ts_old="$(printf '%s' "$g" | sed 's/^@-//')"

          for sub in @ @home; do
            p="$TOP/$SNAP_DIR/$sub-$ts_old"
            if [ -e "$p" ]; then
              btrfs subvolume delete "$p"
            fi
          done
        done

        umount "$TOP"
      '';
    };
  };
}
