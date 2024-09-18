{ pkgs, ... }:

{

  programs.git = {
    enable = true;
    userName  = "Ahmed";
    userEmail = "ahmed.mohamed547@gmail.com";
    aliases = {
      ci = "commit";
      co = "checkout";
      s = "status";
      };

  };
}
