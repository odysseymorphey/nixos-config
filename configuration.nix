{ config, pkgs, lib, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.tmp.cleanOnBoot = true;

  time.timeZone = "Europe/Moscow";
  i18n.defaultLocale = "en_US.UTF-8";

  networking.hostName = "nixbook";
  networking.networkmanager.enable = true;

  users.users.nixos = {
    isNormalUser = true;
    description = "Odyssey Morphey";
    extraGroups = [ "wheel" "networkmanager" "audio" "video" "input" ];
    initialPassword = "1111";
  };

  nix.package = pkgs.nixVersions.stable;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  hardware.cpu.amd.updateMicrocode = true;

  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  services.xserver.desktopManager.xterm.enable = false;
  services.pulseaudio.enable = false;

  services.gnome.gnome-keyring.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  fileSystems."/" = {
    device = lib.mkForce "/dev/disk/by-label/nixos";
    fsType = "btrfs";
    options = [ "subvol=root" "compress=zstd" "noatime" ];
  };

  fileSystems."/home" = {
    device = lib.mkForce "/dev/disk/by-label/nixos";
    fsType = "btrfs";
    options = [ "subvol=home" "compress=zstd" ];
  };

  fileSystems."/nix" = {
    device = lib.mkForce "/dev/disk/by-label/nixos";
    fsType = "btrfs";
    options = [ "subvol=nix" "compress=zstd"];
  };

  fileSystems."/boot" = {
    device = lib.mkForce "/dev/disk/by-label/boot";
    fsType = "vfat";
  };

  services.snapper.configs = {
    root = {
      SUBVOLUME = "/";
      TIMELINE_CREATE  = true;
      TIMELINE_CLEANUP = true;
      TIMELINE_LIMIT_HOURLY  = 24;
      TIMELINE_LIMIT_DAILY   = 7;
      TIMELINE_LIMIT_WEEKLY  = 4;
      TIMELINE_LIMIT_MONTHLY = 3;
      TIMELINE_LIMIT_YEARLY  = 0;
    };

    home = {
      SUBVOLUME = "/home";
      TIMELINE_CREATE  = true;
      TIMELINE_CLEANUP = true;
      TIMELINE_LIMIT_HOURLY  = 24;
      TIMELINE_LIMIT_DAILY   = 7;
      TIMELINE_LIMIT_WEEKLY  = 4;
      TIMELINE_LIMIT_MONTHLY = 3;
      TIMELINE_LIMIT_YEARLY  = 0;
    };
  };


  services.flatpak.enable = true;
  xdg.portal.enable = true;
  services.fwupd.enable = true;

  environment.systemPackages = with pkgs; [
    git neovim wget curl
    pkgs.gnome-tweaks gnomeExtensions.dash-to-dock
    gnomeExtensions.appindicator gnomeExtensions.blur-my-shell
    gnomeExtensions.user-themes
    xdg-utils
    zip unzip p7zip
    go gopls delve
  ];

  security.sudo.wheelNeedsPassword = true;

  system.stateVersion = "25.05";
}
