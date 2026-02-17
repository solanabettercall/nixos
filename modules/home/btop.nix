{ ... }:
{
  programs.btop = {
    enable = true;
  };

  home.shellAliases = {
    htop = "btop";
  };
}