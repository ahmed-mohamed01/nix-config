
{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

#----- Basic system settings -----------------------------------------------------------------------#
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

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

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "gb";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "uk";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

  };

#---- Define a user account. Don't forget to set a password with ‘passwd’.--------------------------#
  users.users.ahmed = {
    isNormalUser = true;
    description = "ahmed";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
      kdePackages.kate
      firefox

    ];
  };


#---- List packages installed in the system.--------------------------------------------------------#
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
    remmina
    cifs-utils
    fastfetch
    neofetch
    htop
    #libsForQt5.qtstyleplugin-kvantum   # Kvantum theme engine
    kdePackages.qtstyleplugin-kvantum
  ];
  
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "ahmed" ];    # Allow user to run 1password-gui
  };
  #----- User settings ------------------------------------------------------------#
  programs.zsh.enable = true;    # Install ZSH so it cab be used as default shell
  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;  # Set ZSH as default shell
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

#---- # List services that you want to enable: -----------------------------------#
  virtualisation.docker.enable = true;
  services.tailscale.enable = true;    # Enable tailscale

#---- SAMBA settings -------------------------------------------------------------#

  # For mount.cifs, required unless domain name resolution is not needed.
  fileSystems."/mnt/NAS" = {
    device = "//192.168.8.169/NAS";
    fsType = "cifs";
    options = let
      # this line prevents hanging on network split
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s,user,users";


    in ["${automount_opts},credentials=/etc/nixos/smb-secrets,uid=1000,gid=100"];
  };
  fileSystems."/mnt/Media" = {
    device = "//192.168.8.169/data";
    fsType = "cifs";
    options = let
      # this line prevents hanging on network split
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s,user,users";

     # Dont forget to place the credentials file in /etc/nixos/smb-secrets
    in ["${automount_opts},credentials=/etc/nixos/smb-secrets,uid=1000,gid=100"];
  };

#----- NixOS settings ------------------------------------------------------------#
  programs = {
    nix-ld = {
      enable = true;
      package = pkgs.nix-ld-rs;
    };

  };
  nix.settings.experimental-features = [ "nix-command" "flakes" ];   # Enable flakes and Home-Manager
#------ Firewall settings ---------------------------------------------------------# 
  # Open ports in the firewall.
  networking.firewall.extraCommands = ''iptables -t raw -A OUTPUT -p udp -m udp --dport 137 -j CT --helper netbios-ns''; # Allow netbios-ns
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  system.stateVersion = "24.05"; # Did you read the comment?

}
