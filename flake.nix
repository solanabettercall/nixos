{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    nix-index-database = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/nix-index-database";
    };

    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager/release-25.11";
    };

    sops-nix = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:Mic92/sops-nix";
    };
  };

  outputs = inputs@{ self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgsFor = import nixpkgs {
        inherit system;
        config.allowUnfreePredicate =
          pkg:
          builtins.elem (lib.getName pkg) [
            "cloudflare-warp"
          ];
      };

      commonModules = [
        ({ ... }: {
          nix = {
            registry = lib.mapAttrs (_: flake: { inherit flake; }) (builtins.removeAttrs inputs [ "self" ]);
            nixPath = lib.mapAttrsToList (name: flake: "${name}=${flake}") (builtins.removeAttrs inputs [ "self" ]);
          };
        })

        inputs.nix-index-database.nixosModules.nix-index
        { programs.nix-index-database.comma.enable = true; }

        inputs.home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.root = import ./users/root/home.nix;
          home-manager.users.clackgot = import ./users/clackgot/home.nix;
        }

        inputs.sops-nix.nixosModules.sops
        ./nixosModules
        ./common.nix
      ];
    in
    {
      nixosConfigurations = {
        bettercallsolana = lib.nixosSystem {
          inherit system;
          pkgs = pkgsFor;
          specialArgs = { inherit system; };
          modules = commonModules ++ [
            ./hosts/bettercallsolana/configuration.nix
          ];
        };
      };

      nixosModules.synced = import ./services/synced;
    };
}
