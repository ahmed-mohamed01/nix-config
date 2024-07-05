{ pkgs, config, ... }:

let
  ZINIT_HOME = "$HOME/.local/share/zinit/zinit.git";
in
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
  home.packages = [
    pkgs.zinit
  ];

#----- ZSH management ----------------------------------------------------------#
  programs.zsh = {
    enable = true;
    #enableCompletion = true;
    history = {
        extended = true;
        share = true;
        ignoreDups = true;
        ignoreSpace = true;
        expireDuplicatesFirst = true;
        save = 10000;
        size = 10000;
    };
    defaultKeymap = "emacs";
    #----- Aliases -------------------------------------------------------------#
    shellAliases = {
        lsd = "eza --icons --tree -D --git-repos --level=3";
        update = "sudo nixos-rebuild switch";
        hs = "home-manager switch";
        c="clear";
        lsa="eza --icons -a -l";
        lst = "eza --icons --tree --level=2";
        eh = "code ~/dotfiles/home.nix";
        es = "code ~/dotfiles/system/configuration.nix";
        ssh = "ssh.exe";
        dothome = "home-manager switch --flake .#nixos";
        dotsys = "nixos-rebuild boot -I nixos-config=system/configuration.nix";

    };
    # Settings to be added to the top of .zshrc
    initExtraFirst = ''
    '';
    initExtraBeforeCompInit = ''
    '';
    initExtra = ''
        source ${pkgs.zinit}/share/zinit/zinit.zsh
        zinit ice depth=1; zinit light romkatv/powerlevel10k    # Install powerlevel10k
        zinit light zdharma-continuum/fast-syntax-highlighting
        zinit light zsh-users/zsh-completions
        zinit light zsh-users/zsh-autosuggestions
        zinit light Aloxaf/fzf-tab
        zinit snippet OMZP::git
        zinit snippet OMZP::sudo
        zinit snippet OMZP::command-not-found
        zinit snippet OMZP::nvm
        zinit snippet OMZP::colored-man-pages
        export ZSH_AUTOSUGGEST_STRATEGY=(history completion)

        [[ ! -e op.exe ]] || alias ssh="ssh.exe"

        bindkey '^p' history-search-backward
        bindkey '^n' history-search-forward

        [[ ! -f ${./src/zsh/.p10k.zsh} ]] || source ${./src/zsh/.p10k.zsh}

        '';
  };

#----- Environmental variables -------------------------------------------------#
  home.sessionVariables = {
    EDITOR = "micro";
    FZF_COMPLETION_TRIGGER= "==";
    MICRO_TRUECOLOR=1;

  };

#----- Dotfile management ------------------------------------------------------#
  home.file = {
    "~/.config/micro/colorschemes/catppuccin-mocha.micro".source = config.lib.file.mkOutOfStoreSymlink /modules/src/micro/catppuccin-mocha.micro;
  };
}