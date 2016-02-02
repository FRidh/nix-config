# nix-config
My Nix configuration files

## Machines

Has a .nix file per machine.

`ln -s <path/to/repo/machines/<machine> /etc/nixos/configuration.nix`

## Users

Has a .nix file per user.

`ln -s <path/to/repo/users/<user> /home/<user>/.nixpkgs/config.nix`

## Packages

Has expressions with package collections.

