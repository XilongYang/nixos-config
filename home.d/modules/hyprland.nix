{ config, ... }:
{
  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload   = /home/xilong/Pictures/Wallpaper/totoro.png
    wallpaper = ,/home/xilong/Pictures/Wallpaper/totoro.png
  '';

  xdg.configFile."hypr/hyprland.conf".text = ''
    monitor = , highres, auto, 2

    general {
        gaps_in = 4
        gaps_out = 10
        resize_on_border = true
    }

    xwayland {
        force_zero_scaling = true
    }

    $mod = "SUPER"
    exec-once = hyprpaper
    exec-once = hypridle
    exec-once = waybar
    exec-once = mako
    exec-once = hyprctl setcursor Adwaita 24
    exec-once = fcitx5 -d -r
    exec-once = fcitx5-remote -d -r
    exec-once = xrdb ~/.Xresources

    bind = $mod, RETURN, exec, kitty
    bind = $mod, E, exec, kitty yazi
    bind = $mod, R, exec, rofi -show drun -show-icons
    bind = $mod SHIFT, S, exec, hyprshot -m region -o /home/xilong/Pictures/Screenshots/
    bind = $mod, Print, exec, hyprshot -m output -o /home/xilong/Pictures/Screenshots/
    bind = ALT, S, resizeactive,
    bind = ALT, F4, killactive,

    bind = $mod, TAB, cyclenext, tiled

    # Toggle Fullscreen
    bind = $mod SHIFT, F, fullscreen

    # Toggle floating
    bind = $mod, F, togglefloating
    bind = ALT, TAB, cyclenext, floating

    bindm = $mod, mouse:272, movewindow
    bindm = $mod, mouse:273, resizewindow

    windowrule = float,  class:^(xdg-desktop-portal-gtk)$
    windowrule = center, class:^(xdg-desktop-portal-gtk)$
    windowrule = size 1200 800, class:^(xdg-desktop-portal-gtk)$

    windowrule = float,  class:^(google-chrome|chromium|brave-browser)$, initialTitle:^(.*)(Picture-in-Picture)(.*)$
    windowrule = center, class:^(google-chrome|chromium|brave-browser)$, initialTitle:^(.*)(Picture-in-Picture)(.*)$
    
    # Lockscreen
    bind = $mod ALT, L, exec, hyprlock 
    bind = CTRL ALT, L, exec, hyprlock & sleep 1 && systemctl suspend-then-hibernate

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

    # Swap focus with mod + CTRL + hjkl
    bind = $mod CTRL, H, swapwindow, l
    bind = $mod CTRL, L, swapwindow, r
    bind = $mod CTRL, K, swapwindow, u
    bind = $mod CTRL, J, swapwindow, d

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
    bindel = ,XF86AudioRaiseVolume, exec, wpctl set-volume -l 0.8 @DEFAULT_AUDIO_SINK@ 5%+
    bindel = ,XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
    bindel = ,XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
    bindel = ,XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
    bindel = ,XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+
    bindel = ,XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-

    input:touchpad:natural_scroll = true

    gesture = 3, vertical, workspace
    
    animations {
        animation = workspaces,1,5,default,slidevert
    }

    misc {
        disable_hyprland_logo = true
        disable_splash_rendering = true
    }
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

  xdg.configFile."hypr/hypridle.conf".text = ''
    general {
        lock_cmd = pidof hyprlock || hyprlock       # avoid starting multiple hyprlock instances.
        before_sleep_cmd = loginctl lock-session    # lock before suspend.
        after_sleep_cmd = hyprctl dispatch dpms on  # to avoid having to press a key twice to turn on the display.
    }
    
    # Turn off keyboard backlight
    listener { 
        timeout = 20
        on-timeout = brightnessctl -sd asus::kbd_backlight set 0
        on-resume = brightnessctl -rd asus::kbd_backlight
    }
    
    # Set monitor backlight to minimum
    listener {
        timeout = 300
        on-timeout = brightnessctl -s set 10
        on-resume = brightnessctl -r
    }
    
    # Lock screen
    listener {
        timeout = 900
        on-timeout = loginctl lock-session
    }
    
    # Suspend
    listener {
        timeout = 920
        on-timeout = systemctl suspend-then-hibernate
    }
  '';
}
