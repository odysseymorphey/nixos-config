{ ... }: {
  users.users.nixos = {
    isNormalUser = true;
    description = "Odyssey Morphey";
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
