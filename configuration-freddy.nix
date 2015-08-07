{
  allowUnfree = true;
  allowBroken = true;
  
  packageOverrides = pkgs: with pkgs; {

    sympy = python34Packages.sympy.override {
      disabled = isPyPy;
      doCheck = false;
    };
    

    workEnv = pkgs.myEnvFun {
      name = "work";
      buildInputs = [
        python34
        python34Packages.ipython
        python34Packages.numpy
        python34Packages.scipy
        python34Packages.matplotlib
        python34Packages.pandas
        #python34Packages.sympy
        python34Packages.pytest
        python34Packages.numexpr
        #python34Packages.networkx
        python34Packages.h5py
        python34Packages.toolz
        python34Packages.cytoolz
        python34Packages.cython
        #python34Packages.odo
      ];
    };
    
    blogEnv = pkgs.myEnvFun {
      name = "blog";
      buildInputs = [
        python34
        python34Packages.pelican
      ];
    };
    
    devEnv = pkgs.myEnvFun {
      name = "dev";
      buildInputs = [
        python34
        python34Packages.ipython
        python34Packages.numpy
        python34Packages.scipy
        python34Packages.matplotlib
        python34Packages.pandas
        #python34Packages.sympy
        python34Packages.pytest
        python34Packages.numexpr
        #python34Packages.networkx
        python34Packages.h5py
        python34Packages.gnutls
        python34Packages.toolz
        python34Packages.cytoolz
        #python34Packages.odo
      ];    
    };

    tornado2Env = pkgs.myEnvFun {
      name = "tornado2";
      buildInputs = [
        python27
        #python27Packages.tornado
        python27Packages.ipython
      ];
    };

    tornado3Env = pkgs.myEnvFun {
      name = "tornado3";
      buildInputs = [
        python34
        #python34Packages.tornado
        python34Packages.ipython
      ];
    };
    
    pypyEnv = pkgs.myEnvFun {
      name = "pypy";
      buildInputs = [
        pypy  
      ];
    };

    builder34Env = pkgs.myEnvFun {
      name = "builder34";
      buildInputs = [
        python34
      ];
    };

    builder27Env = pkgs.myEnvFun {
      name = "builder27";
      buildInputs = [
        python
      ];
    };
    
  };
}
