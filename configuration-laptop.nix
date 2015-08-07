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
  boot.loader.grub.version = 2;
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/sda";

  boot.initrd.checkJournalingFS = false;

  networking.hostName = "nixos"; # Define your hostname.
  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.



  nixpkgs.config = {
    allowUnfree = true;
    chromium = {
      enablePepperFlash = true;
      enablePepperPDF = true;
      enableWideVine = true;
	};
  };


  # Select internationalisation properties.
  # i18n = {
  #   consoleFont = "lat9w-16";
  #   consoleKeyMap = "us";
  #   defaultLocale = "en_US.UTF-8";
  # };

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  # environment.systemPackages = with pkgs; [
  #   wget
  # ];

  # List services that you want to enable:

  services.virtualboxGuest.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.xkbOptions = "eurosign:e";

  # Enable the KDE Desktop Environment.
  services.xserver.displayManager.kdm.enable = true;
  services.xserver.desktopManager.kde5.enable = true;

  # Keep system up to date
  # system.autoUpgrade.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.extraUsers.guest = {
  #   isNormalUser = true;
  #   uid = 1000;
  # };
  users.extraUsers.freddy = {
    isNormalUser = true;
#    uid = 1000;
    home = "/home/freddy";
    description = "Freddy Rietdijk";
    extraGroups = [ "wheel" "networkmanager" ];
  };

  environment.systemPackages = [ 
    pkgs.chromium
    #pkgs.chromiumBeta
    pkgs.firefoxWrapper
    pkgs.git
    pkgs.git-cola
    pkgs.gparted
    pkgs.mendeley
    pkgs.nox
    pkgs.openttd
    pkgs.skype
    pkgs.spotify
#    pkgs.steam
    pkgs.wget
    pkgs.vlc_qt5
    pkgs.kde4.konversation
    pkgs.kde4.ktorrent
    pkgs.kde5.plasma-desktop
    pkgs.kde5.kolourpaint
    pkgs.kde5.okular
    pkgs.kde5.gwenview
    pkgs.kde5.kate
    pkgs.kde5.ksysguard
    pkgs.kde5.plasma-nm
   # pkgs.python3
   # pkgs.python34Packages.ipython
   # pkgs.python34Packages.numpy
   # pkgs.python34Packages.scipy
   # pkgs.python34Packages.pandas
   # pkgs.python34Packages.matplotlib
   # pkgs.python34Packages.numexpr
   # pkgs.python34Packages.h5py
  ];# ++ builtins.filter stdenv.lib.isDerivation (builtins.attrValues pkgs.kde5);

}
