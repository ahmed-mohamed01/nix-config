{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/24.05";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixos-wsl, ... }: 
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      homeConfigurations = {
        nixos = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./home.nix ];
        };
      };
      #nixosConfigurations.default = nixpkgs.lib.nixosSystem {
      #  system = "x86_64-linux";
      #  specialArgs = {inherit inputs;};
      #  modules = [
      #    ./configuration.nix
      #    inputs.home-manager.nixosModules.default
      #    nixos-wsl.nixosModules.default {
      #      system.stateVersion = "24.05";
      #      wsl.enable = true;
      #    }
      #  ];
    };
  
}
