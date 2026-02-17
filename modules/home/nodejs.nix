{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nodejs_24
  ];

  home.shellAliases = {
    wscat = "npx wscat";
  };
}