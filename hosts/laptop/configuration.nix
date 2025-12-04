{ config, pkgs, lib, ... }: {
  imports = [
    ./hardware-configuration.nix

    ../../modules/boot.nix
    ../../modules/locale.nix
    ../../modules/networking.nix
    ../../modules/users.nix
    ../../modules/nix.nix
    ../../modules/hardware.nix
    ../../modules/desktop-gnome.nix
    ../../modules/audio.nix
    ../../modules/filesystems-btrfs.nix
    ../../modules/snapper.nix
    ../../modules/services.nix
    ../../modules/packages.nix
    ../../modules/security.nix
  ];

  system.stateVersion = "25.05";
}
