#--- Adapted from https://github.com/Misterio77/nix-starter-configs/blob/main/minimal/flake.nix ----#

{
  description = "Your new nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";       # Nixpkgs

    home-manager.url = "github:nix-community/home-manager/release-24.05";     # Home manager
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ...} @ inputs: 
  let
    inherit (self) outputs;
  in {
    # NixOS configuration entrypoint. Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      # FIXME replace with your hostname
      your-hostname = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [./nixos/configuration.nix];     # > Path to your NixOS configuration file
      };
    };

    # Standalone home-manager configuration entrypoint. Available through 'home-manager --flake .#your-username@your-hostname'
    homeConfigurations = {
      # FIXME replace with your username@hostname
      "your-username@your-hostname" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [./home-manager/home.nix];    # > Path to your home-manager configuration file
      };
    };
  };
}