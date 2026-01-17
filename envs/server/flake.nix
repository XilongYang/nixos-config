{
  description = "Xilong's Server";

  nixConfig = {
    substituters = [
      "https://cache.nixos.org"
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  
  outputs = inputs@{nixpkgs, home-manager, ...} : {
    nixosConfigurations = {
      "server" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ../base/os.d/os.nix
          ./os.d/os.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = false;
            home-manager.users.xilong = {
              imports = [
                ../base/home.d/home.nix
                ./home.d/home.nix
              ];
            };
          }
        ]; 
      };
    }; 
  };
}
