{ config, ... }:
{
  programs.git = {
    enable = true;
    settings = {
      user.name = "Xilong Yang";
      user.email = "xilong.yang@foxmail.com";
      init.defaultBranch = "main";
    };
  };
}
