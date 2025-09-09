{config, pkgs, lib, ...}:
let
  mkTuple = lib.hm.gvariant.mkTuple;
in
{
  home.username = "xilong";
  home.homeDirectory = "/home/xilong";
  
  programs.git = {
    enable = true;
    userName = "Xilong Yang";
    userEmail = "xilong.yang@foxmail.com";
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true; 
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      xnix-history = "nix profile history --profile /nix/var/nix/profiles/system";
      xnix-clear = "sudo nix profile wipe-history --profile /nix/var/nix/profiles/system  --older-than 14d";
      xnix-gc = "sudo nix store gc --debug";
      vim = "nvim";
      note = "cd ~/Notes/ && vim README.md";
    };
    initContent = ''
      PATH=$PATH:/home/xilong/.local/bin
    '';
    oh-my-zsh = {
      enable = true;
      theme = "kardan";
      plugins = ["git"];
    };
  };

  home.packages = with pkgs; [
    chez
    eudic
    fastfetch
    fuzzel
    gh
    google-chrome
    hyprpaper
    foliate
    kitty
    libsForQt5.qtstyleplugin-kvantum
    mpv
    neovim
    qogir-theme
    qogir-icon-theme
    qogir-kde
    libsForQt5.qt5ct
    qt6ct
    rclone
    sioyek
    xfce.thunar
    waybar

    #LSPs
    clang-tools
    jdt-language-server
    pyright
    nodePackages.bash-language-server
    sqls
    nodePackages.typescript-language-server
    nodePackages.vscode-langservers-extracted
    haskell-language-server
    lua-language-server
    marksman
  ];

  xdg.configFile."waybar/config".text = ''
    {
        "layer": "top",
        "position": "top",
        "height": 24,
        "spacing": 5,
    
        "modules-left": ["hyprland/workspaces"],
        "modules-center": [],
        "modules-right": ["backlight", "wireplumber", "battery", "hyprland/language", "idle_inhibitor", "network", "bluetooth", "tray", "clock"],
    
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
    
        "clock": {
            "format": "{:%H:%M}"
        },
    
        "backlight": {
            "format": " {icon}  {percent}% ",
            "format-icons": ["","󰃜", "󰃛", "󰃞","󰃝","󰃟","󰃠"],
            "tooltip": false
        },
    
        "wireplumber": {
            "format": " \udb81\udd7e  {volume}% ",
            "max-volume": 100,
            "scroll-step": 5
        },
    
        "battery": {
            "bat": "BAT1",
            "interval": 60,
            "format": "{icon}  {capacity}%",
            "format-icons": ["\uf244", "\uf243", "\uf242", "\uf241", "\uf240"],
        },
    
        "memory": {
            "interval": 30,
            "format": "\uf4bc  {used:0.1f}G"
        },
    
        "temperature": {
            "format": "{temperatureC}°C"
        },
    
        "network": {
            "format": "",
            "format-ethernet": "\udb83\udc9d",
            "format-wifi": "{icon}",
            "format-disconnected": "\udb83\udc9c",
            "format-icons": ["\udb82\udd2f", "\udb82\udd1f", "\udb82\udd22", "\udb82\udd25", "\udb82\udd28"],
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
    
        "hyprland/language": {
            "format": "{short}"
        },
    
        "tray": {
            "icon-size": 16,
            "spacing": 16
        },
    
        "custom/platform-profile": {
    	"format": "{icon} ",
    	"exec": "~/.config/waybar/platform_profile.sh",
    	"return-type": "json",
    	"restart-interval": 1,
    	"format-icons": {
    	    "quiet": "\udb80\udf2a",
    	    "balanced": "\udb80\ude10",
    	    "performance": "\uf427",
                "default": "?"
    	},
        },
    
        "idle_inhibitor": {
            "format": "{icon}",
            "format-icons": {
                "activated": "\udb80\udd76",
                "deactivated": "\udb83\udfaa"
            }
        }
    }
  '';

  xdg.configFile."waybar/style.css".text = ''
    @define-color foreground #eeeeee;
    @define-color foreground-inactive #aaaaaa;
    @define-color background #000000;
    
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
        padding-left: 0.7em;
    }
    
    #workspaces button.empty {
        color: @foreground-inactive;
    }
    
    #memory,
    #custom-platform-profile {
        padding-left: 1em
    }
    
    #wireplumber,
    #battery,
    #idle_inhibitor,
    #language,
    #network,
    #bluetooth,
    #tray {
        padding-right: 1em 
    }
  '';

  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload   = /home/xilong/Pictures/Wallpaper/railway.jpg
    wallpaper = ,/home/xilong/Pictures/Wallpaper/railway.jpg
  '';

  xdg.configFile."hypr/hyprland.conf".text = ''
    $mod = "SUPER"
    exec-once = "hyprpaper"
    exec-once = "waybar"

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
  '';

  gtk = {
    enable = true;
    theme = {
      name = "Qogir";
      package = pkgs.qogir-theme;
    };
    iconTheme = {
      name = "Qogir";
      package = pkgs.qogir-icon-theme;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "qtct";   # use qt5ct/qt6ct control panels
    style.name    = "kvantum";# tell Qt to use Kvantum
  };

  programs.kitty = {
    enable = true;
    font = {
      name = "JetBrains Mono";
      size = 12;
    };
    settings = {
      # extra kitty.conf options
      cursor_blink_interval = 0;
      enable_audio_bell = "no";
    };
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
