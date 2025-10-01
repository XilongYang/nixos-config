{ config, ... }:
{
  xdg.configFile."waybar/config".text = ''
    {
        "layer": "top",
        "position": "left",
        "height": 900,
        "spacing": 15,
    
        "modules-left": ["hyprland/workspaces"],
        "modules-center": [],
        "modules-right": ["wireplumber", "backlight", "network", "bluetooth", "tray", "idle_inhibitor", "battery", "clock"],
    
        "hyprland/workspaces": {
            "format": "{icon}",
            "on-click": "activate",
            "format-icons": {
                "active": "󱄅",
                "default": " 🞇",
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
    
        "wireplumber": {
            "format": "{icon}",
            "format-icons": ["󰽯 ", "󰽯⡀", "󰽯⣀", "󰽯⣄", "󰽯⣤", "󰽯⣦", "󰽯⣶", "󰽯⣷", "󰽯⣿", "󰽰⡀", "󰽰⣀", "󰽰⣄", "󰽰⣤", "󰽰⣦", "󰽰⣶", "󰽰⣷", "󰽰⣿"],
            "format-muted": "󰽺",
            "tooltip-format": "Volume: {volume}%",
            "max-volume": 80,
            "scroll-step": 5
        },
    
        "backlight": {
            "format": "{icon}",
            "format-icons": ["", "", "", "", "", "", "", "", "", "", "", "", "", ""],
            "tooltip-format": "Backlight: {percent}%",
        },
    
        "network": {
            "format": "",
            "format-ethernet": "󰛳",
            "format-wifi": "{icon}",
            "format-disconnected": "󰇨",
            "format-icons": ["󰤯", "󰤟", "󰤢", "󰤥", "󰤨"],
            "tooltip-format-wifi": "{essid} ({signalStrength}%)",
            "tooltip-format-ethernet": "{ifname}",
            "tooltip-format-disconnected": "Disconnected",
        },
    
        "bluetooth": {
            "format": "󰂯",
            "format-disabled": "󰂲",
            "format-connected": "󰂱",
            "tooltip-format": "{controller_alias}\t{controller_address}",
            "tooltip-format-connected": "{controller_alias}\t{controller_address}\n\n{device_enumerate}",
            "tooltip-format-enumerate-connected": "{device_alias}\t{device_address}"
        },
    
        "tray": {
            "icon-size": 14,
            "spacing": 16
        },
    
        "idle_inhibitor": {
            "format": "{icon}",
            "format-icons": {
                "activated": "",
                "deactivated": ""
            },
            "tooltip-format-activated": "Idle inhibitor active.",
            "tooltip-format-deactivated": "Normal idle behavior."
        },
    
        "battery": {
            "bat": "BAT0",
            "interval": 5,
            "states": {
               "warning": 10,
               "critical": 5
            },
            "format": "{icon}",
            "format-charging":"󰂄",
            "format-icons": ["󰁺", "󰁻", "󰁼", "󰁽", "󰁾", "󰁿", "󰂀", "󰂁", "󰂂", "󰁹"],
            "tooltip-format": "{capacity}%, {time}",
        },
    
        "clock": {
            "interval": 1,
            "format": "{:%H%n%M}",
            "tooltip-format": "<tt><small>{calendar}</small></tt>\n\n{:%Y-%m-%d %H:%M:%S}",
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
        }
    }
  '';

  xdg.configFile."waybar/style.css".text = ''
    @define-color foreground #eeeeee;
    @define-color foreground-inactive #aaaaaa;
    @define-color background #191e29;
    
    * {
        font-family: JetBrainsMono Nerd Font;
        font-size: 16px;
        margin-left: -1px;
    }
    
    #waybar {
        color: @foreground;
        background-color: @background;
    }
    
    #workspaces {
        margin-top: 8px;
    }
    
    #workspaces button {
        color: @foreground;
        margin-top: 2px;
        margin-bottom: 2px;
    }
    
    #workspaces button.empty {
        color: @foreground-inactive;
        margin-top: 2px;
        margin-bottom: 2px;
    }
    #backlight {
    }
    
    #wireplumber {
        font-size: 14px;
        margin-left: 0px;
    }

    #wireplumber.muted {
        font-size: 20px;
    }

    #network {
        margin-left: -6px;
    }
    
    #bluetooth {
        margin-left: 0px;
    }
    
    #tray {
        margin-left: 2px;
    }
    
    #idle_inhibitor.activated {
        color: #f7768e;
    }
    
    #battery {
        margin-left: 0px;
    }
    
    #clock {
        margin-bottom: 8px;
        margin-left: 0;
    }
  '';
}
