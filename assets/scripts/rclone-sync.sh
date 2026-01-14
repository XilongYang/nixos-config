#! /usr/bin/env bash

set -euo pipefail

export RCLONE_CONFIG="$HOME/.config/rclone/rclone.conf"

# Encrypting drafts before uploading to Dropbox

DRAFTS_DIR="$HOME/Documents/Drafts"
DROPBOX_DIR="$DRAFTS_DIR/.dropbox"
RECIPIENT="contact@xilong.site"
GPG="gpg"

echo "Starting incremental encryption for Dropbox"

mkdir -p "$DROPBOX_DIR"

# 1) Orphan cleanup: delete encrypted files whose source no longer exists
echo "Cleaning orphan encrypted files in $DROPBOX_DIR"
find "$DROPBOX_DIR" -type f -name '*.gpg' -print0 |
  while IFS= read -r -d '' enc; do
    rel="${enc#"$DROPBOX_DIR"/}"   # path relative to .dropbox
    src_rel="${rel%.gpg}"         # remove .gpg
    src="$DRAFTS_DIR/$src_rel"

    if [[ ! -f "$src" ]]; then
      echo "Deleting orphan: $enc"
      rm -f -- "$enc"
    fi
  done
echo "Complete cleaning orphan encrypted files"

# 2) Encrypt only when destination is missing or older than source
echo "Encrypting drafts (only when updated)"
find "$DRAFTS_DIR" -type f -name '*.md' -print0 |
  while IFS= read -r -d '' src; do
    rel="${src#"$DRAFTS_DIR"/}"           # relative path inside Drafts
    dest="$DROPBOX_DIR/$rel.gpg"

    # Ensure destination directory exists
    mkdir -p "$(dirname "$dest")"

    # Re-encrypt only if dest missing or older than source
    if [[ ! -f "$dest" || "$src" -nt "$dest" ]]; then
      echo "Encrypting: $src -> $dest"
      "$GPG" --batch --yes --output "$dest" -r "$RECIPIENT" -e "$src"
    fi
  done

echo "Complete incremental encryption for Dropbox"

# Dropbox sync: Local -> Remote
echo "Starting Dropbox sync"
rclone sync "$HOME/Documents/Drafts/.dropbox" dropbox:/Drafts \
  --fast-list --delete-after --checkers=16 --transfers=8
echo "Complete Dropbox sync"

# Proton Drive sync: Remote -> Local
echo "Starting Proton Drive sync"
rclone sync proton:/Archive "$HOME/Documents/ProtonDrive/Archive" \
  --fast-list --delete-after --checkers=16 --transfers=8
rclone sync proton:/Ebooks "$HOME/Documents/ProtonDrive/Ebooks" \
  --fast-list --delete-after --checkers=16 --transfers=8
echo "Complete Proton Drive sync"

