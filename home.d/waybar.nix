{ config, ... }:
{
  xdg.configFile."waybar/config".text = ''
    {
        "layer": "top",
        "position": "top",
        "height": 24,
        "margin-right": 20,
        "margin-left": 10,
        "spacing": 15,
    
        "modules-left": ["hyprland/workspaces"],
        "modules-center": ["hyprland/window"],
        "modules-right": ["backlight", "wireplumber", "network", "bluetooth", "tray", "idle_inhibitor", "battery", "clock"],
    
        "hyprland/workspaces": {
            "format": "<span size='larger'>{icon}</span>",
            "on-click": "activate",
            "format-icons": {
                "active": "\uf444",
                "default": "\uf4c3"
            },
            "icon-size": 10,
            "sort-by-number": true,
            "persistent-workspaces": {
                "1": [],
                "2": [],
                "3": [],
                "4": [],
                "5": [],
            }
        },
        "hyprland/window": {  
          "format": "{}"
        },
         "clock": {
           "format": "\uf017 {:%H:%M}",
           "format-alt": "\ueab0 {:%Y-%m-%d %R}",
           "tooltip-format": "<tt><small>{calendar}</small></tt>",
           "calendar": {
             "mode"          : "month",
             "mode-mon-col"  : 3,
             "weeks-pos"     : "right",
             "on-scroll"     : 1,
             "format": {
               "months":     "<span color='#bb9af7'><b>{}</b></span>",
               "days":       "<span color='#a9b1d6'><b>{}</b></span>",
               "weeks":      "<span color='#3d59a1'><b>W{}</b></span>",
               "weekdays":   "<span color='#7aa2f7'><b>{}</b></span>",
               "today":      "<span color='#f7768e'><b><u>{}</u></b></span>"
               }
             },
           "actions":  {
             "on-click-right": "mode",
             "on-scroll-up": "tz_up",
             "on-scroll-down": "tz_down",
             "on-scroll-up": "shift_up",
             "on-scroll-down": "shift_down"
             }
         },
        "backlight": {
            "format": "{icon} {percent}%",
            "format-icons": ["󰃠"],
            "tooltip": false
        },
        "wireplumber": {
            "format": "\udb81\udd7e {volume}%",
            "format-muted": "\udb81\udf5f",
            "max-volume": 100,
            "scroll-step": 5
        },
        "battery": {
            "bat": "BAT0",
            "interval": 60,
            "states": {
               "warning": 10,
               "critical": 5
            },
            "format": "{icon}  {capacity}%",
            "format-alt": "{icon}  {time}",
            "format-icons": ["\uf244", "\uf243", "\uf242", "\uf241", "\uf240"],
        },
        "network": {
            "format": "",
            "format-ethernet": "\udb83\udc9d ",
            "format-wifi": "{icon}",
            "format-disconnected": "\udb83\udc9c ",
            "format-icons": ["\udb82\udd2f ", "\udb82\udd1f ", "\udb82\udd22 ", "\udb82\udd25 ", "\udb82\udd28 "],
            "tooltip-format-wifi": "{essid} ({signalStrength}%)",
            "tooltip-format-ethernet": "{ifname}",
            "tooltip-format-disconnected": "Disconnected",
        },
        "bluetooth": {
            "format": "\udb80\udcaf",
            "format-disabled": "\udb80\udcb2",
            "format-connected": "\udb80\udcb1",
            "tooltip-format": "{controller_alias}\t{controller_address}",
            "tooltip-format-connected": "{controller_alias}\t{controller_address}\n\n{device_enumerate}",
            "tooltip-format-enumerate-connected": "{device_alias}\t{device_address}"
        },
        "tray": {
            "icon-size": 16,
            "spacing": 16
        },
        "idle_inhibitor": {
            "format": "{icon}",
            "format-icons": {
                "activated": "\udb80\udd76 ",
                "deactivated": "\udb83\udfaa "
            }
        }
    }
  '';

  xdg.configFile."waybar/style.css".text = ''
    @define-color foreground #eeeeee;
    @define-color foreground-inactive #aaaaaa;
    @define-color background #292e39;
    
    * {
        font-family: JetBrainsMono Nerd Font;
        font-size: 17px;
        padding: 0;
        margin: 0;
    }
    
    #waybar {
        color: @foreground;
        background-color: @background;
    }
    
    #workspaces button {
        color: @foreground;
        padding-right: 10px;
    }
    
    #workspaces button.empty {
        color: @foreground-inactive;
    }
  '';
}
