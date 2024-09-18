# NixOS-WSL specific options are documented on the NixOS-WSL repository:

{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix

  ];
 # Bootloader.
# boot.loader.systemd-boot.enable = true;
# boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.useOSProber = true;
#----Networking-----------------------------------------------------------------#
  networking.hostName = "nixos"; # Define your hostname.
# networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;    # Enable networking

#-----Localization settings-----------------------------------------------------#
  time.timeZone = "Europe/London";            # Set your time zone.
  i18n.defaultLocale = "en_GB.UTF-8";         # Select internationalisation properties.
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
    };
# Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
    };

#----- Applications to be installed systemwide  ---------------------------------#
  environment.systemPackages = with pkgs; [
  	wget
    curl
    micro
    vscode
    git
    telegram-desktop
    home-manager
    _1password-gui
    _1password
    pika-backup
    ulauncher
    
  ];
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    # Certain features, including CLI integration and system authentication support,
    # require enabling PolKit integration on some desktop environments (e.g. Plasma).
    polkitPolicyOwners = [ "ahmed" ];
  };
  
#----- User settings ------------------------------------------------------------#
  programs.zsh.enable = true;    # Install ZSH so it cab be used as default shell
  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;  # Set ZSH as default shell
  
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
    displayManager.sddm.enable = true;      # Enable the KDE Plasma Desktop Environment.
    desktopManager.plasma6.enable = true;
    xserver.xkb = {      # Configure keymap in X11
      layout = "gb";
      variant = "";
      };
    xserver.enable = true;    # Enable the X11 windowing system. \You can disable this if you're only using the Wayland session.
  };

  virtualisation.docker = {
      enable = true;   # Install docker
      rootless ={
        enable = true;   # Enable rootless docker
        setSocketVariable = true;
      };
  };
   
  console.keyMap = "uk";     # Configure console keymap
#----- NixOS settings -----------------------------------------------------------#
  programs = {
    nix-ld = {
      enable = true;
      package = pkgs.nix-ld-rs;
    };

  };
  nix.settings.experimental-features = [ "nix-command" "flakes" ];   # Enable flakes and Home-Manager
  #nixpkgs.config.allowUnfree = true;
  system.stateVersion = "24.05"; # Do not change this value
}
