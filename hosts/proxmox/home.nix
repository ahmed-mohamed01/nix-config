{ config, lib, pkgs, ... }:

{ 
#----- Include modules ------------------------------------------------------#
  imports = [    # comment out what you don't need
    ../../modules/git.nix    # Enable git and set defaults
    ../../modules/zsh.nix      # Enable zsh and set defaults
    #../../modules/fonts.nix     # Enable nerd fonts
    #../../modules/direnv.nix    # Enable direnv and set defaults
    #../../modules/kitty.nix    # Enable kitty and set defaults
    #../../modules/foot.nix    # Enable foot and set defaults
  ];

#----- Basic home settings --------------------------------------------------#
  home = {
    username = "ahmed";
    homeDirectory = "/home/ahmed";
    stateVersion = "24.05"; # Please read the comment before changing.

#----- Installed programs ---------------------------------------------------#
    packages = with pkgs; [     
    #-- Note that more programs are defined in cli-tools.nix ----------------#
      lazydocker
      lazygit
      unzip
      xz
      fastfetch
      mc
      ripgrep
      just
      tlrc
      yai


    ];

  };
  programs.home-manager.enable = true;     # Let home-manager update itself.
  nixpkgs.config.allowUnfree = true;      # Install clogit sed source software.

}