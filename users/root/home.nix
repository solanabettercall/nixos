{ pkgs, ... }: {
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
      bindkey "^[[1;5C" forward-word
      bindkey "^[[1;5D" backward-word
      bindkey "^[[H"    beginning-of-line
      bindkey "^[[F"    end-of-line
      bindkey "^[[3~"   delete-char
    '';
  };

  programs.starship = {
    enable = true;
    settings = import ../common/starship-settings.nix;
  };

  home.packages = with pkgs; [ eza bat ];

  home.stateVersion = "25.11";
}