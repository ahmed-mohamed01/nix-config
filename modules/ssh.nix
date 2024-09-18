{ pkgs, config, ... }:

{
  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host *
          ForwardAgent no
          AddKeysToAgent no
          Compression no
          ServerAliveInterval 0
          ServerAliveCountMax 3
          HashKnownHosts no
          UserKnownHostsFile ~/.ssh/known_hosts
          ControlMaster no
          ControlPath ~/.ssh/master-%r@%n:%p
          ControlPersist no

      Host arda
          HostName 192.168.8.169
          User root
          Port 22
      
      Host proxmox
          HostName 192.168.8.200
          User root
          Port 22

      Host router
          HostName 192.168.8.1
          User root
          Port 22

      Host pop-vm
          HostName 192.168.8.106
          User ahmed
          Port 22

    '';
  };
}

# ssh keys are stored in 1password, and are loaded by the agent.