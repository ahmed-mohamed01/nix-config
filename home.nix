{ config, lib, pkgs, ... }:

{ 
  imports = [
    modules/git.nix    # Enable git and set defaults
    modules/zsh.nix      # Enable zsh and set defaults
    modules/fonts.nix     # Enable nerd fonts
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
