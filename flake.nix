{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    flake-utils-plus.url = "github:gytis-ivaskevicius/flake-utils-plus";

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

  outputs =
    {
      self,
      nixpkgs,
      flake-utils-plus,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
    in
    flake-utils-plus.lib.mkFlake rec {
      inherit self inputs;
      inherit (nixpkgs) lib;
      supportedSystems = [ system ];

      channels = {
        nixos-unstable = {
          input = nixpkgs;
        };
      };

      channelsConfig = {
        allowUnfreePredicate =
          pkg:
          builtins.elem (lib.getName pkg) [
            "cloudflare-warp"
          ];
      };

      hostDefaults = {
        inherit system;
        channelName = "nixos-unstable";
        specialArgs = { inherit system; };

      modules = [
        {
          nix = {
            generateNixPathFromInputs = true;
            generateRegistryFromInputs = true;
            linkInputs = true;
          };
        }

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
      };

      hosts = {
        bettercallsolana.modules = [
          ./hosts/bettercallsolana/configuration.nix
        ];
      };

      nixosModules.synced = import ./services/synced;

      homeConfigurations =
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          root = inputs.home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            modules = [
              { home.username = "root"; home.homeDirectory = "/root"; }
              ./users/root/home.nix
            ];
          };

          clackgot = inputs.home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            modules = [
              { home.username = "clackgot"; home.homeDirectory = "/home/clackgot"; }
              ./users/clackgot/home.nix
            ];
          };
        };
    };
}
