{ config, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true; 
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      xnix-gc = "sudo nix store gc --debug";
      vim = "nvim";
      pd = "curl -F \"c=@-\" \"https://fars.ee/\"";
    };
    initContent = ''
      PATH=$PATH:$HOME/.local/bin
    '';
    oh-my-zsh = {
      enable = true;
      theme = "kardan";
      plugins = ["git"];
    };
  };
}
