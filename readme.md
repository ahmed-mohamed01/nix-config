# Nix Config

This is the NixOS config using Nix flakes and Home-manager

### 1a. Install Nix package manager on Linux:
```bash
sh <(curl -L https://nixos.org/nix/install) --daemon
```
Install Nix package manager on WSL2:
```bash
sh <(curl -L https://nixos.org/nix/install) --daemon
```

### 1b. Install NixOS

#### On WSL2
```bash
# https://github.com/nix-community/NixOS-WSL

# Enable WSL
wsl --install --no-distribution

# Download the latest release: https://github.com/nix-community/NixOS-WSL/releases

# Import the tarball
wsl --import NixOS $env:USERPROFILE\NixOS\ nixos-wsl.tar.gz

# Run NixOS
wsl -d NixOS

# ----- Post install ---------------------------------------------------------------#
# Update Nix-channel to Unstable / 24.05 to fix the rust error
sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos
sudo nix-channel --update unstable
sudo nixos-rebuild switch

```

#### On VirtualBox:
Follow instructions on: https://nixos.org/download/#nixos-virtualbox
Change RAM, CPU core allocation and ensure atleast 100gigs of storage is assigned. This will ensure it will run smoothly as new builds accumulate.

### 2. Enable Home-manager and flakes
#### On NixOS:
##### Enable flakes and add home-manager module.
```bash
# add these lines to configuration.nix --> by default this is in /etc/nixos/configuration.nix
nix.settings.experimental-features = [ "nix-command" "flakes" ];   # Enable flakes and Home-Manager
# Load the changes
nixos-rebuild switch

# add home manager package ---> temporary, we will switch to flakes shortly. 
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install

```
#### 

#### On Linux
```bash
# Include the following in nix.config file located in /etc/nix/nix.config
extra-experimental-features = flakes
extra-experimental-features = nix-command
```

### 3. Clone this repo
```bash
git clone https://github.com/ahmed-mohamed01/nix-config.git
cd nix-config
```
### 4a. Some important notes

### Ensure you have backed up any configs you are transferring to home-manager. eg if you are enabling zsh, ensure .zshrc is backed up. 
1. If you are on Ubuntu/Pop or any non NixOS linux version, you cannot manage system services (such as docker, tailscale ) using Nix. You will need to configure them normally on the system. 
2. We will be using flakes to set up Home-manager. More on flakes here: https://nixos.wiki/wiki/Flakes
3. More on home manager: 
4. home.nix is how dotfiles and programs on your system would be managed from now on
5. Some important resources: 
- Nix wiki: https://nixos.wiki/wiki/Main_Page
- Nix packages search: https://search.nixos.org/packages
- Nix options: https://search.nixos.org/options? ---> this is only used on configuration.nix
- Home-manager options: https://home-manager-options.extranix.com/  ---> this is used in home.nix
- Excellent starter resource: https://github.com/Evertras/simple-homemanager/blob/main/01-install.md
- Unclutter system and use per-project development environments using direnv: https://direnv.net/
- Faster direnv using nix-direnv: https://github.com/nix-community/nix-direnv
6. Any program that you choose to manage with home-manager would be owned by home-manager, so you cannot modify it outside home manager anymore. eg, if you ac

### 4b. Modify the flake.nix and home.nix
1. Modify the flake.nix and change your username
2. Modify home.nix, comment out and modules you dont want from imports, change nixos to your username / homedir.
3. run ```home-manager switch --flake #[username you put in flake.nix]

Thats it, thats a basic home-manager setup. 