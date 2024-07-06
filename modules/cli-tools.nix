{ config, ...}:
{
  programs = {
    # #----- Bat and related settings ----------------------------------------------------#
    bat = {
      enable = true;
      theme = {
        dracula = {
          src = pkgs.fetchFromGitHub {
            owner = "dracula";
            repo = "sublime"; # Bat uses sublime syntax for its themes
            rev = "26c57ec282abcaa76e57e055f38432bd827ac34e";
            sha256 = "019hfl4zbn4vm4154hh3bwk6hm7bdxbr1hdww83nabxwjn99ndhv";
          };
          file = "Dracula.tmTheme";
        };
      }; 
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
    #----- ranger related settings ------------------------------------------------0------#
    ranger = {
      enable = true;
      plugins = [
        [
          {
            name = "zoxide";
            src = builtins.fetchGit {
              url = "https://github.com/jchook/ranger-zoxide.git";
              rev = "363df97af34c96ea873c5b13b035413f56b12ead";
            };
          }  
        ]
      ]
    };

  };

  #----- Misc cli programs to be installed -----------------------------------------------#
  home.packages = with pkgs [          # Install zinit
      zinit
      mc
      speedtest-cli
    ];
  #----- fzfand related settings ---------------------------------------------------------#
  home.file = {     # Set theme. 
    enable = true;
    source = "./src/micro/catppuccin-mocha.micro";
    target = "~/.config/micro/colorschemes/catppuccin-mocha.micro";
  };
  #----- Micro theme settings ------------------------------------------------------------#
  home.file = {
    enable = true;
    source = "./src/mc/dracula256.ini";
    target = "~/.config/mc/skins/dracula256.ini";
  };
  micro.settings = { colorscheme = catppuccin-mocha };
  home.sessionVariables = {
    MICRO_TRUECOLOR=1;
  };

}