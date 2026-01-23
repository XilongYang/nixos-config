{
  description = "Root router flake (delegates to env flakes)";

  inputs = {
    desktop.url = "path:./envs/desktop";
    server.url  = "path:./envs/server";
    mac.url  = "path:./envs/mac";
  };

  outputs = { self, desktop, server, mac, ... }: {
    nixosConfigurations =
      (desktop.nixosConfigurations or {})
      // (server.nixosConfigurations or {});

    homeConfigurations = 
      (mac.homeConfigurations or {});
  };
}

