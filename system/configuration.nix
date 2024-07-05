
# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL

{ config, lib, pkgs, ... }:

{
  imports = [
    <nixos-wsl/modules>    # include NixOS-WSL modules
    <home-manager/nixos>

  ];
#----- WSL settings -------------------------------------------------------------#
  wsl.enable = true;
  wsl.defaultUser = "nixos";

#----- Applications to be installed systemwide  ---------------------------------#
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
    speedtest-cli
    
  ];
#----- User settings ------------------------------------------------------------#
  programs.zsh.enable = true;    # Install ZSH so it cab be used as default shell
  users.defaultUserShell = pkgs.zsh;   # Set ZSH as default shell
  users.users.ahmed = {
  	isNormalUser = true;
  	description = "Ahmed User acc";
  	extraGroups = [ "networkmanager" "wheel" "docker" ];
  	packages = with pkgs; [	   # Install user packages. 
       
  	];
  };

#----- System services ----------------------------------------------------------#
  services = {
    openssh = {    # OpenSSH settings
      enable = true;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
        AllowUsers = [ "ahmed" "nixos" ];
      };
      };
    tailscale.enable = true;    # Enable tailscale
  };

#----- NixOS settings -----------------------------------------------------------#
  programs = {
    nix-ld = {
      enable = true;
      package = pkgs.nix-ld-rs;
    };

  };
  nix.settings.experimental-features = [ "nix-command" "flakes" ];   # Enable flakes and Home-Manager
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "23.11"; # Do not change this value
}
