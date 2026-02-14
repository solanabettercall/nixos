{ pkgs, ... }:

{
  home.packages = with pkgs; [
    httpie
    nmap
    nodejs_24
  ];

  home.shellAliases = {
    wscat = "npx wscat";
  };
}
