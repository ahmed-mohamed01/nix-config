{
  description = "Your new nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    unstable-nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    };    
  

  outputs = { self, nixpkgs, unstable-nixpkgs, catppuccin, nixos-wsl, home-manager, ... }: 
  let
    lib = nixpkgs.lib;
    system = "x86_64-linux";    # Change this to "x86_64-darwin" for macOS
    pkgs = import nixpkgs { inherit system; };
    unstable-pkgs = import unstable-nixpkgs { inherit system; };
  in {
  #---- NixOS configuration, identified via hostname --------------------------#
    nixosConfigurations = {
      #---- NixOS-WSL configuration -------------------------------------------#
      wsl = nixpkgs.lib.nixosSystem {    # Usage: 'nixos-rebuild --flake .#wsl'
        inherit system;
        modules = [ ./hosts/wsl/configuration.nix ];  # Replace with path to your NixOS configuration
      };

      #---- add more hosts / machine configs here ----------------------------#
      # Usage: 'nixos-rebuild --flake .#config-name'
    };

  #----- Home manager configurations, identified via hostname ----------------#
    homeConfigurations = {
    #---- WSL Home manager configuration -------------------------------------#
      wsl = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./hosts/wsl/home.nix ];  # Replace with path to your home-manager configuration
        };
    };

    #---- add more hosts / machine configs here ----------------------------#
      # Usage: 'nixos-rebuild --flake .#config-name'
  };
}