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
      ./hardware-configuration.nix
#      ./cachix.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = false;
  # Define on which hard drive you want to install Grub.
  # boot.loader.grub.device = "/dev/sda";
#  boot.loader.gummiboot.enable = true;
  boot.loader.systemd-boot.enable = true;
#  boot.loader.efi.efibootmgr.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.tmp.useTmpfs = true;
  boot.tmp.cleanOnBoot = true;
#  boot.devSize = "20GB";

  # WARNING: binfmt sets sandbox-paths which should be extra-sandbox-paths
  # with nixUnstable!
  # boot.binfmt.emulatedSystems = [
  #   "aarch64-linux"
  # ];

  #programs.command-not-found.enable = true;
  programs.tmux.enable = true;

  programs.steam.enable = false;

  # boot.kernelPackages = pkgs.linuxPackages_5_15;

  nix = {
    settings.trusted-users = [ "root" "freddy" ];
    extraOptions = ''
      gc-keep-outputs = true
      gc-keep-derivations = true
      experimental-features = nix-command flakes impure-derivations ca-derivations
      builders-use-substitutes = true
    '';
    settings.cores = 8;
    settings.max-jobs = 8;
    settings.max-substitution-jobs = 128;
  };

  networking.hostName = "fr-desktop"; # Define your hostname.
  networking.networkmanager = {
    enable = true;
    wifi.scanRandMacAddress = false;
  };

  networking.firewall.enable = false;

  hardware.cpu.intel.updateMicrocode = true;

  services.pipewire = {
    enable = true;
    audio.enable = true;
    pulse.enable = true;
    alsa.enable = true;
  };

  services.pulseaudio = {
    enable = false;
    support32Bit = true;
    package = pkgs.pulseaudioFull;
    zeroconf.discovery.enable = true;
    zeroconf.publish.enable = true;
    tcp.enable = true;
    tcp.anonymousClients.allowAll = true;
  };

  hardware.graphics = {
    enable32Bit = true;
    extraPackages = with pkgs; [ vaapiVdpau ];
  };

  hardware.bluetooth.enable = true;

  # Select internationalisation properties.
  # i18n = {
  #   consoleFont = "Lat2-Terminus16";
  #   consoleKeyMap = "us";
  #   defaultLocale = "en_US.UTF-8";
  # };
#  hardware.bluetooth.enable = true;

  documentation.man.enable = true;

 # virtualisation.virtualbox.host.enable = true;
  #virtualisation.virtualbox.host.enableHardening = false;
  # virtualisation.docker.enable = true;

#  virtualisation.anbox.enable = true;

  nixpkgs.config = {
    allowUnfree = true;
  };

  # To fix nix-shell with certificates
  environment.variables."SSL_CERT_FILE" = "/etc/ssl/certs/ca-bundle.crt";

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    publish.enable = true;
    publish.addresses = true;
    publish.workstation = true;
  };

  # Increase size of /run/user/1000 to 25% of RAM
  services.logind.extraConfig = "RuntimeDirectorySize=95%";

  # Collect data such as IO stats
  services.sysstat.enable = true;

  services.ntp.enable = true;

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
  environment.systemPackages = (with pkgs; [
    arandr
    bfs
    binutils
    ffmpeg
    file
    firefox
    fzf # fuzzy finder
    git-cola
    gitAndTools.hub
    gitFull
    gnumake
    google-chrome
    htop
    iftop
    iftop
    imagemagick
    iotop
    iotop
    jq
    libreoffice
    lm_sensors
    psmisc
    spotify
    sshfs
    tmux
    unzip
    vlc
    vscode
    wget
    zip
  ]) ++ (with pkgs.kdePackages; [
    # KDE packages
    ark
    filelight
    gwenview
    kate
    kdeconnect-kde
    kolourpaint
    kompare
    ktorrent
    okular
    plasma-desktop
    spectacle
    yakuake
  ]);

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.xkb.layout = "us";
  services.xserver.xkb.options = "eurosign:e";

  # Enable the KDE Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  services.tailscale.enable = false;

  #systemd.services.code-server = {
  #  enable = true;
  #  description = "Remote VSCode Server";
  #  after = ["network.target"];
  #  wantedBy = ["multi-user.target"];
  #  path = [ pkgs.go pkgs.git pkgs.direnv ];

  #  serviceConfig = {
  #    Type = "simple";
  #    ExecStart = "${pkgs.code-server}/bin/code-server";
  #    WorkingDirectory = "/home/freddy";
  #    NoNewPrivileges = true;
  #    User = "freddy";
  #    Group = "nogroup";
  #  };
  #};

  #services.codimd = {
  #  enable = true;
  #  configuration.db = {
  #    dialect = "sqlite";
  #    storage = "/var/lib/codimd/db.codimd.sqlite";
  #  };
  #};

  # services.xrdp.enable = true;

  # services.sabnzbd.enable = true;

  #services.gitea.enable = true;

  # services.postgresql = {
  #   enable = true;
  #   ensureDatabases = [ "hydra" ];
  #   ensureUsers = [
  #     {
  #       name = "hydra";
  #       ensurePermissions = {
  #         "DATABASE hydra" = "ALL PRIVILEGES";
  #       };
  #     }
  #     {
  #       name = "hydra-www";
  #       ensurePermissions = {
  #         "DATABASE hydra" = "ALL PRIVILEGES";
  #       };
  #     }
  #     {
  #       name = "root";
  #       ensurePermissions = {
  #         "DATABASE hydra" = "ALL PRIVILEGES";
  #       };
  #     }
  #   ];
  # };

  # services.hydra = let
  #   package = (pkgs.hydra.override {darcs=null; mercurial=null; subversion=null;}).overrideAttrs(oldAttrs: {
  #     # version = "2020-03-13";
  #     # src = pkgs.fetchFromGitHub {
  #     #   owner = "NixOS";
  #     #   repo = "hydra";
  #     #   rev = "be0ec2d22332d382781d7f45f474b57ad0f5c411";
  #     #   sha256 = "sha256:0c6mvyqa62hhg1bvnp6khk2k6iyvwvyzjj5aksikh03qssik7a1a";
  #     # };
  #   });
  # in {
  #   enable = true;
  #   dbi = "dbi:Pg:dbname=hydra;user=hydra;";
  #   inherit package;
  #   hydraURL = "https://hydra.fridh.nl";
  #   notificationSender = "hydra@fridh.nl";
  # };

  # services.octoprint = {
  #   enable = true;
  #   plugins = ps: with ps; [m33-fio];
  # };

