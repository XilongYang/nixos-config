{ config, pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      vim = "nvim";
    };

    # macOS 需要这个防止 gpg 弹窗抽风
    initContent = ''
      export GPG_TTY=$(tty)
      if [ -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]; then
        . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
      fi
    '';

    oh-my-zsh = {
      enable = true;
      theme = "kardan";
      plugins = ["git"];
    };
  };
}

