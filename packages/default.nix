{ pkgs ? import <nixpkgs> {} }:

rec {

  # Python packages for in default Python env. This is a lambda.
  common-python-packages = import ./common-python-packages.nix { };

  pythonEnv = pkgs.python3.withPackages (common-python-packages);
#   pythonEnv = python.buildEnv.override {extraLibs=common-python-packages; ignoreCollisions=true;};

  auralisationOverrides = import ./auralisation { };

}
