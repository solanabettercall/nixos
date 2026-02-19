{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ls = "eza --icons --git";
      ll = "eza --icons --git -lh";
      la = "eza --icons --git -lah";
      lt = "eza --icons --git --tree";
      cat = "bat";
      tree = "eza --tree --icons --git-ignore";
      vim = "nvim";
    };

    initContent = ''
      # Навигация по словам
      bindkey "^[[1;5C" forward-word   # Ctrl+→
      bindkey "^[[1;5D" backward-word  # Ctrl+←
      bindkey "^[[H"    beginning-of-line  # Home
      bindkey "^[[F"    end-of-line        # End
      bindkey "^[[3~"   delete-char        # Delete
    '';
  };

  programs.starship = {
    enable = true;
    settings = import ../common/starship-settings.nix;
  };

  home.packages = with pkgs; [
    eza
    bat
  ];

  home.stateVersion = "25.11";
}