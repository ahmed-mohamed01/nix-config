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
      "gpg \"ssh\"" = { program = "/mnt/c/Users/genes/AppData/Local/1Password/app/8/op-ssh-sign-wsl"; };
      core = { sshCommand = "ssh.exe"; };
      commit = { gpgsign = true; };
      init = { defaultBranch = "main"; };
      user  = { signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINRRRql59PulK2duyhpO2kxENi0/eZ1NhBGDgTVcf8ar"; };
    };
  };
}