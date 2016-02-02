# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, stdenv, ... }:


{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
      ./../../musnix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/sda";
  boot.tmpOnTmpfs = true;
  boot.cleanTmpDir = true;

  boot.kernelPackages = pkgs.linuxPackages_4_4;

  networking.hostName = "fr-laptop"; # Define your hostname.
  networking.networkmanager.enable = true;
  networking.firewall = {
    enable = true;
    allowedUDPPorts = [ 27036 ]; # Steam
    allowedTCPPortRanges = [ { from = 1714; to = 1764; } ]; # kdeconnect
    allowedUDPPortRanges = [ { from = 1714; to = 1764; } ]; # kdeconnect
  };

  hardware.pulseaudio = {
    enable = true;
    support32Bit = true;
  };
  hardware.bluetooth.enable = true;
  hardware.opengl.driSupport32Bit = true;

  virtualisation.virtualbox.host.enable = true;
  services.locate.enable = true;
  services.telepathy.enable = true;
  programs.man.enable = true;

  # Disable because of KDE/Qt bug with Plasma 5.
  fonts.fontconfig.ultimate.enable = false;

  nix = {
    binaryCachePublicKeys = [ "hydra.nixos.org-1:CNHJZBh9K4tP3EKF6FkkgeVYsS3ohTl+oS0Qa8bezVs=" "headcounter.org:/7YANMvnQnyvcVB6rgFTdb8p5LG1OTXaO+21CaOSBzg=" ];
    trustedBinaryCaches = [ "https://hydra.nixos.org/" "https://headcounter.org/hydra/" ];
    extraOptions = ''
      gc-keep-outputs = true
      gc-keep-derivations = true
    '';
    nixPath = [ "/etc/nixos" "nixos-config=/etc/nixos/configuration.nix" ]; # Use own repository!
    useChroot = true;
  };

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
  # environment.systemPackages = with pkgs; [
  #   wget
  # ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    drivers = [ pkgs.gutenprint pkgs.hplipWithPlugin ];
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.xkbOptions = "eurosign:e";
  services.xserver.synaptics = {
    enable = true;
    twoFingerScroll = true;
    tapButtons = true;
    fingersMap = [1 3 2];
  };

  # Enable the KDE Desktop Environment.
  services.xserver.displayManager.kdm.enable = true;
  #services.xserver.displayManager.sddm.enable = true;
  #services.xserver.desktopManager.kde5.enable = true;
  services.xserver.desktopManager.kde4.enable = true;
  #services.xserver.windowManager.i3.enable = true;

  services.sabnzbd.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.freddy = {
    isNormalUser = true;
    #uid = 1000;
    home = "/home/freddy";
    description = "Frederik Rietdijk";
    extraGroups = [ "wheel" "networkmanager" "audio" ];
  };

  # The NixOS release to be compatible with for stateful data such as databases.
  # system.stateVersion = "15.09";
  
  nixpkgs.config = {
    allowUnfree = true;
    firefox = {
      enableGoogleTalkPlugin = true;
      enableAdobeFlash = true;
    };
  };

  environment.systemPackages = with pkgs; [
    audacity
#    busybox
    chromium
    iftop
    iotop
    nox
    flac
    firefox-wrapper
    gdb
    git
    git-cola
    gparted
    graphviz
    gnumake
    google-chrome
    lame
    #libreoffice
    lm_sensors
    mendeley
    mysql
    nix-prefetch-scripts
    openttd
    openssl
    pandoc
    pavucontrol
    pciutils
    psmisc
    samba
    skype
    spotify
    sstp # vpn Chalmers
    steam
#    texLiveFull
#   texlive.combined.scheme-medium
#    tex-collection
    (texlive.combine {
      inherit (texlive) scheme-medium preprint todonotes;
    })
    tmux
    usbutils
    wget
    vlc_qt5
    zip
    unzip
   ] ++ pkgs.callPackage ../packages/kde-packages.nix { kdeVersion=4;};


   system.extraDependencies = pkgs.callPackage ../packages/common-packages.nix { pythonPackages=pkgs.python35Packages; };

  # Musnix real-time audio
  # https://github.com/musnix/musnix
  musnix = {
    enable = true;
    #ffado.enable = true;
    kernel.optimize = true;
    kernel.realtime = true;
    #kernel.packages = pkgs.linuxPackages_latest_rt;
    kernel.packages = pkgs.linuxPackages_4_1_rt;
    rtirq.enable = true;
    das_watchdog.enable = true;
  };

}


