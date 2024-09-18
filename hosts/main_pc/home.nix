{ config, lib, pkgs, ... }:

{ 
  imports = [
    #--- Import modules  # --------------------------------------------------------#       
    ../../modules/git.nix
    # modules/foot.nix
    ../../modules/kitty.nix
    ../../modules/1password.nix
    ../../modules/zsh.nix     # Also includes settings for bat, micro, fzf, eza etc
    # ../../modules/variables.nix
  ];

  #--- Basic home.manager settings  # ---------------------------------------------#
  home.username = "ahmed";
  home.homeDirectory = "/home/ahmed/";
  home.stateVersion = "24.05"; # Please read the comment before changing.

  #--- Packages installed in this environment  # ----------------------------------#
  fonts.fontconfig.enable = true;             # Enables font installation
  home.packages = with pkgs; [
    latte-dock
      curl
      (pkgs.nerdfonts.override { fonts = [ "FiraCode" "Meslo" "JetBrainsMono" ]; })
  ];
  
  #--- Dotfile management  & misc symlinks # --------------------------------------#
  home.file = {
  # ~/.config/micro/colorschemes/catppuccin-mocha.micro".source =config.lib.file.mkOutOfStoreSymlink /packages/src/catppuccin-mocha.micro;
    
  };
  # Let Home Manager install and manage itself.
  nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true; 

}
