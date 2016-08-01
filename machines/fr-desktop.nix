# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = false;
  boot.loader.grub.version = 2;
  # Define on which hard drive you want to install Grub.
  # boot.loader.grub.device = "/dev/sda";
#  boot.loader.gummiboot.enable = true;
  boot.loader.systemd-boot.enable = true;
#  boot.loader.efi.efibootmgr.enable = true;
 boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_4_4;

  nix = {
    binaryCachePublicKeys = [ "hydra.nixos.org-1:CNHJZBh9K4tP3EKF6FkkgeVYsS3ohTl+oS0Qa8bezVs=" "headcounter.org:/7YANMvnQnyvcVB6rgFTdb8p5LG1OTXaO+21CaOSBzg=" ];
    trustedBinaryCaches = [ "https://hydra.nixos.org/" "https://headcounter.org/hydra/" ];
    extraOptions = ''
      gc-keep-outputs = true
      gc-keep-derivations = true
    '';
    nixPath = [ "/etc/nixos" "nixos-config=/etc/nixos/configuration.nix" ]; # Use own repository!
    useChroot = true;
    maxJobs = 4;
  };

  networking.hostName = "fr-desktop"; # Define your hostname.
  networking.extraHosts = ''
    192.168.1.100 fr-laptop
  '';
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;

  hardware.pulseaudio = {
    enable = true;
    support32Bit = true;
    package = pkgs.pulseaudioFull;
  };

  hardware.opengl = {
    driSupport = true;
    driSupport32Bit = true;
  };

  # Select internationalisation properties.
  # i18n = {
  #   consoleFont = "Lat2-Terminus16";
  #   consoleKeyMap = "us";
  #   defaultLocale = "en_US.UTF-8";
  # };
  hardware.bluetooth.enable = true;

  nixpkgs.config = {
    allowUnfree = true;
    firefox = {
      enableGoogleTalkPlugin = true;
      enableAdobeFlash = true;
    };
  };

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    firefox-bin
    git
    git-cola
    #google-chrome
    iftop
    iotop    
    openttd
    pavucontrol
    spotify
    steam
    tmux 
    unzip
    wget
    vlc_qt5
    zip
  ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.xkbOptions = "eurosign:e";
  services.xserver.videoDrivers = ["nvidia"];

  # Enable the KDE Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.kde5.enable = true;

  users.extraUsers.freddy = {
    isNormalUser = true;
    uid = 1000;
    home = "/home/freddy";
    description = "Frederik Rietdijk";
    extraGroups = [ "wheel" "networkmanager" "audio" ];
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.extraUsers.guest = {
  #   isNormalUser = true;
  #   uid = 1000;
  # };

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "16.09";

}
