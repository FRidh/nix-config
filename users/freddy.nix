with <nixpkgs> {};
{

  allowUnfree = true;
  allowBroken = true;

  packageOverrides = pkgs: with pkgs; {

    # Example environments. Using nix-shell instead.
    workEnv = pkgs.myEnvFun {
        name = "work";
        buildInputs = with python35Packages; [
          python35
          ipython
          numpy
          scipy
          matplotlib
          pandas
          sympy
          pytest
          numexpr
          networkx
          h5py
          toolz
          cytoolz
          cython
          odo
        ];
    };

    blogEnv = pkgs.myEnvFun {
        name = "blog";
        buildInputs = with python35Packages; [
          python35
          python35Packages.pelican
        ];
    };
  };
}
