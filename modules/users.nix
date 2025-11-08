{ pkgs, ... }: {
  users.users.nixos = {
    isNormalUser = true;
    description = "Odyssey Morphey";
    shell = pkgs.zsh;
    extraGroups = [
      "wheel"
      "networkmanager"
      "audio"
      "video"
      "input"
    ];
    initialPassword = "1111";
  };
}
