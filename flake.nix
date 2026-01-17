{
  description = "Root router flake (delegates to env flakes)";

  inputs = {
    desktop.url = "path:./envs/desktop";
    server.url  = "path:./envs/server";
  };

  outputs = { self, desktop, server, ... }: {
    nixosConfigurations =
      (desktop.nixosConfigurations or {})
      // (server.nixosConfigurations or {});
  };
}

