{ config, ... }:
{
  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload   = /home/xilong/.config/nixos/res/wallpaper/totoro.png
    wallpaper = ,/home/xilong/.config/nixos/res/wallpaper/totoro.png
  '';

  xdg.configFile."hypr/hyprlock.conf".text = ''
    background {
        monitor =
        path = screenshot
        color = rgba(25, 20, 20, 1.0)
        blur_passes = 2
    }
    
    input-field {
        monitor = eDP-1
        size = 1500, 300
        outline_thickness = 0
        dots_size = 0.8
        dots_spacing = 0.2
        dots_text_format = *
        outer_color = rgba(0,0,0,0)
        inner_color = rgba(0,0,0,0)
        font_color = rgba(255,255,255,1.0)
        halign = center
        valign = center
        placeholder_text = <Password>
        placeholder_static = true
    }
  '';

  xdg.configFile."hypr/hyprland.conf".text = ''
    general {
        gaps_in = 4
        gaps_out = 10
        resize_on_border = true
    }

    $mod = "SUPER"
    exec-once = hyprpaper
    exec-once = waybar
    exec-once = mako
    exec-once = hyprctl setcursor Adwaita 24
    exec-once = fcitx5 -d -r
    exec-once = fcitx5-remote -d -r

    bind = $mod, RETURN, exec, kitty
    bind = $mod, R, exec, xfce4-appfinder
    bind = $mod, E, exec, thunar
    bind = $mod SHIFT, S, exec, hyprshot -m region
    bind = ALT, S, resizeactive,
    bind = ALT, F4, killactive,

    # Toggle floating
    bind = $mod, F, togglefloating

    bindm = $mod, mouse:272, movewindow
    bindm = $mod, mouse:273, resizewindow

    windowrule = float,  class:^(xdg-desktop-portal-gtk)$
    windowrule = center, class:^(xdg-desktop-portal-gtk)$
    windowrule = size 1200 800, class:^(xdg-desktop-portal-gtk)$

    windowrule = float,  class:^(google-chrome|chromium|brave-browser)$, initialTitle:^(.*)(Picture-in-Picture)(.*)$
    windowrule = center, class:^(google-chrome|chromium|brave-browser)$, initialTitle:^(.*)(Picture-in-Picture)(.*)$
    
    windowrule = float,  class:^(xfce4\-appfinder)$
    windowrule = center, class:^(xfce4\-appfinder)$
    windowrule = size 600 400, class:^(xfce4\-appfinder)$

    # Lockscreen
    bind = $mod ALT, L, exec, hyprlock 
    bind = CTRL ALT, L, exec, hyprlock & sleep 1 && systemctl suspend

    # Resize with mod + SHIFT + hjkl
    bind = $mod SHIFT, H, resizeactive, -100 0
    bind = $mod SHIFT, L, resizeactive, 100 0
    bind = $mod SHIFT, J, resizeactive, 0 100
    bind = $mod SHIFT, K, resizeactive, 0 -100

    # Resize with mod + CTRL + SHIFT + hjkl
    bind = $mod CTRL SHIFT, H, resizeactive, -20 0
    bind = $mod CTRL SHIFT, L, resizeactive, 20 0
    bind = $mod CTRL SHIFT, J, resizeactive, 0 20
    bind = $mod CTRL SHIFT, K, resizeactive, 0 -20

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
