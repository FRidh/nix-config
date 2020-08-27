{
  description = "Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    #flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs } @ inputs: rec {

    nixosConfigurations."fr-desktop" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ (import ./machines/fr-desktop/default.nix) ];
      specialArgs = { inherit inputs; };
    };

    packages.x86_64-linux.defaultPackage = nixosConfigurations."fr-desktop";
  };
}
