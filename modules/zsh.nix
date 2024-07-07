{ pkgs, config, ... }:

{ 
  imports = [
    ./cli-tools.nix
  ];
  #----- Misc zsh-related cli programs to be installed -------------------------#
  home.packages =  [          
      pkgs.zinit   # Install zinit
      pkgs.zsh-powerlevel10k
    ];
  
#----- ZSH management ----------------------------------------------------------#
  programs.zsh = {
    enable = true;
    enableCompletion = true;
#----- zplug plugins -----------------------------------------------------------#
    zplug = {
      enable = true;
      plugins = [
        { name = "romkatv/powerlevel10k"; tags = [ as:theme depth:1 ]; }
        { name = "zsh-users/zsh-autosuggestions"; tags = [ defer:3 ];}
        { name = "chisui/zsh-nix-shell"; tags = [ defer:3 ]; }
        { name = "zdharma/fast-syntax-highlighting"; tags = [ defer:3 ]; }
        { name = "Aloxaf/fzf-tab"; tags = [ defer:3]; }
        { name = "plugins/git"; tags = [ from:oh-my-zsh defer:3 ]; }
        { name = "plugins/colored-man-pages"; tags = [from:oh-my-zsh]; }
        { name = "plugins/command-not-found"; tags = [from:oh-my-zsh]; }

      ];
    };
    #----- History settings ----------------------------------------------------#
    history = {
        extended = true;
        share = true;
        ignoreDups = true;
        ignoreSpace = true;
        expireDuplicatesFirst = true;
        save = 10000;
        size = 10000;
    };
    #----- Keymap settings -----------------------------------------------------#
    defaultKeymap = "emacs";
    #----- Aliases -------------------------------------------------------------#
    shellAliases = {
        c="clear";
        lsd = "eza --icons --tree -D --git-repos --level=3";  #list directories
        lsa="eza --icons -a -l";                              #list all
        lst = "eza --icons --tree --level=2";                 #list tree
        eh = "code ~/dotfiles/home.nix";                      #edit home.nix
        es = "code ~/dotfiles/system/configuration.nix";      #edit system.nix
        dothome = "home-manager switch --flake .#nixos";
        dotsys = "sudo nixos-rebuild switch -I nixos-config=system/configuration.nix";
    };
    #----- Settings to be added to the top of .zshrc ---------------------------#
    completionInit = ''
        #autoload -Uz compinit && compinit
        #zinit cdreplay -q
      '';
    initExtra = ''
        export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
        [[ ! -e op.exe ]] || alias ssh="ssh.exe"

        bindkey '^p' history-search-backward
        bindkey '^n' history-search-forward

        [[ ! -f ${./src/zsh/.p10k.zsh} ]] || source ${./src/zsh/.p10k.zsh}
        
        '';
    sessionVariables = {
        FZF_COMPLETION_TRIGGER= "==";
        #POWERLEVEL9K_INSTANT_PROMPT= "quiet";
    };
  };

#----- Environmental variables -------------------------------------------------#
  home.sessionVariables = {
    EDITOR = "code";
  };

#----- Dotfile management ------------------------------------------------------#
  home.file = {
    
  };
}
