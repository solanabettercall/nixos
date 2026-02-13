{ pkgs, ... }:

{
  imports = [
    ./modules/programs/zsh.nix
    ./modules/programs/git.nix
    ./modules/programs/cli-tools.nix
  ];

  home.stateVersion = "25.05";
}
