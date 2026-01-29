{ config, pkgs, ... }:
{
  programs.zsh = {
    shellAliases = {
      ls  = "ls --color=auto";
    };

    # macOS 需要这个防止 gpg 弹窗抽风
    initContent = ''
      export GPG_TTY=$(tty)
      if [ -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]; then
        . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
      fi
      export CLICOLOR=1
      export LSCOLORS=...
    '';
  };
}

