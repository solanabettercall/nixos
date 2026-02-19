{ pkgs, ... }:
{
  imports = [
    ./motd.nix
    ./nix.nix
  ];

  programs = {
    bat.enable = true;
    git.enable = true;
    zsh.enable = true;
  };

  users.defaultUserShell = pkgs.zsh;
}
