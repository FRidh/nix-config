{ pkgs ? import <nixpkgs> {} }:

rec {

  # Fetch a tarball from GitHub.
  fetchTarballFromGitHub = { repo, owner, rev, sha256 }:
    fetchTarball {
      url = "https://github.com/${owner}/${repo}/archive/${rev}.tar.gz";
      inherit sha256;
    };

  # Python packages for in default Python env. This is a lambda.
  common-python-packages = import ./common-python-packages.nix { };

  pythonEnv = let
    python = pkgs.python3.override {
      # Use packages as specified in remote repository.
#       packageOverrides = remote.sets.auralisation.stableOverrides;
      # Use packages as specified in local repository.
      packageOverrides = local.sets.auralisation.stableOverrides;
      # Use packages as specified locally.
#       packageOverrides = local.overrides.python;
    };
  in python.withPackages common-python-packages;

  local.overrides.python = self: super: {
    acoustics = super.callPackage ~/Code/libraries/acoustics { };
    auraliser = super.callPackage ~/Code/libraries/auraliser { };
    geometry = super.callPackage ~/Code/libraries/geometry { };
    ism = super.callPackage ~/Code/libraries/ism { };
    noisy = super.callPackage ~/Code/libraries/noisy { };
    scintillations = super.callPackage ~/Code/libraries/scintillations { };
    streaming = super.callPackage ~/Code/libraries/streaming { };
    turbulence = super.callPackage ~/Code/libraries/turbulence { };
  };

  local.sets.auralisation = pkgs.callPackage ~/Code/libraries/auralisation-nix { };

  remote.sets.auralisation = (import (fetchTarballFromGitHub {
    owner = "FRidh";
    repo = "auralisation-nix";
    rev = "fd6e6a30e3f6a9a75b5f4bf10b74340353a52ef0";
    sha256 = "1ks54pwzff448nxhyqiajlnhlwb8dnsdm42ymi5ncwm7ynd152jy";
  }) { });

#   auralisation = import ./auralisation.nix { };

}
