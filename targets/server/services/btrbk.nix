{ ... }:
{
  services.btrbk.instances."btrbk" = {
    onCalendar = "hourly";
    settings = {
      snapshot_preserve_min = "latest";
      snapshot_preserve     = "24h 7d 52w";
      target_preserve_min   = "latest";
      target_preserve       = "24h 7d 52w";
      stream_compress       = "zstd";

      volume."/mnt/btrfs-root" = {
        snapshot_dir = ".snapshots";
        subvolume = {
          "@"     = { target = "/data/nix-backup"; };
          "@home" = { target = "/data/nix-backup"; };
          "@srv" = { target = "/data/nix-backup"; };
        };
      };
    };
  };
}
