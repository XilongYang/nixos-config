{ config, pkgs, ... }:
let
  sync = pkgs.writeShellScript "sync" ''
    set -euo pipefail

    export RCLONE_CONFIG="$HOME/.config/rclone/rclone.conf"

    # Proton Drive sync: Remote -> Local
    echo "Starting Proton Drive sync"
    ${pkgs.rclone}/bin/rclone sync proton:/Archive "$HOME/Documents/ProtonDrive/Archive" \
      --fast-list --delete-after --checkers=16 --transfers=8
    ${pkgs.rclone}/bin/rclone sync proton:/Ebooks "$HOME/Documents/ProtonDrive/Ebooks" \
      --fast-list --delete-after --checkers=16 --transfers=8
    echo "Complete Proton Drive sync"

    # Encrypting drafts before uploading to Dropbox
    echo "Starting Cleaning old encrypted drafts for Dropbox"
    rm -f $HOME/Documents/Drafts/.dropbox/*.gpg || true
    echo "Complete Cleaning old encrypted drafts for Dropbox"
    echo "Starting Encrypting drafts for Dropbox"
    for file in $(find $HOME/Documents/Drafts -type f); do
      echo "Encrypting $file"
      filename=$(basename "$file")
      ${pkgs.gnupg}/bin/gpg --batch --yes --output "$HOME/Documents/Drafts/.dropbox/$filename.gpg" \
        -r contact@xilong.site -e "$file"
    done
    echo "Complete Encrypting drafts for Dropbox"

    # Dropbox sync: Local -> Remote
    echo "Starting Dropbox sync"
    ${pkgs.rclone}/bin/rclone sync "$HOME/Documents/Drafts/.dropbox" dropbox:/Drafts \
      --fast-list --delete-after --checkers=16 --transfers=8
    echo "Complete Dropbox sync"
  '';
in {
  systemd.user.services."rclone" = {
    Unit = {
      Description = "Rclone sync for Proton Drive & Dropbox";
    };
    
    Service = {
     Type = "oneshot";
     ExecStart = sync; 
    };
  };

  systemd.user.timers."rclone" = {
    Unit = {
      Description = "Timer for Proton Drive sync";
    };
    
    Timer = {
      OnBootSec = "2m";
      OnUnitActiveSec = "15m";
      Persistent = true;
    };
    
    Install = {
      WantedBy = [ "timers.target" ];
    };
  };
}
