{ config, pkgs, ... }:

{
  imports = [
    ./modules/system/wsl.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # System packages (минимум, основное в home.nix)
  environment.systemPackages = with pkgs; [
    neovim
    curl
    wget
    git
  ];

  programs.zsh.enable = true;
  users.users.nixos.shell = pkgs.zsh;

  system.stateVersion = "25.05";
}
