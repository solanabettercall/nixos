{ pkgs, ... }:

{
  home.packages = with pkgs; [
    eza      # ls
    bat      # cat
    
    tree
    btop

    jq
  ];

  programs.bat = {
    enable = true;
    config = {
      theme = "TwoDark";
      style = "plain";
      paging = "never";
    };
  };

  home.shellAliases = {
    htop = "btop";
  };  
}
