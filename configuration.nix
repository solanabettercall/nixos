{ pkgs, lib, ... }:
{
  imports = lib.filesystem.listFilesRecursive ./modules/system;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.systemPackages = with pkgs; [
    curl
    wget
  ];

  programs.zsh.enable = true;
  programs.nix-ld.enable = true;

  users.users.nixos.shell = pkgs.zsh;
  system.stateVersion = "25.05";
}