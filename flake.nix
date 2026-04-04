{
  description = "Root router flake (delegates to env flakes)";

  inputs = {
    server.url  = "path:./envs/server";
    mac.url  = "path:./envs/mac";
  };

  outputs = { self, server, mac, ... }: {
    nixosConfigurations =
      (server.nixosConfigurations or {});

    homeConfigurations = 
      (mac.homeConfigurations or {});
  };
}

