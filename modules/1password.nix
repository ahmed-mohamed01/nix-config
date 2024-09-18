{ pkgs, lib, ... }: 

#----- Enable if using 1password shell plugins ---------------------------------#
#----- this is only for NiOS installatoins, OUTSIDE of WSL ---------------------#
#----- https://nixos.wiki/wiki/1Password ---------------------------------------#
let
  # onePassPath = "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock";
  onePassPath = "~/.1password/agent.sock";
in {
  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host *
          IdentityAgent ${onePassPath}
    '';
  };
  programs.git = {
    enable = true;
    extraConfig = {
      gpg = {
        format = "ssh";
      };
      "gpg \"ssh\"" = {
        program = "${lib.getExe' pkgs._1password-gui "op-ssh-sign"}";
      };
      commit = {
        gpgsign = true;
      };

      user = {
        signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINRRRql59PulK2duyhpO2kxENi0/eZ1NhBGDgTVcf8ar"; };   #--- Add your signing key here
      };
    };
  };
}
