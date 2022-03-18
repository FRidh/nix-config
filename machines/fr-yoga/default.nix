# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
#      ./cachix.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.tmpOnTmpfs = true;
  boot.cleanTmpDir = true;
  #boot.devSize = "20GB";

  # boot.binfmt.emulatedSystems = [
  #   "aarch64-linux"
  # ];

  programs.tmux.enable = true;
  # programs.steam.enable = true;

  nix = {
    trustedUsers = [ "root" "freddy" ];
    extraOptions = ''
      gc-keep-outputs = true
      gc-keep-derivations = true
      experimental-features = nix-command flakes
    '';
    buildCores = 8;
    maxJobs = 8;
    package = pkgs.nixUnstable;
  };

  networking.hostName = "fr-yoga"; # Define your hostname.
  networking.networkmanager.enable = true;
  networking.firewall.enable = false;

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  #networking.useDHCP = false;
  #networking.interfaces.enp3s0f4u1u1.useDHCP = true;
  #networking.interfaces.wlp1s0.useDHCP = true;

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

  hardware.bluetooth.enable = true;

  documentation.man.enable = true;

  nixpkgs.config = {
    allowUnfree = true;
  };

  # programs.fish.enable = true;

  # To fix nix-shell with certificates
  environment.variables."SSL_CERT_FILE" = "/etc/ssl/certs/ca-bundle.crt";

  services.avahi = {
    enable = true;
    nssmdns = true;
    publish.enable = true;
    publish.addresses = true;
    publish.workstation = true;
  };

  # Increase size of /run/user/1000 to 25% of RAM
  services.logind.extraConfig = "RuntimeDirectorySize=95%";

  # Collect data such as IO stats
  services.sysstat.enable = true;

  # services.ntp.enable = true;

  # Running out of file descriptors
  # https://github.com/NixOS/nixpkgs/issues/101459#issuecomment-758306434
  security.pam.loginLimits = [{
      domain = "*";
      type = "soft";
      item = "nofile";
      value = "65536";
    }];

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    arandr
    audacity
    bfs
    binutils
    diffoscope
    iftop
    iotop
    ffmpeg
    file
    firefox-bin
    fzf # fuzzy finder
    gitFull
    git-cola
    gitAndTools.hub
    gnumake
    google-chrome
    htop
    iftop
    imagemagick
    iotop
    jq
    libreoffice
    ktorrent
    kwin-tiling
    nix-review
    pavucontrol
    psmisc
    (python3.withPackages(ps: with ps; [ ipython notebook jupyterlab numpy toolz pytest pandas holoviews hvplot matplotlib panel ]))
    lm_sensors
    sshfs
    spotify
    teams
    tmux
    unzip
    wget
    vlc
    vscode
    zip
    # KDE packages
    ark
    fish
    gwenview
    kate
    kdeconnect
    kile
    konversation
    spectacle
    plasma-desktop
    kolourpaint
    okular
    yakuake
    kompare
    filelight
  ];

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
  
  # Enable the KDE Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  services.tailscale.enable = true;
  services.locate = {
    enable = true;
    interval = "hourly";
  };

  services.telepathy.enable = true;

  # TLP Linux Advanced Power Management
  services.tlp.enable = true;

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

  users.extraUsers.freddy = {
    isNormalUser = true;
#    shell = pkgs.fish;
    uid = 1000;
    home = "/home/freddy";
    description = "Frederik Rietdijk";
    extraGroups = [ "wheel" "networkmanager" "audio" ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?
}

