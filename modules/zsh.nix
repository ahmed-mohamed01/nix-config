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
    #enableCompletion = true;
    # syntaxHighlighting = {
    #   enable = true;
    #   catppuccin.flavor = "mocha";
    #   catppuccin.enable = true;
    # };
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
        dotsys = "sudo nixos-rebuild switch -I nixos-config=system/configuration.nix";

    };
    #----- Settings to be added to the top of .zshrc ---------------------------#
    initExtraFirst = ''
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      source ${pkgs.zinit}/share/zinit/zinit.zsh  # ---> # Load zinit
    '';
    completionInit = ''
        autoload -Uz compinit && compinit
        zinit cdreplay -q
      '';
    initExtra = ''
        # zinit ice depth=1; zinit light romkatv/powerlevel10k    # Install powerlevel10k
        zinit light zdharma-continuum/fast-syntax-highlighting
        zinit light zsh-users/zsh-completions
        zinit light zsh-users/zsh-autosuggestions
        zinit light chisui/zsh-nix-shell
        zinit light Aloxaf/fzf-tab
        zinit snippet OMZP::git
        zinit snippet OMZP::sudo
        zinit snippet OMZP::command-not-found
        zinit snippet OMZP::nvm
        zinit snippet OMZP::colored-man-pages

        [[ ! -e op.exe ]] || alias ssh="ssh.exe"

        bindkey '^p' history-search-backward
        bindkey '^n' history-search-forward

        [[ ! -f ${./src/zsh/.p10k.zsh} ]] || source ${./src/zsh/.p10k.zsh}

        '';
    sessionVariables = {
        ZSH_AUTOSUGGEST_STRATEGY = ["history" "completion"];
        FZF_COMPLETION_TRIGGER= "==";
        POWERLEVEL9K_INSTANT_PROMPT= "quiet";
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
