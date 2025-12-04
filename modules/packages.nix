{ pkgs, ... }: {
    environment.systemPackages = with pkgs; [
    git neovim wget curl
    pkgs.gnome-tweaks
    gnomeExtensions.dash-to-dock
    gnomeExtensions.appindicator
    gnomeExtensions.blur-my-shell
    gnomeExtensions.user-themes
    xdg-utils
    zip unzip p7zip
    vscode
    go gopls delve
    docker-compose vagrant
    google-chrome
    hiddify-app
    postman
  ];
}
