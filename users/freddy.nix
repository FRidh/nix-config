with <nixpkgs> {};
{

  allowUnfree = true;
  allowBroken = false;

  packageOverrides = pkgs: with pkgs; {

    pythonEnv = (pkgs.python35Packages.python.withPackages (ps: pkgs.callPackage ../packages/common-python-packages.nix { pythonPackages = ps; }));

    ## Example environments. Using nix-shell instead.
    #workEnv = pkgs.myEnvFun {
    #    name = "work";
    #    buildInputs = with python35Packages; [
    #      python35
    #      ipython
    #      numpy
    #      scipy
    #      matplotlib
    #      pandas
    #      sympy
    #      pytest
    #      numexpr
    #      networkx
    #      h5py
    #      toolz
    #      cytoolz
    #      cython
    #      odo
    #    ];
    #};
    #blogEnv = python35.withPackages (ps: [ps.pelican]);
    #mailEnv = python27.withPackages (ps: with ps; [pyyaml offlineimap ]);
  };

}
