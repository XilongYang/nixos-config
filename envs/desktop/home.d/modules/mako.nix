{ config, ... }:
{
  xdg.configFile."mako/config".text = ''
    # ===== mako: Tokyo Night (night) =====
    font=JetBrainsMono Nerd Font 12
    layer=overlay
    anchor=top-right
    width=360
    height=120
    border-size=2
    border-radius=10
    padding=10
    
    background-color=#1a1b26DD
    text-color=#c0caf5
    border-color=#7aa2f7
    progress-color=over #7dcfff
    
    icons=1
    max-visible=6
    max-history=1000
    markup=1
    actions=1
    default-timeout=8000
    
    [urgency=low]
    border-color=#565f89
    text-color=#a9b1d6
    background-color=#16161EDF
    
    [urgency=normal]
    progress-color=over #bb9af7
    
    [urgency=high]
    border-color=#f7768e
    background-color=#1a1b26F0
    default-timeout=0
  '';
}
