{ config, ... }:
{
  programs.git = {
    enable = true;
    userName = "Xilong Yang";
    userEmail = "xilong.yang@foxmail.com";
    extraConfig = {
        init.defaultBranch = "main";
    };
  };
}
