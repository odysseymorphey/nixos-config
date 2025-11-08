{
  description = "Nix configs + dev shell with nil & alejandra";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

  outputs = {
    self,
    nixpkgs,
  }: let
    forAll = f:
      nixpkgs.lib.genAttrs [ "x86_64-linux" ] (
        system: f (import nixpkgs {inherit system;})
      );
  in {
    formatter = forAll (pkgs: pkgs.alejandra);
    devShells = forAll (pkgs: {
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
