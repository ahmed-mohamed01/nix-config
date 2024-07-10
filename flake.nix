{
  description = "Your new nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    unstable-nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    catppuccin.url = "github:catppuccin/nix";
    };    
  

  outputs = { self, nixpkgs, unstable-nixpkgs, catppuccin, nixos-wsl, home-manager, ... }: 
  let
    lib = nixpkgs.lib;
    system = "x86_64-linux";    # Change this to "x86_64-darwin" for macOS
    pkgs = import nixpkgs { inherit system; };
    unstable-pkgs = import unstable-nixpkgs { inherit system; };
  in {
    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      #---- NixOS-WSL configuration -------------------------------------------#
      wsl = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          nixos-wsl.nixosModules.default
          {
            #system.stateVersion = "24.05";
            wsl.enable = true;
          }
          ./hosts/wsl/configuration.nix
        ];
      };
      #---- Virtual Box VM config ---------------------------------------------#
      vm = lib.nixosSystem {
        inherit pkgs;
        modules = [ ./hosts/vm/configuration.nix ];
      };
      #---- Spectre config ---------------------------------------------------#
      spectre = lib.nixosSystem {
        inherit pkgs;
        modules = [ ./hosts/spectre/configuration.nix ];
      };
    };
  # 
    # Available through 'home-manager --flake .#your-username@your-hostname'
    homeConfigurations = {
    #---- WSL Home manager configuration --------------------------------------#
      wsl = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ 
          ./hosts/wsl/home.nix   
          catppuccin.homeManagerModules.catppuccin
          ];
        };
    #---- VM Home-manager configuration --------------------------------------#
      vm = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ 
          ./hosts/vm/home.nix   
          catppuccin.homeManagerModules.catppuccin
          ];
        };
    #---- Spectre Home-manager configuration ---------------------------------#
      spectre = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ 
          ./hosts/spectre/home.nix   
          catppuccin.homeManagerModules.catppuccin
          ];
        };
    };
  };
}