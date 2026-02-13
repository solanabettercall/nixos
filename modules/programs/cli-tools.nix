{ pkgs, ... }:

{
  home.packages = with pkgs; [
    eza      # ls
    bat      # cat
    
    tree
  ];

  programs.bat = {
    enable = true;
    config = {
      theme = "TwoDark";
      style = "plain";
      paging = "never";
    };
  };
}
