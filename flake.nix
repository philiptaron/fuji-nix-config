{
  description = "Fuji (aarch64-linux) VM NixOS configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
  };

  outputs = inputs@{self, nixpkgs, ...}: {
    overlays = {
      default = import ./overlays.nix;
    };
    nixosConfigurations.fuji = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      modules = [
        { networking.hostname = "fuji"; }
        { system.stateVersion = "23.11"; }
        { nixpkgs.config.allowUnfree = true; }
        { nixpkgs.overlays = builtins.attrValues self.overlays; }
        { nix.registry.nixpkgs.flake = inputs.nixpkgs; }
        ./boot.nix
        ./network.nix
        ./nix.nix
        ./programs.nix
        ./user.nix
      ];
    };
  };
}
