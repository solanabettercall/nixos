{ ... }:
{
  programs.eza = {
    enable = true;
    icons = "auto";
    git = true;
  };

  home.shellAliases = {
    ls  = "eza --icons --git";
    ll  = "eza --icons --git -lh";
    la  = "eza --icons --git -lah";
    lt  = "eza --icons --git --tree";
    tree = "eza --tree --icons --git-ignore";
  };
}