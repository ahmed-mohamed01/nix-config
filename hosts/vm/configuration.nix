# Edit this configuration file to define what should be installed on your system. nixos --help
{ config, pkgs, ... }: 
{
  imports = [
    # ./hardware-configuration.nix # Include the results of the hardware scan.
    <nixpkgs/nixos/modules/installer/virtualbox-demo.nix>
  ];

  #---- System locale settings ---------------------------------------------------#
  networking.hostName = "nixos-virt2"; # Define your hostname.

  time.timeZone = "Europe/London"; # Set your time zone.
  i18n.defaultLocale = "en_GB.UTF-8"; # Select internationalisation properties
  console.keyMap = "uk"; # Configure console keymap

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
  # hardware.pulseaudio.enable = false;
  # security.rtkit.enable = true;
  # services.pipewire = {
  #   enable = true;
  #   alsa.enable = true;
  #   alsa.support32Bit = true;
  #   pulse.enable = true;
  # };

  #---- User settings ------------------------------------------------------------#
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ahmed = {
    isNormalUser = true;
    description = "ahmed";
    extraGroups = ["networkmanager" "wheel"];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINRRRql59PulK2duyhpO2kxENi0/eZ1NhBGDgTVcf8ar"
    ];
    shell = pkgs.zsh;
    initialPassword = "pw";
    packages = with pkgs; [
      kdePackages.kate
      home-manager    
    ];
  };

  #---- System-wide installs -----------------------------------------------------#
  environment.systemPackages = with pkgs; [
    vlc
    curl
    wget
    vscode
    git
    htop
    firefox
    tailscale
    micro
    zsh
    home-manager
  ];

  #---- Essential programs to be managed system-wide -----------------------------#
  programs = {
    zsh.enable = true; # Enable ZSH here to avoid errors when default shell is declared.
    # _1password.enable = true; # ZSH settings managed in home manager.
    # _1password-gui = {
    #   enable = true;
    #   polkitPolicyOwners = ["ahmed" "nixos"]; # Allow users to run the GUI.
    # };
  };

  #---- System Servivces ---------------------------------------------------------#
  programs.hyprland.enable = true;
  services = {
    openssh.enable = true; # Enable SSH daemon
    tailscale.enable = true; # Enable Tailscale
    # displayManager.sddm.enable = true; # Enable the KDE Plasma Desktop Environment.
    # desktopManager.plasma6.enable = true;
    xserver = {
      enable = true; # You can disable this if you're only using the Wayland session.
      xkb.layout = "gb"; # Set the keyboard layout.
      xkb.variant = ""; # Set the keyboard variant.
    };
    printing.enable = true;                # Enable printing service
    # openssh.settings = {
    #   PermitRootLogin = "no";
    #   PasswordAuthentication = false;
    #   AllowUsers = ["ahmed" "nixos"];
    # };
  };
  virtualisation.virtualbox.guest.enable = true; # Enable VirtualBox guest editions
  # networking = {
  #   networkmanager.enable = true; # Enable networking
  #   wireless.enable = true; # Enable wireless networking
  # };

  #---- Nix OS specific settings -------------------------------------------------#
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];
  programs.nix-ld = {
    # Enable installation of dynamic libraries for Nix programs.
    enable = true;
    package = pkgs.nix-ld-rs;
  };
  system.stateVersion = "24.05"; # Keep this as is unless you understand what you're doing
}
