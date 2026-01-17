{ config, ... }:
{
  xdg.configFile."rofi/config.rasi".text = ''
    /**
     * ROFI Tokyo Night Color Theme
     */
    
    * {
        font: "JetBrainsMono Nerd Font 14";
    
        foreground:                  #a9b1d6;
        background:                  #1a1b26;
    
        separatorcolor:              #7aa2f7;
    
        selected-foreground:         @background;
        selected-background:         #f7768e;
    
        active-foreground:           @background;
        active-background:           #7dcfff;
    
        urgent-foreground:           rgb( 255, 129, 255);
        urgent-background:           rgb( 0, 0, 208);
    
        spacing:                     2;
    }
    window {
        background-color: @background;
        border-color:     @separatorcolor;
        border:           1;
        padding:          5;
    }
    mainbox {
        border:  0;
        padding: 0;
    }
    message {
        border:       2px 0px 0px ;
        border-color: @separatorcolor;
        padding:      1px ;
    }
    textbox {
        text-color: @foreground;
    }
    listview {
        fixed-height: 0;
        border:       2px 0px 0px ;
        border-color: @separatorcolor;
        spacing:      2px ;
        scrollbar:    true;
        padding:      2px 0px 0px ;
    }
    element {
        border:  0;
        padding: 1px ;
    }
    element-text {
        background-color: inherit;
        text-color:       inherit;
    }
    element.normal.normal {
        background-color: @background;
        text-color:       @foreground;
    }
    element.normal.urgent {
        background-color: @urgent-background;
        text-color:       @urgent-foreground;
    }
    element.normal.active {
        background-color: @active-background;
        text-color:       @active-foreground;
    }
    element.selected.normal {
        background-color: @selected-background;
        text-color:       @selected-normal-foreground;
    }
    element.selected.urgent {
        background-color: @selected-background;
        text-color:       @selected-foreground;
    }
    element.selected.active {
        background-color: @selected-background;
        text-color:       @selected-foreground;
    }
    element.alternate.normal {
        background-color: @normal-background;
        text-color:       @normal-foreground;
    }
    element.alternate.urgent {
        background-color: @urgent-background;
        text-color:       @urgent-foreground;
    }
    element.alternate.active {
        background-color: @active-background;
        text-color:       @active-foreground;
    }
    scrollbar {
        width:        4px ;
        border:       0;
        handle-width: 8px ;
        padding:      0;
    }
    mode-switcher {
        border:       2px 0px 0px ;
        border-color: @separatorcolor;
    }
    button.selected {
        background-color: @selected-background;
        text-color:       @selected-normal-foreground;
    }
    inputbar {
        spacing:    0;
        text-color: @foreground;
        padding:    1px ;
    }
    case-indicator {
        spacing:    0;
        text-color: @foreground;
    }
    entry {
        spacing:    0;
        text-color: @foreground;
    }
    prompt, button{
        spacing:    0;
        text-color: @foreground;
    }
    inputbar {
        children:   [ prompt,textbox-prompt-colon,entry,case-indicator ];
    }
    textbox-prompt-colon {
        expand:     false;
        str:        ":";
        margin:     0px 0.3em 0em 0em ;
        text-color: @foreground;
    }
  '';
}
