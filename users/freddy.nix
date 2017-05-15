with <nixpkgs> {};
{

  allowUnfree = true;
  allowBroken = false;

  packageOverrides = pkgs: with pkgs; {

    mypkgs = pkgs.callPackage ../packages { };
#     inherit (mypkgs) pythonEnv;

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
