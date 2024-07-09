# Edit this configuration file to define what should be installed on your system.  
# Help is available in the configuration.nix(5) man page and in the NixOS manual (accessible by running ‘nixos-help’).
{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
#---- Important settings ----------------------------------------------------#
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
#---- Locale settings -------------------------------------------------------#
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
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;   # Enable the GNOME Desktop Environment.
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver = {   # Configure keymap in X11
    layout = "gb";
    xkbVariant = "";
  };

  console.keyMap = "uk";   # Configure console keymap
  hardware.pulseaudio.enable = false;   # Enable sound with pipewire.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;
  # Enable automatic login for the user.
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "ahmed";
  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

#---- User Accounts and user settings --------------------------------#
  users.users.ahmed = {
    isNormalUser = true;
    description = "ahmed";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };
  programs.zsh.enable = true;   # Enable ZSH
  users.defaultUserShell=pkgs.zsh;   # Set ZSH as default Shell for all users.

#---- System wide packages -------------------------------------------#
  environment.systemPackages = with pkgs; [
  	firefox
  	vlc
  	micro
    wget
    git
    zinit
    curl
    vscode
    home-manager
  ];
  # Install fonts systemwide.
  fonts.packages = with pkgs; [
  	meslo-lgs-nf
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
  ];
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    # Certain features, including CLI integration and system authentication support,
    # require enabling PolKit integration on some desktop environments (e.g. Plasma).
    polkitPolicyOwners = [ "ahmed" ];
  };


#---- System services to be enabled -------------------------------------------#
  services.openssh.enable = true;   # Enable the OpenSSH daemon.
  networking.firewall.enable = true;
  networking.networkmanager.enable = true;
  

#---- NixOS specific options --------------------------------------------------#
  programs = {   # Install applications with dynamic libraries.
      nix-ld = {
        enable = true;
        package = pkgs.nix-ld-rs;
      };
  };
  nix.settings.experimental-features = [ "nix-command" "flakes" ];   # Enable flakes and Home-Manager
  nixpkgs.config.allowUnfree = true;   # Allow paid/closed source software
  system.stateVersion = "24.05";  # Do not change this option.

}
