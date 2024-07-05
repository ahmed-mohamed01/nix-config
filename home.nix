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
  
  programs.fd = {
  	enable = true;
  	hidden = true;
  };
  programs.bat = {
  	enable = true;
  };
  programs.fzf = {
  	enable = true;
  	enableZshIntegration = true;
  	defaultCommand = "fd -t d . $HOME";
  	defaultOptions = [ "--preview 'bat --color=always {}'" ];
  	fileWidgetCommand = "fd -t d . $HOME";
  };
  programs.eza = {
  	enable = true;
  	enableZshIntegration = true;
  	extraOptions = [ "--group-directories-first" "--icons" "--git"];
  };
  programs.zoxide = {
  	enable = true;
  	enableZshIntegration = true;
  	options = [ "--cmd cd"];
  };
  programs.micro = {
  	enable = true;
  	settings = {
  		colorscheme = "default";
  	};
  };
  programs.thefuck = {
  	enable = true;
  	enableZshIntegration = true;
  };

  ##############################################################
  # ZSH settings
  ##############################################################
  programs.zsh = {
    enable = true;
    zplug = {
    	enable = true;
    	plugins = [
    		{ name = "zsh-users/zsh-autosuggestions"; }
    		{ name = "zdharma-continuum/fast-syntax-highlighting"; }
    		{ name = "Aloxaf/fzf-tab"; }
    		{ name = "romkatv/powerlevel10k"; tags = [ as:theme depth:1 ]; }	
    	];
    };
    enableCompletion = true;
    history = {
          ignoreDups = true;
          ignoreSpace = true;
          save = 10000;
          size = 10000;
    };
    defaultKeymap = "emacs";
    ##########################
    # Aliases
    ##########################
    shellAliases = {
        lsd = "eza --icons --tree --dir-only --git-repos --only-dirs --level=3";
        update = "sudo nixos-rebuild switch";
        hs = "home-manager switch";
        c="clear";
        lsa="eza --icons -a -l";
        ssh = "ssh.exe";

    };
    initExtra = ''
          [[ ! -f ${./modules/.p10k.zsh} ]] || source ${./modules/.p10k.zsh}
          [[ ! -e op.exe ]] || alias ssh="ssh.exe"
          bindkey '^p' history-search-backward
          bindkey '^n' history-search-forward

        '';
  };

  ##############################################################
  # Dot file Management
  ##############################################################
  # Home Manager is pretty good at managing dotfiles. The primary way to manage plain files is through 'home.file'.
  home.file = {
    # "~/.config/micro/colorschemes/catppuccin-mocha.micro".source =config.lib.file.mkOutOfStoreSymlink /packages/src/catppuccin-mocha.micro;
  };

  ###########################################################
  # Environmental varialbles
  ##########################################################
  home.sessionVariables = {
    EDITOR = "micro";
    FZF_COMPLETION_TRIGGER= "==";
    MICRO_TRUECOLOR=1;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
