{ pkgs, stdenv, kdeVersion }:

with pkgs; [
] ++ stdenv.lib.optionals (kdeVersion==4) [
    kde4.akonadi
    kde4.ark
    kde4.filelight
    kde4.gwenview
    kde4.kdeconnect
    kde4.kdepim
    kde4.kdepim_runtime
    #kde4.kipi_plugins # Broken
    kde4.ksnapshot
    kde4.ktorrent
    kde4.yakuake
    kde4.kolourpaint
    kde4.konversation
    kde4.kile
] ++ stdenv.lib.optionals (kdeVersion==5) [
    kde5.plasma-desktop
]
