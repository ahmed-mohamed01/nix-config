
# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL
# https://nix-community.github.io/NixOS-WSL/index.html

{ config, lib, pkgs, ... }:

{
  imports = [
    #<nixos-wsl/modules>    # include NixOS-WSL modules
    #<home-manager/nixos>

  ];
#----- WSL settings -------------------------------------------------------------#
  wsl.enable = true;
  wsl.defaultUser = "nixos";
  networking.hostName = "nixos-wsl"; # Define your hostname.
  #wsl.docker-desktop.enable = true;

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
    nmap
    mtr
    
  ];
  
#----- User settings ------------------------------------------------------------#
  programs.zsh.enable = true;    # Install ZSH so it cab be used as default shell
  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;  # Set ZSH as default shell
  #users.groups.norm.gid = 1002;
  users.users.nixos = {
    #shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" "docker" ];  # Add user to additional groups
  };   
  users.users.ahmed = {
  	isNormalUser = true;
    #group = "norm"
  	description = "Ahmed User acc";
    hashedPassword = "$y$j9T$XcCSSmXlX3VngpxBz/0JW/$tUgmZH9kWGWbCgk4a7meLpz1jDd8G38k.yOVfxp5ofB";
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
  virtualisation.docker = {
      enable = true;   # Install docker
      rootless ={
        enable = true;   # Enable rootless docker
        setSocketVariable = true;
      };
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
  system.stateVersion = "24.05"; # Do not change this value
}
