{
  description = "Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs?ref=nixos-20.09";
    #nixpkgs.url = "github:WilliButz/nixpkgs?ref=codimd/fix-sqlite/node12";
    #nixpkgs.url = "git+https://github.com/WilliButz/nixpkgs?ref=codimd/fix-sqlite/node12";
    #flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, nixpkgs-stable } @ inputs: rec {

    nixosConfigurations."fr-desktop" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        (import ./machines/fr-desktop/default.nix)
        #(builtins.toPath "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix")
      ];
      specialArgs = { inherit inputs; };
    };

    nixosConfigurations."fr-laptop" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ (import ./machines/fr-laptop/default.nix) ];
      specialArgs = { inherit inputs; };
    };

    nixosConfigurations."fr-yoga" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ (import ./machines/fr-yoga/default.nix) ];
      specialArgs = { inherit inputs; };
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
      specialArgs = { inherit inputs; };
    };

    #packages.x86_64-linux.defaultPackage = nixosConfigurations."fr-desktop";
  };
}
