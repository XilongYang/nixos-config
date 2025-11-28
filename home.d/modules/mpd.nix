{ config, pkgs, ... }:
{
  systemd.user.services."mpd" = {
    Unit = {
      Description = "Music player daemon";
    };
    
    Service = {
     Type = "simple";
     ExecStart = ''
        ${pkgs.mpd}/bin/mpd --no-daemon
      '';
    };
  };

  xdg.configFile."mpd/mpd.conf".text = ''
    music_directory        "~/Music"
    playlist_directory     "~/.config/mpd/playlists"
    db_file                "~/.local/share/mpd/tag_cache"
    state_file             "~/.local/share/mpd/state"
    sticker_file           "~/.local/share/mpd/sticker.sql"
    pid_file               "~/.cache/mpd/pid"
    
    bind_to_address        "127.0.0.1"
    port                   "6600"
    
    auto_update "yes"
    auto_update_depth "10"
    
    audio_output {
        type    "pulse"
        name    "Pulse Output"
    }
  '';

}
