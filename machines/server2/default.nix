# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only

  nix = {
    settings.trusted-users = [ "root" "freddy" ];
    settings.max-jobs = 1;
    gc.automatic = true;
    extraOptions = ''
      experimental-features = nix-command flakes ca-references
    '';
  };

  networking.hostName = "server2"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Select internationalisation properties.
  # i18n = {
  #   consoleFont = "Lat2-Terminus16";
  #   consoleKeyMap = "us";
  #   defaultLocale = "en_US.UTF-8";
  # };

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    git nano wget vim
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.bash.enableCompletion = true;
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  system.autoUpgrade = {
    #channel = "https://nixos.org/channels/nixos-unstable";
    dates = "19:30";
    enable = true;
    flake = "github:FRidh/nix-config";
    flags = [
      "--update-input nixpkgs" # Integrate latest nixpkgs during update.
      "--no-write-lock-file" # Cannot write lock file when updating like this.
    ];
  };


  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Enable the X11 windowing system.
  # services.xserver.enable = true;
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable touchpad support.
  # services.xserver.libinput.enable = true;

  # Enable the KDE Desktop Environment.
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.freddy = {
    isNormalUser = true;
    uid = 1000;
    openssh.authorizedKeys.keys = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDK4gaPIK9ZXYsSGcIGUX+Ryf6LGc1N26NreOBe6aUqE7aCMsmzpDQnuH8HN6xocNIZ9zCT3X5J4QCh35JQab6BxehVbHkWmdN4xUyp18EIaNmtt1YpPEXzri4lUy3QCEnqpmiXfuoWPp54Rcr2bBiihdoozYa5wHfnzZzMgVbyM3HWcwLhqisycUoyAPvR7/YOSMz28ltGgVaL9dpLcIfy+NGm6U+cVhFM+8GdYPZj8VAtllN4obtnw6rTHjOcERR2Ju5j6Ecz4mBpvVaTWbYm3fbmaRLmnYDqz5+hK7By/BU3IzN+nM8zMgLVo2lpO2nB9/rBMnD/FSonKySUzriPfUV+fPrV/OrBuUNsoyu6j/3psqn+f0te+7f/vnO+qOdJ6TqpSjMW/VXNNUYuu1gp7dZAZJoOf47kLMb4S/1bsv0iVE4+8/gIAjTkbEnIBdfFnziHlinTfR6OscEubnLuaOM0pcx/HnOSGCslaJGJzCPA89Xc0ORWRBIn9QB/ntfUmM4rwcXIB4LhOx2cSpqCDTtLE5r1c2vunu3z9AqgXVnLwRDmUN9MvscQvu+s/cRe3oHG8NRQ/lrqwLukXcEHOhmVK8J6CP7EuDIyTpF1Hro5r8ZYJpAGKWqol59O8g90gtWkNRsj/+hOrGCmS3tWrZOBzBmfJ9VgkZ39lo602w== freddyrietdijk@fridh.nl" ];
  };

  services.tailscale.enable = true;

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "20.09"; # Did you read the comment?

}
