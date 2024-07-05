{ config, lib, pkgs, ... }:

{ 
  imports = [
    modules/git.nix
  ];
  ###############################################################
  # Basic home.manager settings
  ###############################################################
  home.username = "nixos";
  home.homeDirectory = "/home/nixos";
  home.stateVersion = "24.05"; # Please read the comment before changing.

  #-----------------------------------------------------------------#
  #################################################################
  # Packages installed in this environment
  #################################################################
  # The home.packages option allows you to install Nix packages into your environment.
  home.packages = with pkgs; [
    hello

  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
