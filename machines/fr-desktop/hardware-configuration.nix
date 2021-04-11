# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, ... }:

{
  imports =
    [ 
      #<nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  #boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/5f4629cc-dccb-430a-8a93-01a2ff7ce924";
      fsType = "ext4";
    };

  # fileSystems."/home" =
  #   { device = "/dev/disk/by-uuid/81fb7314-d76a-462b-aea0-fa3331ea9ac1";
  #     fsType = "ext4";
  #   };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/B1FD-7040";
      fsType = "vfat";
    };
  fileSystems."/data" = 
    { device = "/dev/disk/by-uuid/4ec70f81-a0a7-49e5-804d-1f41a2efbb35";
      fsType = "ext4";
    };
  fileSystems."/tmp" =
    { device = "none";
      fsType = "tmpfs";
      options = [ "size=10G" ];
      neededForBoot = true;
    };

  swapDevices = [ ];

  nix.maxJobs = lib.mkDefault 4;
  # powerManagement.cpuFreqGovernor = "powersave";
}
