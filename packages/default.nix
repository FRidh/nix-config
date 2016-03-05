{ pkgs ? import <nixpkgs> {}, pythonPackages }:

rec {

  base = pkgs.callPackage ./common-packages.nix { pythonPackages = pythonPackages; };

  acoustics = pkgs.callPackage ~/Code/libraries/acoustics/release.nix { pythonPackages = pythonPackages; };
  auraliser = pkgs.callPackage ~/Code/libraries/auraliser/release.nix { pythonPackages = pythonPackages; acoustics = acoustics; ism = ism; geometry = geometry; streaming = streaming; turbulence = turbulence;};
  geometry = pkgs.callPackage ~/Code/libraries/geometry/release.nix { pythonPackages = pythonPackages; };
  ism = pkgs.callPackage ~/Code/libraries/ism/release.nix { pythonPackages = pythonPackages; geometry = geometry;};
  streaming = pkgs.callPackage ~/Code/libraries/streaming/release.nix { pythonPackages = pythonPackages; };
  turbulence = pkgs.callPackage ~/Code/libraries/turbulence/release.nix { pythonPackages = pythonPackages; };
  scintillations = pkgs.callPackage ~/Code/libraries/scintillations/release.nix { pythonPackages = pythonPackages; };
}
