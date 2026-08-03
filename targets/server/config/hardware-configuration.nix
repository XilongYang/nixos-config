{ lib, ... }:
{
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/962628ce-4388-424f-b246-99d1967cd72b";
    fsType = "btrfs";
    options = [ "subvol=@,compress=zstd,ssd,space_cache=v2,discard=async,noatime" ];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/962628ce-4388-424f-b246-99d1967cd72b";
    fsType = "btrfs";
    options = [ "subvol=@home,compress=zstd,ssd,space_cache=v2,discard=async,noatime" ];
  };

  fileSystems."/home/xilong/.cache" = {
    device = "/dev/disk/by-uuid/962628ce-4388-424f-b246-99d1967cd72b";
    fsType = "btrfs";
    options = [ "subvol=@home_cache,compress=zstd,ssd,space_cache=v2,discard=async,noatime" ];
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/962628ce-4388-424f-b246-99d1967cd72b";
    fsType = "btrfs";
    options = [ "subvol=@nix,compress=zstd,ssd,space_cache=v2,discard=async,noatime" ];
  };

  fileSystems."/var/log" = {
    device = "/dev/disk/by-uuid/962628ce-4388-424f-b246-99d1967cd72b";
    fsType = "btrfs";
    options = [ "subvol=@var_log,compress=zstd,ssd,space_cache=v2,discard=async,noatime" ];
  };

  fileSystems."/var/cache" = {
    device = "/dev/disk/by-uuid/962628ce-4388-424f-b246-99d1967cd72b";
    fsType = "btrfs";
    options = [ "subvol=@var_cache,compress=zstd,ssd,space_cache=v2,discard=async,noatime" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/ADB9-3884";
    fsType = "vfat";
    options = [ "fmask=0022" "dmask=0022" ];
  };

  fileSystems."/mnt/btrfs-root" = {
    device = "/dev/disk/by-uuid/962628ce-4388-424f-b246-99d1967cd72b";
    fsType = "btrfs";
    options = [ "subvolid=5" "noatime" "compress=zstd" ];
  };

  fileSystems."/data/nix-backup" = {
    device = "/dev/disk/by-uuid/9e6ca7b6-5e7c-4a2a-9b22-a1687458f9d6";
    fsType = "btrfs";
    options = [ "noatime" "compress=zstd" ];
  };

  fileSystems."/data/apple/time-machine" = {
    device = "/dev/disk/by-uuid/5e75ea08-8398-4f3f-b353-4d03bea109ec";
    fsType = "ext4";
  };

  swapDevices = [ ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
