{ config, lib, pkgs, ... }:

{ 
  imports = [
    modules/git.nix
    modules/zsh.nix
  ];
  
  #----- Basic home settings --------------------------------------------------#
  home = {
    username = "nixos";
    homeDirectory = "/home/nixos";
    stateVersion = "24.05"; # Please read the comment before changing.

  #----- Installed programs ---------------------------------------------------#
    packages = with pkgs; [
      hello
      lazydocker
      lazygit
      unzip
      neofetch

    ];

  };
  programs.home-manager.enable = true;     # Let home-manager update itself.
  nixpkgs.config.allowUnfree = true;      # Install closed source software.
}
