{ ... }:
{
  programs.bat = {
    enable = true;
    config = {
      theme = "TwoDark";
      style = "plain";
      paging = "never";
    };
  };

  home.shellAliases = {
    cat = "bat";
  };
}