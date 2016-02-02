with import <nixpkgs> {};

( let
    python = "python35";
    pythonPackages = pkgs.${python+"Packages"};

in pkgs.${python}.buildEnv.override rec {

  extraLibs = import ./../packages/common-packages.nix { pkgs=pkgs; pythonPackages=pythonPackages; };
}
).env
