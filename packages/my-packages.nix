{ pkgs, pythonPackages }:

rec {
  acoustics = pkgs.callPackage ~/Code/libraries/acoustics/release.nix { pythonPackages = pythonPackages; };
  auraliser = pkgs.callPackage ~/Code/libraries/auraliser/release.nix { pythonPackages = pythonPackages; acoustics = acoustics; ism = ism; geometry = geometry; streaming = streaming; scintillations=scintillations; turbulence = turbulence;};
  geometry = pkgs.callPackage ~/Code/libraries/geometry/release.nix { pythonPackages = pythonPackages; };
  ism = pkgs.callPackage ~/Code/libraries/ism/release.nix { pythonPackages = pythonPackages; geometry = geometry;};
  noisy = pkgs.callPackage ~/Code/libraries/noisy/release.nix { pythonPackages = pythonPackages; };
  streaming = pkgs.callPackage ~/Code/libraries/streaming/release.nix { pythonPackages = pythonPackages; noisy = noisy; };
  turbulence = pkgs.callPackage ~/Code/libraries/turbulence/release.nix { pythonPackages = pythonPackages; };
  scintillations = pkgs.callPackage ~/Code/libraries/scintillations/release.nix { pythonPackages = pythonPackages;  streaming=streaming;};
}
