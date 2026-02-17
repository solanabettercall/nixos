{ pkgs, lib, ... }:

{
  imports = lib.filesystem.listFilesRecursive ./modules/home;

  home.stateVersion = "25.05";
}
