# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
    ];
 
#  boot.initrd.availableKernelModules = [ "ata_piix" "uhci_hcd" "virtio_pci" "virtio_blk" ];
#  boot.kernelModules = [ ];
   boot.kernelPackages = pkgs.linuxPackages_latest;
#  boot.extraModulePackages = [ ];

#  fileSystems."/" =
#    { device = "/dev/disk/by-uuid/3bfac6ee-0348-438a-95fd-311cf80b28da";
#      fsType = "ext4";
#    };

  #swapDevices = [ 
  #  { label = "swap"; }
  #];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/vda";

  boot.initrd.checkJournalingFS = false;

  networking = {
    hostName = "server1"; # Define your hostname.
    #publicIPv4 = "78.46.129.86";
  };

  nixpkgs.config = {
    enableParallelBuilding = true;
    allowUnfree = true;
  };

  nix.trustedBinaryCaches = [ http://hydra.nixos.org ];
  nix.binaryCachePublicKeys = [ "hydra.nixos.org-1:CNHJZBh9K4tP3EKF6FkkgeVYsS3ohTl+oS0Qa8bezVs=" ];
  # Select internationalisation properties.
  # i18n = {
  #   consoleFont = "lat9w-16";
  #   consoleKeyMap = "us";
  #   defaultLocale = "en_US.UTF-8";
  # };

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  #services.virtualboxGuest.enable = true;
  # virtualisation.virtualbox.guest.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Redmine
  #services.postgresql = {
  #  enable = true;
  #};
  #services.redmine = {
  #  enable = true;
  #  databasePassword = "somerandompassword";
  #};

  # Keep system up to date
  system.autoUpgrade.enable = true;

  users.extraUsers.freddy = {
    isNormalUser = true;
#    uid = 1000;
    home = "/home/freddy";
    description = "Freddy Rietdijk";
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAAEAQDXkFgzKmwzbtatuQwinQaZ57N/UGgM00yKmcGikeNUhhnsjL/W/xBlrokipnQLL0l9OZpGyoeCPeeKyDA5J04sx9oY3P+3JA5lwGcP0wBY/7huKJNduByJv2AQwEZTVwV/JAb29sd+4ggcTvxFgcSnl/GfwvK9sqLSds+5JMKtkgufcf+XjeHcJoDyGr91lu0lt6gmLRXQA7yYmWyUaCm587jsmTb52dp+ADwPEww2JGJ25igDgI9PRyVmGMe2lfZv2861zUkkYWpcHQ403oNnZJr9PCnfuYZAwyRLwvCX5BNoUyC/2x3iXegYb63sO6U8ppfCmtEr/RSfuYbfkNVITIFq8KULnaElfCa7lkFLFqXt1nLlUw6AP0/sWJhjWIlnMthK1vl+mi4W6f+TcDU7jnNILNrQt2jmHvTctBgLvbnaLqO6/CpRaNmp4FhM/aqqBI4Co8D7uK1/gx2oEwi/cZpgJsfOvLqusBUBVcUpubFbk82Tk41Masr0guj25LZyjbthQBbTRM6r0s9LFVAEZnBxVq0sbkIwcP+EciLEkum2iNBMPoMtc8wCe7lu9WHqcyptGOUpGinwF/HQoowww3hHz9bBhwzTUZRGb7ELreLfQVv4KdCwJ+CxJlZZ6K0GWj4jf+P6rtKXSnefHGM6NqeNLPgzjzCZG1Egq2QfuPpjxhbZvspk3xn53Lkcliomgit/HPCVZlcb+1HTQPNbmfKaL9wQU/ZFMCs6af8tGoAtyGshNEuHavFiZdpeaJi5KKS1TtQkUaeAMHWLLBhTQGVqb15y5I90SpIkWZ7eF61ZWr2BnI73PSuPiNgFdRD63lxInaSzQjzWNfxYsWw51dVPXL6E5iY5FFFgVOrZQrybWoLCNYb++sFk3YghrqK1+IUHsCqe0WQwJN7Z9WEVYgumpr5BuV+bUZYR2ySh8PWfNYzKeCqaHsCyWN1Aj2iDT08apPUJFTgnwPmiWweUP5KQZ+5HO4rQFuLN7pMQFYeS+z0ax1JDE4TiuD7SCHzcUn2klqstIdkblZsRWtI9KMYLi7mZY0mFFXhcHHaIZ5JVAmKM9wVOqxSMqFLQKL7APqq9wPMyT5LSH+bkjE4aE1fiuQFI7MSdFSEN1BxKQf7KKCIPIv+lRW02x6j2bL8P5Al2Fje1uQtaMousV1xTvj2kTnwfJ7UzQhN5marADyAYUu13KqwVL4l8e9EHqaIWBDMug3CVR4nCylUqZsu6vuMnbXxDZdBXnAOfV55owiYQmoqvpO90UOfjtS9GucW7VvDeFLwSM21QAVPCGx/KKo1JxJKVbVImA4UrY1Oy/uGsvnCJbctdqekjBW+embBN1mvZ5jUPvRQMBSpW+CXD laptop" ];
  };

  # List services that you want to enable:
  environment.systemPackages = with pkgs; [ 
    git
    nixopsUnstable
    nox
    tmux
    wget
    unzip
  ];
}

