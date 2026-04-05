{
  description = "Root router flake (delegates to env flakes)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    server.url  = "path:./envs/server";
    mac.url  = "path:./envs/mac";
  };

  outputs = { self, nixpkgs, server, mac, ... }: 
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
  in {
    devShells.${system}.default = pkgs.mkShell {
      packages = with pkgs; [
        lua-language-server
      ];
    };

    nixosConfigurations =
      (server.nixosConfigurations or {});

    homeConfigurations = 
      (mac.homeConfigurations or {});
  };
}

