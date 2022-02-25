# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, stdenv, ... }:

let

  #pythonEnv = (pkgs.python35Packages.python.withPackages (ps: pkgs.callPackage ../packages/common-python-packages.nix { pythonPackages = ps; }));
#  mypkgs = pkgs.callPackage ../packages {};
#  texEnv = with pkgs.texlive; (combine { scheme-full=scheme-full; empaposter=mypkgs.local.texlive.empaposter;});
# texEnv = pkgs.texlive.combined.scheme-full;
#    (texlive.combine {
#      inherit (texlive) biblatex scheme-medium preprint logreq emptypage todonotes mathdesign units ly1;
#    })

in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      #./../../musnix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/sda";
  boot.tmpOnTmpfs = true;
  boot.cleanTmpDir = true;

  # wifi authentication timeout
  # https://ubuntuforums.org/showthread.php?t=2235768
  boot.extraModprobeConfig = ''
    options iwlwifi 11n_disable=1 wd_disable=1
  '';

#  boot.kernelPackages = pkgs.linuxPackages_4_7;

#  boot.plymouth.enable = true;

  networking.hostName = "fr-laptop"; # Define your hostname.
  networking.networkmanager.enable = true;
#  networking.networkmanager.packages = with pkgs; [
#    networkmanager_pptp
#    networkmanager_l2tp
#    networkmanager_vpnc
#    networkmanager_openconnect
#  ];
  networking.firewall = {
    enable = true;
    allowedUDPPorts = [ 27036 ]; # Steam
    allowedTCPPortRanges = [ { from = 1714; to = 1764; } ]; # kdeconnect
    allowedUDPPortRanges = [ { from = 1714; to = 1764; } ]; # kdeconnect
  };

  hardware.pulseaudio = {
    enable = true;
    support32Bit = true;
    package = pkgs.pulseaudioFull;
    tcp.enable = true;
    tcp.anonymousClients.allowAll = true;
    zeroconf.discovery.enable = true;
    zeroconf.publish.enable = true;
  };
  hardware.bluetooth.enable = true;

  # OpenGL
  hardware.opengl = {
    driSupport = true;
    driSupport32Bit = true;
#    extraPackages = with pkgs; [ vaapiIntel libvdpau-va-gl vaapiVdpau ];
#    extraPackages32 = with pkgs; [ vaapiIntel libvdpau-va-gl vaapiVdpau ];
  };  

  powerManagement.enable = true;

  #virtualisation.virtualbox.host.enable = true;
  #virtualisation.virtualbox.host.enableHardening = false;
  services.locate = {
    enable = true;
    interval = "hourly";
  };
  services.telepathy.enable = true;

  # TLP Linux Advanced Power Management
  services.tlp.enable = true;

  # nVidia Bumblebee
  hardware.bumblebee.enable = false;
  hardware.bumblebee.connectDisplay = false;
  hardware.nvidiaOptimus.disable = true;

  # Man pages
  documentation.man.enable = true;

  # Disable because of KDE/Qt bug with Plasma 5.
  #fonts.fontconfig.ultimate.enable = true;

  nix = {
    binaryCachePublicKeys = [ "hydra.nixos.org-1:CNHJZBh9K4tP3EKF6FkkgeVYsS3ohTl+oS0Qa8bezVs=" "headcounter.org:/7YANMvnQnyvcVB6rgFTdb8p5LG1OTXaO+21CaOSBzg=" ];
    trustedBinaryCaches = [ "https://hydra.nixos.org/" "https://headcounter.org/hydra/" "178.249.150.224" ];
    extraOptions = ''
      gc-keep-outputs = true
      gc-keep-derivations = true
      experimental-features = nix-command flakes
    '';
    #nixPath = [ "/etc/nixos" "nixos-config=/etc/nixos/configuration.nix" ]; # Use own repository!
    package = pkgs.nixUnstable;

    #buildMachines = [
    #  { hostName = "178.249.150.224";
    #    sshUser = "nix-builder-home";
    #    sshKey = "/root/.ssh/nix-builder-home";
    #    system = "x86_64-linux";
    #    maxJobs = 4;
    #  }
    #];
    #distributedBuilds = false;
    #requireSignedBinaryCaches = false;
  };

  # Select internationalisation properties.
  # i18n = {
  #   consoleFont = "Lat2-Terminus16";
  #   consoleKeyMap = "us";
  #   defaultLocale = "en_US.UTF-8";
  # };

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";
#  time.timeZone = "America/New_York";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  # environment.systemPackages = with pkgs; [
  #   wget
  # ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  services.avahi = {
    enable = true;
    nssmdns = true;
    publish.enable = true;
    publish.addresses = true;
    publish.workstation = true;
  };

  # Enable CUPS to print documents.
