{
  description = "Your new nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    unstable-nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    catppuccin.url = "github:catppuccin/nix";
  };

  outputs = { self, nixpkgs, unstable-nixpkgs, catppuccin, nixos-wsl, home-manager, ... }: 
  let
    nixpkgsConfig = {
      allowUnfree = true; # Allow unfree packages globally
    };
    lib = nixpkgs.lib;
    system = "x86_64-linux";    # Change this to "x86_64-darwin" for macOS
    pkgs = import nixpkgs { inherit system; config = nixpkgsConfig; };
    unstable-pkgs = import unstable-nixpkgs { inherit system; config = nixpkgsConfig; };
  in {
    # NixOS configuration entrypoint
    nixosConfigurations = {
      #---- NixOS-WSL configuration -------------------------------------------#
      wsl = lib.nixosSystem {    # Usage: 'nixos-rebuild --flake .#wsl'
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

      #---- Spectre config ---------------------------------------------------#
      spectre = lib.nixosSystem {
        inherit pkgs;
        modules = [ ./hosts/spectre/configuration.nix ];
      };
      main_pc = lib.nixosSystem {
        inherit pkgs;
        modules = [ ./hosts/main_pc/configuration.nix ];
      };
    };
  # 
    # Available through 'home-manager switch --flake .#your-username@your-hostname'
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
      proxmox = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ 
          ./hosts/proxmox/home.nix   
          catppuccin.homeManagerModules.catppuccin
          ];
        };
      main_pc = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ 
          ./hosts/main_pc/home.nix   
          catppuccin.homeManagerModules.catppuccin
          ];
        };
    };
  };
}
