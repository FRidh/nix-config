# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

#let
#  nixUnstable = lib.overrideDerivation pkgs.nixUnstable( attrs: {
#    src = pkgs.fetchFromGitHub {
#      owner = "NixOS";
#      repo = "nix";
#      rev = "4be4f6de56f4de77f6a376f1a40ed75eb641bb89";
#      sha256 = "0icvbwpca1jh8qkdlayxspdxl5fb0qjjd1kn74x6gs6iy66kndq6";
#    };
#  });
#in
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

  programs.command-not-found.enable = true;

  #boot.kernelPackages = pkgs.linuxPackages_4_7;

  nix = {
    binaryCachePublicKeys = [ "hydra.nixos.org-1:CNHJZBh9K4tP3EKF6FkkgeVYsS3ohTl+oS0Qa8bezVs=" "headcounter.org:/7YANMvnQnyvcVB6rgFTdb8p5LG1OTXaO+21CaOSBzg=" ];
    trustedBinaryCaches = [ "https://hydra.nixos.org/" "https://headcounter.org/hydra/" ];
    extraOptions = ''
      gc-keep-outputs = true
      gc-keep-derivations = true
    '';
    nixPath = [ "/etc/nixos" "nixos-config=/etc/nixos/configuration.nix" ]; # Use own repository!
    useSandbox = true;
    maxJobs = 4;
 #   package = nixUnstable;
  };

  networking.hostName = "fr-desktop"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;

  networking.firewall.enable = false;

  hardware.pulseaudio = {
    enable = true;
    support32Bit = true;
    package = pkgs.pulseaudioFull;
    zeroconf.discovery.enable = true;
    zeroconf.publish.enable = true;
    tcp.enable = true;
    tcp.anonymousClients.allowAll = true;
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

  programs.man.enable = true;

  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableHardening = false;

  nixpkgs.config = {
    allowUnfree = true;
    firefox = {
      enableGoogleTalkPlugin = true;
      enableAdobeFlash = true;
    };
  };

  # To fix nix-shell with certificates
  environment.variables."SSL_CERT_FILE" = "/etc/ssl/certs/ca-bundle.crt";

  services.avahi = {
    enable = true;
    nssmdns = true;
    publish.enable = true;
    publish.addresses = true;
    publish.workstation = true;
  };

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    atom
    #chromium
    binutils
    #diffoscope
    iftop
    iotop
    ffmpeg
    firefox-bin
    gitFull
    git-cola
    gitAndTools.hub
    google-chrome
    iftop
    iotop
    ktorrent
    nix-prefetch-scripts
    nix-repl
    nox
    openttd
    pavucontrol
    spotify
    steam
    tmux
    unzip
    wget
    vlc_qt5
    zip
  ] ++ callPackage ../packages/kde-packages.nix { };


  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.forwardX11 = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.xkbOptions = "eurosign:e";
  services.xserver.videoDrivers = ["nvidia"];

  # Enable the KDE Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  services.sabnzbd.enable = true;

  services.locate = {
    enable = true;
    interval = "hourly";
  };

  services.telepathy.enable = true;

  # TLP Linux Advanced Power Management
  services.tlp.enable = true;

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
  # system.stateVersion = "16.09";

}

