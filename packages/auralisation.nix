{ }:

let
  fetchTarballFromGitHub = { repo, owner, rev, sha256 }:
    fetchTarball {
      url = "https://github.com/${owner}/${repo}/archive/${rev}.tar.gz";
      inherit sha256;
    };

  auralisation = (import (fetchTarballFromGitHub {
    owner = "FRidh";
    repo = "auralisation-nix";
    rev = "d74f9853b898bafaecda7a667b28f9bd01ae65b4";
    sha256 = "0gv88846shwqp7sbpwa08jmmn3j55kn78p1w7m3cb2x82n1sqx60";
  }) { });

{
  dev = self: super: {
    acoustics = super.callPackage ~/Code/libraries/acoustics { };
    auraliser = super.callPackage ~/Code/libraries/auraliser { };
    geometry = super.callPackage ~/Code/libraries/geometry { };
    ism = super.callPackage ~/Code/libraries/ism { };
    noisy = super.callPackage ~/Code/libraries/noisy { };
    scintillations = super.callPackage ~/Code/libraries/scintillations { };
    streaming = super.callPackage ~/Code/libraries/streaming { };
    turbulence = super.callPackage ~/Code/libraries/turbulence { };
  };
} // auralisation
