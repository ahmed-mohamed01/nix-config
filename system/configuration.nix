
# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL

{ config, lib, pkgs, ... }:
########################################################################################
{
  imports = [
    # include NixOS-WSL modules
    <nixos-wsl/modules>
    <home-manager/nixos>
    #inputs.home-manager.nixModules.default
  ];

  wsl.enable = true;
  wsl.defaultUser = "nixos";
  environment.systemPackages = with pkgs; [
  	wget
  	git
  	curl
    home-manager
    tailscale
    zsh
    htop
    ctop
    rm-improved

  ];
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  users.users.ahmed = {
  	isNormalUser = true;
  	description = "Ahmed User acc";
  	##passwd = "gg";
  	extraGroups = [ "networkmanager" "wheel" "docker" ];
    #openssh.authorizedKeys.keys = [
    ##  "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINRRRql59PulK2duyhpO2kxENi0/eZ1NhBGDgTVcf8ar"
    #];
  	packages = with pkgs; [	
      
  	];
  };
  # Enable installation of dynamic libraries for Nix programs.
  programs = {
    nix-ld = {
      enable = true;
      package = pkgs.nix-ld-rs;
     };
    ## _1password = {
    #  enable = true;
    #  };

  };
  
  # Enable the OpenSSH daemon.
  services.openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
        #AuthorizedKeysCommand = "/usr/bin/1password-get-ssh-key";
        AllowUsers = [ "ahmed" "nixos" ];
        #sshCommand = "ssh.exe";
      };
  };
  
  # Enable flakes and Home-Manager
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  services.tailscale.enable = true;        # Enable tailscale

  # Before changing this value read the documentation for this option (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
