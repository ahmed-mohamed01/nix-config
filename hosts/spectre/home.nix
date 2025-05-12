{ config, lib, pkgs, ... }:

{ 
#----- Include modules ------------------------------------------------------#
  imports = [    # comment out what you don't need
    ../../modules/git.nix    # Enable git and set defaults
    ../../modules/zsh.nix      # Enable zsh and set defaults
   # ../../modules/fonts.nix     # Enable nerd fonts
    ../../modules/direnv.nix    # Enable direnv and set defaults
    ../../modules/kitty.nix
  ];

#----- Basic home settings --------------------------------------------------#
  home = {
    username = "ahmed";
    homeDirectory = "/home/ahmed";
    stateVersion = "24.11"; # Please read the comment before changing.

#----- Installed programs ---------------------------------------------------#
    packages = with pkgs; [     
    #-- Note that more programs are defined in cli-tools.nix ----------------#
      hello
      lazydocker
      lazygit
      unzip
      neofetch
      mc
      ripgrep
      vscode
      anki
      mtr-gui
      windsurf

    ];

  };
  programs.home-manager.enable = true;     # Let home-manager update itself.
  nixpkgs.config.allowUnfree = true;      # Install closed source software.

}
