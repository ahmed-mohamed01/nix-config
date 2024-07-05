{ pkgs, config, ... }:
{ 
  programs.fd = {             # Enable fd and set defaults
  	enable = true;
  	hidden = true;
  };
  programs.bat = {            # Enable bat and set defaults
  	enable = true;
  };
  programs.fzf = {            # Enable fzf and set defaults
  	enable = true;
  	enableZshIntegration = true;
  	defaultCommand = "fd -t d . $HOME";
  	defaultOptions = [ "--preview 'bat --color=always {}'" ];
  	fileWidgetCommand = "fd -t d . $HOME";
  };
  programs.eza = {            # Enable eza and set defaults
  	enable = true;
  	enableZshIntegration = true;
  	extraOptions = [ "--group-directories-first" "--icons" "--git"];
  };
  programs.zoxide = {          # Enable zoxide and set defaults
  	enable = true;
  	enableZshIntegration = true;
  	options = [ "--cmd cd"];
  };
  programs.micro = {           # Enable micro and set defaults
  	enable = true;
  	settings = {
  		colorscheme = "default";
  	};
  };
  programs.thefuck = {
  	enable = true;
  	enableZshIntegration = true;
  };

#----- ZSH management ---------------------------------------------------------#
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
    #----- Aliases -------------------------------------------------------------#
    shellAliases = {
        lsd = "eza --icons --tree --dir-only --git-repos --only-dirs --level=3";
        update = "sudo nixos-rebuild switch";
        hs = "home-manager switch";
        c="clear";
        lsa="eza --icons -a -l";
        ssh = "ssh.exe";

    };
    initExtra = ''
        [[ ! -f ${./src/zsh/.p10k.zsh} ]] || source ${./src/zsh/.p10k.zsh}
        [[ ! -e op.exe ]] || alias ssh="ssh.exe"
        bindkey '^p' history-search-backward
        bindkey '^n' history-search-forward

        '';
  };
#----- Environmental variables -------------------------------------------------#
  home.sessionVariables = {
    EDITOR = "micro";
    FZF_COMPLETION_TRIGGER= "==";
    MICRO_TRUECOLOR=1;
  };

#----- Dotfile management -------------------------------------------------------#
  home.file = {
    "~/.config/micro/colorschemes/catppuccin-mocha.micro".source = config.lib.file.mkOutOfStoreSymlink /modules/src/micro/catppuccin-mocha.micro;
  };
}