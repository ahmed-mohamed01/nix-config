{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    catppuccin.url = "github:catppuccin/nix"; ## FIX ME: If you dont want catppuccin, remove this line, and the catppuccin.homeManagerModules.catppuccin from home.nix
    #----- Enable if using 1password shell plugins ---------------------------------#
    #_1password-shell-plugins.url = "github:1Password/shell-plugins";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, catppuccin, nixos-wsl, home-manager, ... }: 
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      #imports = [ inputs._1password-shell-plugins.hmModules.default ]; # Enable if using 1password shell plugins
      homeConfigurations = {
        ### FIX ME : change nixos to your username
        nixos = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ 
            ./home.nix
            catppuccin.homeManagerModules.catppuccin
            
            ];
        };
      };
    };
  
}
