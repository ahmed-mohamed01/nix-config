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
  #----- Set micro theme  ----------------------------------------------------------------#
  # home.file."catppuccin-mocha.micro" = {
  #   enable = true;
  #   source = "./src/micro/catppuccin-mocha.micro";
  #   target = "~/.config/micro/skins/catppuccin-mocha.micro";
  # };
  #----- Midnight commander theme settings -----------------------------------------------#
  # home.file."dracula.ini" = {
  #   enable = true;
  #   source = "./src/mc/dracula256.ini";
  #   target = "~/.config/mc/dracula256.ini";
  # };

  #----- Set micro settings --------------------------------------------------------------#
  # programs.micro.settings = { 
  #   colorscheme = "catppuccin-mocha";
  # };
  home.sessionVariables = {
    MICRO_TRUECOLOR=1;
  };

}