{ pkgs, lib, ... }: 

#----- Enable if using 1password shell plugins ---------------------------------#
#----- this is only for NiOS installatoins, OUTSIDE of WSL ---------------------#
#----- https://nixos.wiki/wiki/1Password ---------------------------------------#
let
  # onePassPath = "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock";
  onePassPath = "~/.1password/agent.sock";
in {
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = ["ahmed" "nixos" ];
  };
  programs._1password-shell-plugins = {
    # enable 1Password shell plugins for bash, zsh, and fish shell
    enable = true;
  };
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
        signingKey = "...";   #--- Add your signing key here
      };
    };
  };
}
