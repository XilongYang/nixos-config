set -euo pipefail

ROOT=/mnt/btrfs-root
SNAPDIR=".snapshots"
NOW=$(date +%s)
mounted=0

cleanup() {
  if [ "$mounted" -eq 1 ]; then
    umount "$ROOT" 2>/dev/null || true
  fi
}

list_snapshots() {
  local prefix="$1"
  local entry name

  for entry in "$ROOT/$SNAPDIR"/"$prefix"*; do
    [ -e "$entry" ] || continue
    name=$(basename "$entry")
    printf '%s\n' "${name#"$prefix"}"
  done
}

cleanup_family() {
  local prefix="$1"
  local snapshots age target candidate candidate_ts s t

  for age in @snapshotAges@; do
    snapshots="$(list_snapshots "$prefix")"
    [ -n "$snapshots" ] || return 0

    target=$((NOW - age))
    candidate=""
    candidate_ts=0

    while IFS= read -r s; do
      [ -n "$s" ] || continue
      t=$(date -d "$s" +%s 2>/dev/null || true)
      [ -n "$t" ] || continue

      if [ "$t" -le "$target" ] && [ "$t" -gt "$candidate_ts" ]; then
        candidate="$s"
        candidate_ts="$t"
      fi
    done <<< "$snapshots"

    while IFS= read -r s; do
      [ -n "$s" ] || continue
      [ "$s" = "$candidate" ] && continue

      t=$(date -d "$s" +%s 2>/dev/null || true)
      [ -n "$t" ] || continue

      if [ "$t" -le "$target" ] && [ -e "$ROOT/$SNAPDIR/$prefix$s" ]; then
        btrfs subvolume delete "$ROOT/$SNAPDIR/$prefix$s" 2>/dev/null || true
      fi
    done <<< "$snapshots"
  done
}

trap cleanup EXIT

mkdir -p "$ROOT"
mount -o subvolid=5 @device@ "$ROOT"
mounted=1
mkdir -p "$ROOT/$SNAPDIR"

ts=$(date +"%Y-%m-%dT%H:%M:%S")

btrfs subvolume snapshot -r "$ROOT/@" "$ROOT/$SNAPDIR/@-$ts"
btrfs subvolume snapshot -r "$ROOT/@home" "$ROOT/$SNAPDIR/@home-$ts"

cleanup_family "@-"
cleanup_family "@home-"
