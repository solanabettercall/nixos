{ config, pkgs, ... }: 
 
{ 
  wsl.enable = true; 
  wsl.defaultUser = "nixos"; 
 
  nix.settings.experimental-features = [ "nix-command" "flakes" ]; 
 
  environment.systemPackages = with pkgs; [ 
    git 
    neovim 
    curl 
    wget 
  ]; 

  programs.zsh.shellAliases = {
    vim = "nvim";
  };
  programs.zsh.enable = true;
  users.users.nixos.shell = pkgs.zsh;

  system.stateVersion = "25.05"; 
}
