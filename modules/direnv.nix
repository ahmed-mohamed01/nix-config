{ pkgs, ... }:
  
  {
    programs.direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
      config = {
        global = { hide_env_diff = true; };    # Hid the diff of the environment variables when direnv is loaded
        whitelist = { prefix = [ "~/repos" ]; };   # Direnv will autoload in these directories
      };
    };
  }