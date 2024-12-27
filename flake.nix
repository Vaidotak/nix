{
  description = "Flake pajungimas 2024.12.26";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
    };
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nur, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      lib = nixpkgs.lib;
    in {
      nixosConfigurations = {
        vaidotak = lib.nixosSystem {
          inherit system;
          modules = [
            ./configuration.nix
            ./networking.nix
            ./desktop.nix
            ./users.nix
            ./software.nix
            ./hardware.nix
            ./updates.nix
            ./services.nix
          ];
        };
      };
      homeConfigurations = {
        vaidotak = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./home.nix ];
        };
      };
    };
}
