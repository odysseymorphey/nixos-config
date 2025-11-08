{
  description = "Nix configs + dev shell with nil & alejandra";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
  in {
    nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ./hosts/laptop/hardware-configuration.nix
        ./hosts/laptop/configuration.nix

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.nixos = import ./home/home.nix;
        }
      ];
    };

    environment.shells = [ pkgs.zsh ];

    formatter = (pkgs: pkgs.alejandra);
    devShells = (pkgs: {
      default = pkgs.mkShell {
        packages = with pkgs; [
          nil
          alejandra
          nixfmt-rfc-style
        ];
      };
    });
  };
}
