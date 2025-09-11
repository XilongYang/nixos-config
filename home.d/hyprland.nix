{ config, ... }:
{
  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload   = /home/xilong/Pictures/Wallpaper/railway.jpg
    wallpaper = ,/home/xilong/Pictures/Wallpaper/railway.jpg
  '';

  xdg.configFile."hypr/hyprland.conf".text = ''
    $mod = "SUPER"
    exec-once = hyprpaper
    exec-once = waybar
    exec-once = hyprctl setcursor Adwaita 24
    exec-once = fcitx5 -d -r
    exec-once = fcitx5-remote -d -r

    bind = $mod, RETURN, exec, kitty
    bind = $mod, R, exec, fuzzel
    bind = $mod, E, exec, thunar
    bind = ALT, S, resizeactive,
    bind = ALT, F4, killactive,

    # Move focus with mod + hjkl
    bind = $mod, H, movefocus, l
    bind = $mod, L, movefocus, r
    bind = $mod, J, movefocus, d
    bind = $mod, K, movefocus, u

    # Switch workspaces with mod + [0-9]
    bind = $mod, 1, workspace, 1
    bind = $mod, 2, workspace, 2
    bind = $mod, 3, workspace, 3
    bind = $mod, 4, workspace, 4
    bind = $mod, 5, workspace, 5
    bind = $mod, 6, workspace, 6
    bind = $mod, 7, workspace, 7
    bind = $mod, 8, workspace, 8
    bind = $mod, 9, workspace, 9
    bind = $mod, 0, workspace, 10
    
    # Move active window to a workspace with mod + SHIFT + [0-9]
    bind = $mod SHIFT, 1, movetoworkspace, 1
    bind = $mod SHIFT, 2, movetoworkspace, 2
    bind = $mod SHIFT, 3, movetoworkspace, 3
    bind = $mod SHIFT, 4, movetoworkspace, 4
    bind = $mod SHIFT, 5, movetoworkspace, 5
    bind = $mod SHIFT, 6, movetoworkspace, 6
    bind = $mod SHIFT, 7, movetoworkspace, 7
    bind = $mod SHIFT, 8, movetoworkspace, 8
    bind = $mod SHIFT, 9, movetoworkspace, 9
    bind = $mod SHIFT, 0, movetoworkspace, 10

    # Laptop multimedia keys for volume and LCD brightness
    bindel = ,XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+
    bindel = ,XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
    bindel = ,XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
    bindel = ,XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
    bindel = ,XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+
    bindel = ,XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-

    input:touchpad:natural_scroll = true

    misc {
        disable_hyprland_logo = true
        disable_splash_rendering = true
    }
  '';
}
