{ config, pkgs, ...}:
{
  programs = {
    # #----- Bat and related settings ----------------------------------------------------#
    bat = {
      enable = true;
    };
    #----- Fd and related settings -------------------------------------------------------#
    fd = {
      enable = true;
      hidden = true;
    };
    #----- Direnv and related settings ---------------------------------------------------#
    direnv.enableZshIntegration = true;
    #----- fzf nd related settings -------------------------------------------------------#
    fzf = {            
      enable = true;
      enableZshIntegration = true;
      defaultCommand = "fd -t d . $HOME";
      defaultOptions = [ "--preview 'bat --color=always {}'" ];
      fileWidgetCommand = "fd -t d . $HOME";
    };
    #----- eza and related settings ------------------------------------------------------#
    eza = {            
      enable = true;
      enableZshIntegration = true;
      extraOptions = [ "--group-directories-first" "--icons" "--git"];
    };
    #----- zoxide and related settings ---------------------------------------------------#
    zoxide = {          
      enable = true;
      enableZshIntegration = true;
      options = [ "--cmd cd"];
    };
    #----- micro and related settings ----------------------------------------------------#
    micro = {           
      enable = true;
      settings = {
        mkparents = true;
      };
    };
    #----- thefuck and related settings --------------------------------------------------#
    thefuck = {
      enable = true;
      enableZshIntegration = true;
    };

  };
#--------------------------------------------------------------------------------------------#
  #----- Set Catppuccin theme globally ---------------------------------------------------#
  catppuccin = {
    enable = true;
    accent = "blue";
    flavor = "mocha";
    pointerCursor = {
      enable = true;
      accent = "sapphire";
      flavor = "mocha";
    };
  };

  #----- Midnight commander theme settings -----------------------------------------------#
  # home.file."dracula.ini" = {
  #   enable = true;
  #   source = "./src/mc/dracula256.ini";
  #   target = "~/.config/mc/skins/dracula256.ini";
  # };

  home.sessionVariables = {
    MICRO_TRUECOLOR=1;
  };

}