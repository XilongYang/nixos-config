{ config, ... }:
{
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
      pd = "curl -F \"c=@-\" \"https://fars.ee/\""
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
}
