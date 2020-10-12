# { callPackage }:
#
# let
#   fetchTarballFromGitHub = { repo, owner, rev, sha256 }:
#     fetchTarball {
#       url = "https://github.com/${owner}/${repo}/archive/${rev}.tar.gz";
#       inherit sha256;
#     };
#
#   auralisationGitHub =
#
# in
# # Set with overrides
# # - devOverrides provides local overrides
# # - masterOverrides for getting latest from master
# # - stableOverrides for getting stable, fixed, values.
#
# {
#   # Refers to a local unfixed set of fixed values.
# #   local = callPackage ~/Code/libraries/auralisation-nix { };
#
#   # Refers to a remote fixed set of fixed values.
#   stable = auralisationGitHub;
#
#   # Refers to a local unfixed set of unfixed values.
#
#
# } // auralisationGitHub
