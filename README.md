# nix-config
My Nix configuration files

## Machines

Has a .nix file per machine.

`ln -s path/to/nix-config/machines/<machine> /etc/nixos/configuration.nix`

## Users

Has a .nix file per user.

`ln -s path/to/nix-config/users/<user> /home/<user>/.nixpkgs/config.nix`

## Packages

Has expressions with package collections.

## Shells

Has expressions that can be used with `nix-shell`.
