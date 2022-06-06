{
  description = "Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-22.05";
    nixos-2111.url = "github:nixos/nixpkgs?ref=nixos-21.11";
    #nixpkgs-stable.url = "github:nixos/nixpkgs?ref=nixos-21.05";
    #nixpkgs.url = "github:WilliButz/nixpkgs?ref=codimd/fix-sqlite/node12";
    #nixpkgs.url = "git+https://github.com/WilliButz/nixpkgs?ref=codimd/fix-sqlite/node12";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, nixos-2111, utils } @ inputs: rec {

    nixosConfigurations."fr-desktop" = let
      nixpkgs = nixos-2111;
    in nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        (import ./machines/fr-desktop/default.nix)
        #(builtins.toPath "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix")
      ];
#      specialArgs = { inherit inputs; };
    };

    nixosConfigurations."fr-laptop" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ (import ./machines/fr-laptop/default.nix) ];
#      specialArgs = { inherit inputs; };
    };

    nixosConfigurations."fr-yoga" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ (import ./machines/fr-yoga/default.nix) ];
#      specialArgs = { inherit inputs; };
    };

    nixosConfigurations."server2" = let
      #nixpkgs = nixpkgs-stable;
      #inputs = inputs // {inherit nixpkgs;};
    in nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        (import ./machines/server2/default.nix)
        (builtins.toPath "${nixpkgs}/nixos/modules/profiles/qemu-guest.nix")
      ];
#      specialArgs = { inherit inputs; };
    };

    #packages.x86_64-linux.defaultPackage = nixosConfigurations."fr-desktop";
  } // (utils.lib.eachSystem ["x86_64-linux" ] (system: rec {
    packages = {
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
