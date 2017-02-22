{ pkgs ? import <nixpkgs> {}, pythonPackages }:

rec {

  # Python packages for in default Python env
  common-python-packages = pkgs.callPackage ./common-python-packages.nix { pythonPackages = pythonPackages; };

  #pythonEnv = pythonPackages.python.withPackages (ps: common-python-packages);
  pythonEnv = pythonPackages.python.buildEnv.override {extraLibs=common-python-packages; ignoreCollisions=true;};

  # Development versions of packages
  dev = rec {
    acoustics = pkgs.callPackage ~/Code/libraries/acoustics/release.nix { pythonPackages = pythonPackages; };
    auraliser = pkgs.callPackage ~/Code/libraries/auraliser/release.nix { inherit pythonPackages acoustics ism scintillations turbulence;};
    geometry = pkgs.callPackage ~/Code/libraries/geometry/release.nix { pythonPackages = pythonPackages; };
    ism = pkgs.callPackage ~/Code/libraries/ism/release.nix { pythonPackages = pythonPackages; geometry = geometry;};
    noisy = pkgs.callPackage ~/Code/libraries/noisy/release.nix { pythonPackages = pythonPackages; };
    streaming = pkgs.callPackage ~/Code/libraries/streaming/release.nix { pythonPackages = pythonPackages; noisy = noisy; };
    turbulence = pkgs.callPackage ~/Code/libraries/turbulence/release.nix { pythonPackages = pythonPackages; };
    scintillations = pkgs.callPackage ~/Code/libraries/scintillations/release.nix { pythonPackages = pythonPackages;  streaming=streaming;};
  };

  # Releases of packages
  release = {

  };


}
