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
    extraConfig = {
      gpg = { format = "ssh"; };
      commit = { gpgsign = true; };
      init = { defaultBranch = "main"; };
      user  = { signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINRRRql59PulK2duyhpO2kxENi0/eZ1NhBGDgTVcf8ar"; };
    };
  };
}