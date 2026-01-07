{ config, pkgs, ... }:
{
  services.keyd = {
    enable = true;
    keyboards.internal = {
      ids = [ "0001:0001" ];
      settings = {
        main = {
          leftcontrol = "noop";
          capslock    = "leftcontrol";
  
          leftmeta    = "leftalt";
          leftalt     = "leftmeta";
  
          rightshift  = "layer(fn2)";
  
          backspace   = "backslash";
          backslash   = "backspace";

          esc         = "noop";
          grave       = "esc";
          delete      = "grave";
        }; 
  
        fn2 = {
          leftbrace  = "up";
          slash      = "down";
          semicolon  = "left";
          apostrophe = "right";

          l          = "pageup";
          dot        = "pagedown";
          k          = "home";
          comma      = "end";

          backslash  = "insert";
          grave      = "delete";

          h          = "kpasterisk";
          j          = "kpslash";
          n          = "kpplus";
          m          = "kpminus";

          i          = "print";
          o          = "scrolllock";
          p          = "pause";

          "1"        = "f1";
          "2"        = "f2";
          "3"        = "f3";
          "4"        = "f4";
          "5"        = "f5";
          "6"        = "f6";
          "7"        = "f7";
          "8"        = "f8";
          "9"        = "f9";
          "0"        = "f10";
          minus      = "f11";
          equal      = "f12";
        };
      };
    };
  };
}