#   services.jupyter = {
#     enable = true;
#     # notebook
#     password = "'sha1:4f1c240f7c3a:1ec8d2552eedbf2d179009e53ee42f77c5de673c'";
#
#     kernels = {
#       python2-scipy = let
#         env = pkgs.python2.withPackages(ps: with ps; [
#           scipy
#         ]);
#       in {
#         displayName = "Python 2 scipy";
#         argv = [
#           "${env.interpreter}"
#           "-m"
#           "IPython.kernel"
#           "-f"
#           "{connection_file}"
#         ];
#         language = "python";
#       };
#       python3-scipy = let
#         env = pkgs.python3.withPackages(ps: with ps; [
#           scipy
#         ]);
#       in {
#         displayName = "Python 3 scipy";
#         argv = [
#           "${env.interpreter}"
#           "-m"
#           "IPython.kernel"
#           "-f"
#           "{connection_file}"
#         ];
#         language = "python";
#       };
#     };
#   };

  services.locate = {
    enable = true;
    interval = "hourly";
  };

  services.telepathy.enable = true;

  # TLP Linux Advanced Power Management
  # services.tlp.enable = true;

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
    uid = 1000;
    home = "/home/freddy";
    description = "Frederik Rietdijk";
    extraGroups = [ "wheel" "networkmanager" "audio" ];
  };

  #users.users = let
  #  addNixBuildUserData = nr: {
  #    name =  "nixbld${toString nr}";
  #    extraGroups = [ "nixbld" "docker" ];
  #  };
  #in map addNixBuildUserData (lib.range 1 config.nix.nrBuildUsers);

  # users.extraUsers.nix-builder-home = {
  #   isNormalUser = true;
  #   openssh.authorizedKeys.keys = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCcl9KaDNV58UPTrtGRcqVEhhrMWfRDlixY13Eq9tbzi/2Wukl9Wxyq32/Li/Wb8OCfy5/YKd54DJYxO6NNEpB5sbrSuHKamzvcf860Ka8dSnkNOcgcW7/cb6oLeG7mi8hxVoxEEflbakVj019aZ9pp4VKvujcF8Vz9ZiSgH5B+Yr550xPy2/TwyLEnsJOgExP/zvZOjCGHc4KomtH/sfVrO4in7NXzoB5wYBTk7mrOchBPpoITGPTT6BG7DRzHHArXbnuEqFxht3HGvE/FLmdri28u/WN8uzWKxrpG1UTjLavByX/uc7DOepQwsFmEnsIgKJ/9d6iNNuyE91+hd/Ej root@fr-laptop" ];
  # };

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "23.11";

}

