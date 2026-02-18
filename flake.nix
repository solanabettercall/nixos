{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    flake-utils-plus.url = "github:gytis-ivaskevicius/flake-utils-plus";

    nix-index-database = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/nix-index-database";
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

          ./common.nix
        ];
      };

      hosts = {
        bettercallsolana.modules = [
          ./machines/bettercallsolana/configuration.nix
        ];
      };

      nixosModules.synced = import ./services/synced;
    };
}
