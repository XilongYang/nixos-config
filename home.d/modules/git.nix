{ config, ... }:
{
  programs.git = {
    enable = true;
    settings = {
      user.name = "Xilong Yang";
      user.email = "contact@xilong.site";
      init.defaultBranch = "main";
    };
  };
}