#  services.printing = {
#    enable = true;
#    gutenprint = true; #drivers = [ pkgs.gutenprint pkgs.hplipWithPlugin ];
#  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.xkbOptions = "eurosign:e";
  #services.xserver.synaptics = {
  #  enable = true;
  #  twoFingerScroll = true;
  #  tapButtons = true;
  #  fingersMap = [1 3 2];
  #};

  # Enable the KDE Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
# services.xserver.windowManager.i3.enable = true;  
  services.xserver.videoDrivers = [ "modesetting" ];

  #services.sabnzbd.enable = false;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers = {
    freddy = {
      isNormalUser = true;
      #uid = 1000;
      home = "/home/freddy";
      description = "Frederik Rietdijk";
      extraGroups = [ "wheel" "networkmanager" "audio" "vboxusers" ];
    };
  #  test = {
  #    isNormalUser = true;
  #    home = "/home/test/";
  #  };
  };

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "20.09";
  
  nixpkgs.config = {
    allowUnfree = true;
#    firefox = {
#      enableGoogleTalkPlugin = true;
#      enableAdobeFlash = true;
      #jre = true;
#    };
  };

  # To fix nix-shell with certificates
 # environment.variables."SSL_CERT_FILE" = "/etc/ssl/certs/ca-bundle.crt";

  environment.systemPackages = with pkgs; [
    #ardour
#    aspell
#    aspellDicts.en
#    (hunspellWithDicts [hunspellDicts.en-us hunspellDicts.en-gb-ise])
#    audacity
#    awscli
    #busybox
    #chromium
    #cups_filters
    #exfat
    iftop
    iotop
#    nox
    #flac
    #firefox
    firefox-bin
    #ffmpeg
    #gdb
    #ghostscript
    gitFull
    #git-lfs
    git-cola
    #gparted
    #graphviz
    #gnumake
    #google-chrome
    gitAndTools.hub # GitHub extension to git
    #imagemagick
    #inkscape
#    jack2Full
#    lame
    #libreoffice
    lm_sensors
#    mendeley
#    mysql
#    nix-prefetch-scripts
    #octave
    #openttd
 #   openssl
    #pandoc
    #paprefs # Pulesaudio conf
    #pavucontrol # Pulseaudio control
    pciutils
    #pidgin
    #(pidgin-with-plugins.override { plugins = [ pidginsipe pidgin-skypeweb ];})
    powerdevil
    psmisc
    # Default Python environment
#    pythonEnv
#    qjackctl
 #   samba
#    skype
    spotify
    #vscode
    #sshfsFuse
    #sstp # vpn Chalmers
#    steam
 #   texmaker
    tmux
    #usbutils
    wget
    #vlc_qt5
    zip
    unzip
    # KDE packages
    ark
    gwenview
    kate
    kdeconnect
   # kile
    konversation
    spectacle
    plasma-desktop
    kolourpaint
    #kdesu
    okular
    yakuake
    kompare
    filelight
#    kdeApplications.l10n.en_GB.qt4
    # LaTeX
    #texEnv
    #biber
  ];
   # Packages that should be available in the store but not in the system profile.
   #system.extraDependencies = pkgs.callPackage ../packages/common-python-packages.nix { pythonPackages=pkgs.python35Packages; };

  # Musnix real-time audio
  # https://github.com/musnix/musnix
 # musnix = {
 #   enable = false;
  #  #ffado.enable = true; # Broken, error: attribute ‘ffado’ missing
  #  kernel.optimize = true;
  #  kernel.realtime = true;
  #  #kernel.packages = pkgs.linuxPackages_latest_rt;
  #  kernel.packages = pkgs.linuxPackages_4_4_rt;
  #  rtirq.enable = true;
  #  das_watchdog.enable = true;
  #};

}


