{ config, ... }:
{
  xdg.configFile."waybar/scripts/battery-status.sh" = {
    executable = true;
    source = ../../assets/scripts/battery-status.sh;
  };

  xdg.configFile."waybar/scripts/mic-status.sh" = {
    executable = true;
    source = ../../assets/scripts/mic-status.sh;
  };

  xdg.configFile."waybar/assets/ringing.wav" = {
    source = ../../assets/sounds/ringing.wav;
  };

  xdg.configFile."waybar/config".text = ''
    {
        "layer": "top",
        "position": "left",
        "height": 900,
        "spacing": 15,
    
        "modules-left": ["hyprland/workspaces"],
        "modules-center": [],
        "modules-right": [ "custom/mic", "wireplumber", "backlight", "network", "bluetooth", "tray", "idle_inhibitor", "custom/battery", "clock"],
    
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
    
        "custom/mic": {
          "exec": "~/.config/waybar/scripts/mic-status.sh",
          "interval": 1,
          "return-type": "json",
          "on-click": "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle",
          "format": "{text}",
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
            "on-click": "kitty --title nmtui -e nmtui",
        },
    
        "bluetooth": {
            "format": "󰂯",
            "format-disabled": "󰂲",
            "format-connected": "󰂱",
            "tooltip-format": "{controller_alias}",
            "tooltip-format-connected": "{device_enumerate}",
            "tooltip-format-enumerate-connected": "{device_alias}",
            "on-click": "overskride"
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

        "custom/battery": {
           "interval": 5,
           "return-type": "json",
           "exec": "~/.config/waybar/scripts/battery-status.sh",
           "format": "{text}",
           "tooltip": true
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
    
    #custom-mic.mic-active { 
        color: #f7768e;
    }

    #custom-mic.mic-muted  {
        color: #e0af68;
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
    
    #custom-battery {
        margin-left: 0px;
    }
    
    #custom-battery.warning {
        color: #e0af68;
    }
    
    #custom-battery.critical {
        color: #f7768e;
    }
    
    #clock {
        margin-bottom: 8px;
        margin-left: 0;
    }
  '';
}
