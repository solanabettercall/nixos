{
  imports = [
    ./motd.nix
    ./nix.nix
    ./zsh/zsh.nix
  ];

  programs = {
    bat.enable = true;
    git.enable = true;
  };
}