{
  description = "Configuration";

  inputs = {
    nixos-2505.url = "github:nixos/nixpkgs?ref=nixos-25.05";
    nixos-2411.url = "github:nixos/nixpkgs?ref=nixos-24.11";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixos-2505, nixos-2411, utils } @ inputs: rec {

    nixosConfigurations."fr-desktop" = nixos-2505.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        (import ./machines/fr-desktop/default.nix)
        #(builtins.toPath "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix")
      ];
#      specialArgs = { inherit inputs; };
    };

    nixosConfigurations."fr-yoga" = nixos-2411.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ (import ./machines/fr-yoga/default.nix) ];
#      specialArgs = { inherit inputs; };
    };

    #packages.x86_64-linux.defaultPackage = nixosConfigurations."fr-desktop";
  } // (utils.lib.eachSystem ["x86_64-linux" ] (system: rec {
    packages = let
      nixpkgs = nixos-2505;
    in {
      pythonEnv = nixpkgs.legacyPackages.${system}.python3.withPackages(ps: with ps; [
        acoustics
        bokeh
        dask
        datashader
        flit
        graphviz
        holoviews
        h5py
        hvplot
        ipython
        jupyterlab
        line_profiler
        matplotlib
        memory_profiler
        netcdf4
        notebook
        numba
        pandas
        param
        panel
        pytest
        scikitlearn
        scipy
        seaborn
        toolz
        xarray
        zarr
      ]);
    };  
  }));
}
