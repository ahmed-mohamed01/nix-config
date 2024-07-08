{
  description = "My main config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";   # Change this to 'nixos-24.05' for a stable release.

    #----- Other custom inputs ---------------------------------#
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";    # Enable if using NixOS-WSL
    #_1password-shell-plugins.url = "github:1Password/shell-plugins";   # Enable if using 1password shell plugins
    catppuccin.url = "github:catppuccin/nix";     # Enable if using catppuccin's home-manager modules

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
                               
  outputs = { self, nixpkgs, catppuccin, nixos-wsl, home-manager, ... }@inputs: 
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";    # Change this to "x86_64-darwin" for macOS
      pkgs = import nixpkgs { inherit system; };
    in {
      #imports = [ inputs._1password-shell-plugins.hmModules.default ];   # Enable if using 1password shell plugins

  #----- NixOS configurations, identified via hostname --------------------------------------------------------#
    #---- Available through 'nixos-rebuild --flake .#your-hostname' -------------------------------------------#

      nixosConfigurations = {
        #----- Spectre configuration --------------------------------------------------------------------------#
        spectre = nixpkgs.lib.nixosSystem {
          inherit pkgs;
          specialArgs = {inherit inputs outputs;};
          modules = [
            ./hosts/spectre/configuration.nix
            
            ];
        };

        #----- WSL configuration ------------------------------------------------------------------------------#
        nixos = nixos-wsl.nixosSystem {
          inherit pkgs;
          specialArgs = {inherit inputs outputs;};
          modules = [
            nixos-wsl.nixosModules.default {
              wsl.enable = true;
            }
            ./hosts/wsl/configuration.nix
          ];
        };

        #----- Virtual Box VM config --------------------------------------------------------------------------#
        vm = nixos-wsl.nixosSystem {
          inherit pkgs;
          specialArgs = {inherit inputs outputs;};
          modules = [
            nixos-wsl.nixosModules.default {
              system.stateVersion = "24.05";
              wsl.enable = true;
            }
            ./hosts/vm/configuration.nix
          ];
        };

        #----- Main desktop configuration ---------------------------------------------------------------------#
        um790 = nixos-wsl.nixosSystem {
          inherit pkgs;
          specialArgs = {inherit inputs outputs;};
          modules = [
            nixos-wsl.nixosModules.default {
              system.stateVersion = "24.05";
              wsl.enable = true;
            }
            ./hosts/um790/configuration.nix
          ];
        
        };

  #----- Home manbager configurations, identified via hostname ------------------------------------------------#
    #---- Available through 'home-manager --flake .#your-username@your-hostname' ------------------------------#

      homeConfigurations = {
        #---- Main config, managed via home-manager -----------------------------------------------------------#
        nixos = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ 
            ./home.nix
            catppuccin.homeManagerModules.catppuccin
            
            ];
        };
       #---- WSL config, managed via home-manager -------------------------------------------------------------#
        wsl = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ 
            ./hosts/wsl/home.nix
            catppuccin.homeManagerModules.catppuccin
            ];
        };

      };

  };
  
}
