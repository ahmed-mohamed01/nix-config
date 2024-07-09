{
  description = "My main config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";   # Change this to 'nixos-24.05' for a stable release.
    home-manager = {    # Enable home-manager input
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #----- Other custom inputs ---------------------------------------------------------------------------------#
    nixos-wsl = {    # Enable if using NixOS-WSL
      url = "github:nix-community/NixOS-WSL/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };    
    #_1password-shell-plugins.url = "github:1Password/shell-plugins";   # Enable if using 1password shell plugins
    catppuccin.url = "github:catppuccin/nix";     # Enable if using catppuccin's home-manager modules

  };
                               
  outputs = { self, nixpkgs, catppuccin, nixos-wsl, home-manager, ... }@inputs:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";    # Change this to "x86_64-darwin" for macOS
      pkgs = import nixpkgs { inherit system; };
      #inherit (self) outputs;
    in {
      #imports = [ inputs._1password-shell-plugins.hmModules.default ];   # Enable if using 1password shell plugins

  #----- NixOS configurations, identified via hostname --------------------------------------------------------#
    #---- Available through 'nixos-rebuild --flake .#your-hostname' -------------------------------------------#

      nixosConfigurations = {
        #----- WSL configuration ------------------------------------------------------------------------------#
        nixos = nixos-wsl.nixosSystem {
          inherit pkgs;
          #specialArgs = {inherit inputs outputs;};
          modules = [
            nixos-wsl.nixosModules.default { wsl.enable = true; }
            ./hosts/wsl/configuration.nix
          ];
        };

        #----- Virtual Box VM config --------------------------------------------------------------------------#
        vm = nixpkgs.lib.nixosSystem {
          inherit pkgs;
          #specialArgs = {inherit inputs outputs;};
          modules = [ ./hosts/vm/configuration.nix ];
        };

        #----- TODO: Spectre configuration --------------------------------------------------------------------#
        #----- TODO: Main desktop configuration ---------------------------------------------------------------#
      };

  #----- Home manbager configurations, identified via hostname ------------------------------------------------#
    #---- Available through 'home-manager --flake .#your-username@your-hostname' ------------------------------#

      homeConfigurations = {
       #---- WSL config, managed via home-manager -------------------------------------------------------------#
        wsl = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ 
            ./hosts/wsl/home.nix    # WSL specific home-manager settings, incl git, 1password, etc.
            catppuccin.homeManagerModules.catppuccin
            ];
        };
        #---- Virtual box config, managed via home-manager ----------------------------------------------------#
        demo = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ 
            ./hosts/vm/home.nix
            catppuccin.homeManagerModules.catppuccin
            ];
        };
      };
  };  
}
