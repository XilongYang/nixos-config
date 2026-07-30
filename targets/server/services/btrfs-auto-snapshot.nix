{ config, pkgs, lib, ... }:
let
  cfg = config.service.btrfsAutoSnapshot;

  snapshotAges = [
    3600
    7200
    10800
    43200
    86400
    259200
    604800
    2592000
    7776000
    15552000
  ];

  # Shell source lives in files/server/btrfs/btrfs-auto-snapshot.sh; the
  # placeholders below are substituted at build time (pure-Nix, no
  # import-from-derivation).
  snapshotScript = pkgs.writeShellScript "btrfs-auto-snapshot" (
    builtins.replaceStrings
      [ "@snapshotAges@" "@device@" ]
      [ (toString snapshotAges) cfg.device ]
      (builtins.readFile ../../../files/server/btrfs/btrfs-auto-snapshot.sh)
  );
in
{
  options.service.btrfsAutoSnapshot = {
    enable = lib.mkEnableOption "Btrfs automatic snapshots (@ and @home)";

    device = lib.mkOption {
      type = lib.types.str;
      example = "/dev/disk/by-uuid/962628ce-4388-424f-b246-99d1967cd72b";
      description = "Block device path used for snapshot.";
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.services.btrfs-auto-snapshot = {
      description = "Btrfs automatic snapshots (@ and @home)";
      serviceConfig.Type = "oneshot";

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
  };
}
