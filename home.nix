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
    ];

  };
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;
}
